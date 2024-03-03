#! /usr/bin/env python3

# Copyright (C) 2024-2025 Baxter Corporation
# SPDX-License-Identifier: Apache-2.0
# Author: Karthik Kumaar <karthik_kumaar_mahudeeswaran@baxter.com>

from flask import Flask, jsonify, request,send_from_directory, make_response, Response
from flask_cors import CORS, cross_origin
from werkzeug.utils import secure_filename
from functools import wraps
from file import file_transfer
from vm_status import VMStatus
from reset_vm import ResetVM
from your_workloads import insert_your_workloads
from cart_status import CartStatus
from vault import GetKeys

import os
import json 
import time
import jwt
import subprocess
import threading

app = Flask(__name__)
app.config['SECRET_KEY'] = GetKeys().SECRET_KEY

def token_required(f):
    @wraps(f)    
    def verify(*args, **kwargs):
        token = request.headers.get('Authorization')
        token = token.split(" ")

        if not token:
            return jsonify({'message':'Token is missing!'}), 403
        try:
            data = jwt.decode(token[1], app.config['SECRET_KEY'],algorithms=["HS256"])
        except:
            return jsonify({"message" : "Token is invalid!"}), 403

        return f(*args, **kwargs)
    return verify

@app.route("/check_job_cart", methods = ['POST','GET'])
@cross_origin(origin = '*', headers=['Access-Control-Allow-Origin','Content-Type','Content-Disposition'])
#@token_required
def check_job_cart():
    # Function to check similar VM's are added in the cart
    user = request.args.get("user")
    vm_id = request.args.get("system_id")
    clear = request.args.get("clear")
    obj = CartStatus(user, vm_id)
    if clear == "false":
        response = obj.update_cart()
        return jsonify(response)
    if clear == "true": 
        response = obj.delete_cart()
        return jsonify(response)

@app.route("/provisioning", methods = ['POST','GET'])
@cross_origin(origin = '*', headers=['Access-Control-Allow-Origin','Content-Type','Content-Disposition'])
def hw_provisioning():
    result = False
    host_ip = os.getenv("HOST_IP")
    data = request.get_json() 
    print("data:", data)
    user = data["user_info"]["username"]    
    target_node_ip = data["hardware_configuration"]["selected_hardware"][0]["IP"]
    target_node_id = data["hardware_configuration"]["selected_hardware"][0]["System_ID"]
    vm_status = data["hardware_configuration"]["selected_hardware"][0]["Status"]
    instance_type = data["workload_configuration"]["edge_device_configuration"]["instance_type"]
    workload_type = data["workload_configuration"]["edge_device_configuration"]["workload_type"]
    cluster_type = data["workload_configuration"]["edge_device_configuration"]["cluster_type"]
    print("Cluster_type:", cluster_type)

    # Check the selected HW is Vm or BM
    if instance_type == "Bare Metal" and workload_type == "Native": 
        result = file_transfer(data,app.instance_path)
        obj = VMStatus(target_node_ip, target_node_id, user)
        obj.update_db_status(False,False,True,False)  

    if instance_type == "VM" and workload_type == "Native":
        # Start the VM
        obj = VMStatus(target_node_ip, target_node_id, user)
        ret = obj.vm_start() 
        
        obj.update_db_status(True,False,False,False)

    if instance_type == "Bare Metal" and workload_type == "Kubernetes" and \
        cluster_type != "Smart Edge Open": 
        if cluster_type == "OpenShift":
            result = file_transfer(data,app.instance_path)
            obj = VMStatus(target_node_ip, target_node_id, user)
            obj.update_openshift_db_status(False,False,False,True)
        else:
            result = file_transfer(data,app.instance_path)
            obj = VMStatus(target_node_ip, target_node_id, user)
            obj.update_db_status(False,False,True,False)

    if instance_type == "VM" and workload_type == "Kubernetes" and \
        cluster_type != "Smart Edge Open":
        if cluster_type == "OpenShift":
            result = file_transfer(data,app.instance_path)
            obj = VMStatus(target_node_ip, target_node_id, user)
            obj.update_openshift_db_status(False,False,True,False)
        else:
            obj = VMStatus(target_node_ip, target_node_id, user)
            ret = obj.vm_start() 
            obj.update_db_status(True,False,False,False)    

    if instance_type == "VM" and workload_type == "Kubernetes" and \
        cluster_type == "Smart Edge Open":
        target_seo_id = target_node_id.lower()
        print("target_seo_id:", target_seo_id)
        obj = VMStatus(target_node_ip, target_seo_id, user)        
        obj.update_seo_db_status(False,False,True,False)        

    if instance_type == "Bare Metal" and workload_type == "Kubernetes" and \
        cluster_type == "Smart Edge Open": 
        result = file_transfer(data,app.instance_path)
        obj = VMStatus(target_node_ip, target_node_id, user)
        obj.update_seo_db_status(False,False,False,True)
    
    result = file_transfer(data,app.instance_path)

    # If Workload type is "Your Own" add it in Market place item 
    if data["pre_defined_workloads"]["workload"] == "Your Own":
        insert_your_workloads(data)
                
    if result:
        return Response("{'success':'Edge Node Provisioning Completed'}", status=200,mimetype='application/json')
    else:
        return Response("{'success':'Target Node is not accessible'}", status=401,mimetype='application/json')

@app.route("/upload_files", methods = ['POST','GET'])
@cross_origin(origin = '*', headers=['Access-Control-Allow-Origin', 'Content-Type','multipart/form-data'])
@token_required
def get_source():
    host_ip = os.getenv("HOST_IP")

    print(request.files)    
    files = request.files.getlist('file')
    print("files:", (files))
             
    user = request.args.get("user")
    model_type = request.args.get("model_type")
    precision = request.args.get("precision")
    target_node_ip = request.args.get("ip")
    workload_upload = request.args.get("workload_upload")
    source_url = request.args.get("source_url")
    system_id = request.args.get("system_id")

    print("user:", user)
    print("target_node_ip:", target_node_ip)
    print("source_URL:", source_url)
    print("workload_upload:", workload_upload)
    print("system_id:", system_id)
    
    workload = '{}/workload'.format(user)
    models = '{}/models/{}'.format(user,precision)
    results = '{}/results'.format(user)
    streams = '{}/streams'.format(user) 
    temp = '{}/temp'.format(user)   

    if not os.path.exists(app.instance_path):
        os.umask(0)        
        os.makedirs(os.path.join(app.instance_path),mode=0o777)
    else:
        os.chmod(app.instance_path,0o777)    


    # Create appropriate direcories
    workload_dir = os.path.join(app.instance_path,workload)
    models_dir = os.path.join(app.instance_path,models)
    results_dir = os.path.join(app.instance_path,results)
    streams_dir = os.path.join(app.instance_path,streams)
    temp_dir = os.path.join(app.instance_path,temp)
    
    # Check if directory exists or not
    if not os.path.exists(workload_dir):
        os.makedirs(workload_dir)
    if not os.path.exists(models_dir):
        os.makedirs(models_dir)
    if not os.path.exists(results_dir):
        os.makedirs(results_dir)
    if not os.path.exists(streams_dir):
        os.makedirs(streams_dir)
    if not os.path.exists(temp_dir):
        os.makedirs(temp_dir)

    # Create directories for Results folder 
    if not os.path.exists(results_dir + '/logs'):
        os.makedirs(results_dir + '/logs')
    if not os.path.exists(results_dir + '/telemetry'):
        os.makedirs(results_dir + '/telemetry')
    if not os.path.exists(results_dir + '/video_store'):
        os.makedirs(results_dir + '/video_store')
    if not os.path.exists(results_dir + '/analytics'):
        os.makedirs(results_dir + '/analytics')
    if not os.path.exists(results_dir + '/performance_profile'):
        os.makedirs(results_dir + '/performance_profile')
    if not os.path.exists(results_dir + '/benchmark_reports'):
        os.makedirs(results_dir + '/benchmark_reports')

    print("Directory's created.....")   

    # if source_url != "":
    #     subprocess.check_output("git clone {}".format(source_url), cwd=workload_dir, shell=True)
      
    if len(files) != 0:        
        for i in files:            
            # Get the uplaode file's extension 
            file_extension = i.filename.split('.')[1]        
            
            if file_extension == "mp4":
                i.save(os.path.join(streams_dir,secure_filename(i.filename)))
            #elif file_extension == "png" or file_extension == "jpg":

            elif file_extension == "xml" or file_extension == "bin":
                i.save(os.path.join(models_dir,secure_filename(i.filename)))
            else:
                i.save(os.path.join(workload_dir,secure_filename(i.filename)))
            
        return jsonify({"status" : "Files uploaded Successfully", 
        "ssh_url" : "http://{}:2222/ssh/host/127.0.0.1".format(target_node_ip),
        "log_url" : "http://{}:3214".format(target_node_ip),
        "telemetry_url": "http://{}:3000".format(target_node_ip),
        "analytics_url":"http://{}:8000".format(target_node_ip),
        "video_url":"http://10.224.79.153:6090",
        "results_url":"http://{}:8090".format(target_node_ip),
        "performance_url":"http://{}:7788".format(target_node_ip),
        "smartcity_url":"http://{}:5000/get_all_streams".format(target_node_ip),
        "minikube_url": "http://{}:8001/api/v1/namespaces/kubernetes-dashboard/services/http:kubernetes-dashboard:/proxy/".format(target_node_ip),
        "microk8s_url":"http://{}:32000".format(target_node_ip),
        "rancher_rke2_url":"http://{}:7050".format(target_node_ip),
        "rancher_k3s_url":"https://{}:30040".format(target_node_ip),
        "kubeadm_url":"https://{}:30050".format(target_node_ip),
        "aether_url" : "http://{}:31194".format(target_node_ip)})
     
    else:
        return jsonify({"status" : "Deployed Sample Application in Target Machine",
        "ssh_url" : "http://{}:2222/ssh/host/127.0.0.1".format(target_node_ip),
        "log_url" : "http://{}:3214".format(target_node_ip),
        "telemetry_url": "http://{}:3000".format(target_node_ip),
        "analytics_url":"http://{}:8000".format(target_node_ip),
        "video_url":"http://10.224.79.153:6090",
        "results_url":"http://{}:8090".format(target_node_ip),
        "performance_url":"http://{}:7788".format(target_node_ip),
        "smartcity_url":"http://{}:5000/get_all_streams".format(target_node_ip),
        "minikube_url": "http://{}:8001/api/v1/namespaces/kubernetes-dashboard/services/http:kubernetes-dashboard:/proxy/".format(target_node_ip),
        "microk8s_url":"http://{}:32000".format(target_node_ip),
        "rancher_rke2_url":"http://{}:7050".format(target_node_ip),
        "rancher_k3s_url":"https://{}:30040".format(target_node_ip),
        "kubeadm_url":"https://{}:30050".format(target_node_ip),
        "aether_url" : "http://{}:31194".format(target_node_ip)})


@app.route("/startVM", methods = ['POST','GET'])
@cross_origin(origin = '*', headers=['Access-Control-Allow-Origin','Content-Type','Content-Disposition'])
@token_required
def start_vm():
    ret = ""
    vm_data = request.get_json()
    print("vm_data:", vm_data)
    user = vm_data["user_info"]["username"]
    target_node_ip = vm_data["hardware_configuration"]["selected_hardware"][0]["IP"]
    target_node_id = vm_data["hardware_configuration"]["selected_hardware"][0]["System_ID"]
    vm_status = vm_data["hardware_configuration"]["selected_hardware"][0]["Status"]
    
    instance_type = vm_data["workload_configuration"]["edge_device_configuration"]["instance_type"]
    workload_type = vm_data["workload_configuration"]["edge_device_configuration"]["workload_type"]
    cluster_type = vm_data["workload_configuration"]["edge_device_configuration"]["cluster_type"]
    # Check the selected HW is Vm or BM
    if instance_type == "VM" and workload_type == "Native":
        # Start the VM
        obj = VMStatus(target_node_ip, target_node_id, user)
        ret = obj.vm_start() 
        obj.update_db_status(True,False,False,False)

    if instance_type == "VM" and workload_type == "Kubernetes" and \
        cluster_type != "Smart Edge Open":
        if cluster_type == "OpenShift":
            obj = VMStatus(target_node_ip, target_node_id, user)
            ret = obj.vm_start() 
            obj.update_openshift_db_status(True,False,False,False)
        else:        
            obj = VMStatus(target_node_ip, target_node_id, user)
            ret = obj.vm_start() 
            obj.update_db_status(True,False,False,False)    

    if workload_type == "Kubernetes" and cluster_type == "Smart Edge Open":
        target_seo_id = target_node_id.lower()
        obj = VMStatus(target_node_ip, target_seo_id, user)
        ret = obj.vm_start() 
        obj.update_seo_db_status(True,False,False,False)
    return ret

@app.route("/stopVM", methods = ['POST','GET'])
@cross_origin(origin = '*', headers=['Access-Control-Allow-Origin','Content-Type','Content-Disposition'])
@token_required
def stop_vm():
    ret = ""
    vm_data = request.get_json()
    print("vm_data:", vm_data)
    user = vm_data["user_info"]["username"]
    target_node_ip = vm_data["hardware_configuration"]["selected_hardware"][0]["IP"]
    target_node_id = vm_data["hardware_configuration"]["selected_hardware"][0]["System_ID"]
    vm_status = vm_data["hardware_configuration"]["selected_hardware"][0]["Status"]
    
    instance_type = vm_data["workload_configuration"]["edge_device_configuration"]["instance_type"]
    workload_type = vm_data["workload_configuration"]["edge_device_configuration"]["workload_type"]
    cluster_type = vm_data["workload_configuration"]["edge_device_configuration"]["cluster_type"]
    # Check the selected HW is Vm or BM    
    if instance_type == "VM" and workload_type == "Native":
        # Stop the VM
        obj = VMStatus(target_node_ip, target_node_id, user)
        ret = obj.vm_stop() 
        obj.update_db_status(False,True,False,False) 

    if instance_type == "VM" and workload_type == "Kubernetes" and \
        cluster_type != "Smart Edge Open":
        # Stop the VM
        if cluster_type == "OpenShift":
            obj = VMStatus(target_node_ip, target_node_id, user)
            ret = obj.vm_stop() 
            obj.update_openshift_db_status(False,True,False,False) 
        else: 
            obj = VMStatus(target_node_ip, target_node_id, user)
            ret = obj.vm_stop() 
            obj.update_db_status(False,True,False,False)  

    if workload_type == "Kubernetes" and cluster_type == "Smart Edge Open":        
        target_seo_id = target_node_id.lower()
        obj = VMStatus(target_node_ip, target_seo_id, user)
        ret = obj.vm_stop() 
        obj.update_seo_db_status(False,True,False,False)  
    return ret

@app.route("/resetVM", methods = ['POST','GET'])
@cross_origin(origin = '*', headers=['Access-Control-Allow-Origin','Content-Type','Content-Disposition'])
@token_required
def reset_vm():
    try:
        data = request.get_json()
        print("Data:", data)
        user = data["user_info"]["username"]
        target_node_id = data["hardware_configuration"]["selected_hardware"][0]["System_ID"]
        target_node_ip = data["hardware_configuration"]["selected_hardware"][0]["IP"]
        instance_type = data["workload_configuration"]["edge_device_configuration"]["instance_type"]
        workload_type = data["workload_configuration"]["edge_device_configuration"]["workload_type"] 
        cluster_type = data["workload_configuration"]["edge_device_configuration"]["cluster_type"]
        
        obj = ResetVM(user, target_node_id, target_node_ip, instance_type, workload_type, cluster_type)
        
        # Delete SSH and RDP access for the particular VM
        res = obj.delete_remote_access()
        print(res)

        if instance_type == "VM" and workload_type == "Native":
            obj.vm_reset()
            obj.update_db_status(True,False,False,False) 
        if instance_type == "Bare Metal" and workload_type == "Native":
            obj.bm_reset()
            obj.update_db_status(False,True,False,False)
        if instance_type == "VM" and workload_type == "Kubernetes" and \
            cluster_type != "Smart Edge Open":
            if cluster_type == "OpenShift":
                obj.vm_reset()
                obj.update_openshift_db_status()
            else:  
                obj.vm_reset()
                obj.update_db_status(True,False,False,False)
        if instance_type == "Bare Metal" and workload_type == "Kubernetes" and \
            cluster_type != "Smart Edge Open":
            if cluster_type == "OpenShift":
                obj.bm_reset()
                obj.update_openshift_db_status()
            else:
                obj.bm_reset()
                obj.update_db_status(False,True,False,False)  
        
        if instance_type == "VM" and workload_type == "Kubernetes" and \
            cluster_type == "Smart Edge Open":
            target_seo_id = target_node_id  
            seo_obj = ResetVM(user, target_seo_id, target_node_ip, instance_type, workload_type, cluster_type)      
            reset_status = seo_obj.vm_reset()
            # Check the status of the VM after snapshot. SEO VM's will take some time to up.
            # tool status will provide the current state of the VM
            status_obj = VMStatus(target_node_ip, target_seo_id, user)
            tool_status = status_obj.check_vm_tools_status()
            print("Tool_Status:", tool_status)
            if tool_status == "NOT_RUNNING":
                thread = threading.Thread(target=check_seoVM_status, args=[seo_obj, status_obj])
                thread.daemon = True
                thread.start() 

        if instance_type == "Bare Metal" and workload_type == "Kubernetes" and \
            cluster_type == "Smart Edge Open":        
            obj.vm_reset() # Same for both vm and bm
            status_obj = VMStatus(target_node_ip, target_seo_id, user)            
            obj.update_db_status(False,False,False,True)

        

        return "VM Restored successfully"
    except Exception as e:
        print("Error in Reset VM:",e)
        return "VM Not Restored"


def check_seoVM_status(seo_obj, status_obj):
    print("object():", seo_obj)    
    while True:
        ret_status = status_obj.check_vm_tools_status()
        print("return status for reset:", ret_status)
        if ret_status == "RUNNING":
            seo_obj.update_db_status(False,False,True,False)
            break
        else:
            seo_obj.set_db_to_inprogress()
            time.sleep(5)


def reset_vm_if_error(data):
    #Function to reset the VM, In case if any Error Occurs during Provisioning, then retry
    try:
        user = data["user_info"]["username"]
        target_node_id = data["hardware_configuration"]["selected_hardware"][0]["System_ID"]
        target_node_ip = data["hardware_configuration"]["selected_hardware"][0]["IP"]
        instance_type = data["workload_configuration"]["edge_device_configuration"]["instance_type"]
        workload_type = data["workload_configuration"]["edge_device_configuration"]["workload_type"] 
        cluster_type = data["workload_configuration"]["edge_device_configuration"]["cluster_type"]
        if instance_type == "VM" and workload_type == "Native":
            vm_reset(target_node_id)
            update_db_status(target_node_id,target_node_ip,True,False,False,False) 
        if instance_type == "Bare Metal" and workload_type == "Native":
            bm_reset(target_node_id, target_node_ip)
            update_db_status(target_node_id,target_node_ip,False,True,False,False)
        if instance_type == "VM" and workload_type == "Kubernetes" and \
            cluster_type != "Smart Edge Open":
            vm_reset(target_node_id)
            update_db_status(target_node_id,target_node_ip,True,False,False,False) 
        if instance_type == "Bare Metal" and workload_type == "Kubernetes" and \
            cluster_type != "Smart Edge Open":
            bm_reset(target_node_id, target_node_ip)
            update_db_status(target_node_id,target_node_ip,False,True,False,False)  
        
        if workload_type == "Kubernetes" and cluster_type == "Smart Edge Open":        
            target_seo_id = target_node_id.lower()
            vm_reset(target_seo_id)
            update_db_status(target_node_id,target_node_ip,False,False,True,False)
        return "Success"

    except Exception as e:
        print("Error in VM error:",e)
        return "Not Success"    