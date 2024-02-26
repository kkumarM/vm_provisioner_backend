#!/usr/bin/env python3 

from flask import Flask
from get_vms import get_vm_list

app = Flask(__name__)

@app.route("/get_hw_details",methods=['GET'])
def get_vm():
    data = get_vm_list()
    return data

if __name__ == "__main__":
   app.run(host='0.0.0.0', port= 5000, debug= True)