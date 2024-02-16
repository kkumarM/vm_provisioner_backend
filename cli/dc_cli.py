#!/usr/bin/env python3 
# Copyright (C) 2024-2025 Baxter Healthcare Corporation
# SPDX-License-Identifier: Apache-2.0
# Author: Karthik Kumaar <karthikx_kumaar_mahudeeswaran@baxter.com>

from typing import (
    List,
)
from . import dc_utils
#import dc_utils
import cmd2
import argparse
import os
import sys
from cmd2 import (
    Bg,
    Fg,
    style,
    Cmd,
    Cmd2ArgumentParser,
    CompletionError,
    CompletionItem,
    ansi,
    with_argparser,
)

DC_TOOLS = [ 'data-sources','app-services','dl-model-services','dl-model-training-services',
                'dlstreamer-pipeline-services','edge-deployment-services','edge-inference-app-services',
                'edge-to-cloud-app-services','k8s-services','oneapi-toolkits','one-edge-building-blocks',
                'developer-tools']
DC_COMMANDS = ['install', 'uninstall']
DC_COMMANDS_WE = ['install', 'uninstall', 'enable', 'disable']
APP_COMMANDS = ['start', 'stop', 'restart']

SUB_TOOLS={
  "data-sources":['videos'],
  "developer-tools":['code-editor-tools','container-runtimes','automation-and-configuration','infrastructure-as-code','continous-integration','continous-deployment'],
  "app-services":['system-telemetry','cluster-telemetry','docker-telemetry','log-analytics','health-check'],  
  "dl-model-services":['dl-model-tools', 'inference-runtimes','featured-dl-models','openvino-samples-and-demos'],
  "dl-model-training-services":['data-engineering-tools', 'datasets', 'model-zoo', 'training-frameworks','ai-reference-kits'],
  "dlstreamer-pipeline-services":['audio-pipelines','dlstreamer-tools','multi-sensory-pipelines','video-pipelines'],
  "edge-deployment-services":['cross-plane','health-check','mass','vpshere-vm'],
  "edge-inference-app-services":['healthcare','industrial','market-places','media','retail','safety-security','transportation'],
  "edge-to-cloud-app-services":['seo-samples','seo-reference-implementations','seo-3rd-party-applications'],
  "k8s-services":['aether','kind','microk8s','kubeadm','minikube','rancher-k3s','rancher-rke2'],
  "oneapi-toolkits":['ai-analytics-toolkit','base-toolkit','intel-vtune','iot-toolkit','scikit-learn','xgboost','intel-optimized-python ','modin'],
  "one-edge-building-blocks":['csp-services','inference-services','observability-services']
}

TOOLS={
  "code-editor-tools":['jupyter-notebook','jupyter-lab','atom','sublime-text','notepad++','vscode'],
  "container-runtimes":['docker', 'docker-compose','containerd','cri-o'], 
  "dl-model-tools":['dl-model-benchmark', 'nncf', 'omz-tools', 'openvino-dl-workbench','openvino-model-server', 
                    'post-training-optimization-toolkit'],
  "inference-runtimes":['intel-optimized-pytorch', 'intel-optimized-tensorflow','onnx', 'openvino-2022.1', 'openvino-addon-tensorflow'],
  "openvino-samples-and-demos":['openvino-jupyter-notebooks','openvino-model-zoo-demos','openvino-samples'],
  "featured-dl-models":['bert-large-uncased-whole-word-masking-squad-int8-0001','deeplabv3','efficientdet-d0-tf','facenet-20180408-102900','mobilenet-ssd','object-detection-models','resnet-50-pytorch','ssdlite_mobilenet_v2','yolo-v4-tf'],
  "model-zoo":['intel-ai-model-zoo','pytorch-model-zoo','tensorflow-hub','intel-openvino-model-zoo'],
  "data-engineering-tools":['cvat','datumaro'],
  "datasets":['face-detection','face-mask-detection','fake-face-detection','flowers-recognition'],
  "ai-reference-kits":['customer-chatbot','intelligent-indexing','predictive-health-analytics','visual-quality-inspection'],
  "object-detection-models":['face-detection-retail-0005','pedestrian-detection-adas-0002','person-detection-retail-0002','vehicle-detection-adas-0002'],
  "object-recognition-models":['age-gender-recognition-retail-0013','head-pose-estimation-adas-0001'],
  "training-frameworks":['intel-optimized-pytorch','intel-optimized-tensorflow','kubeflow','openvino-training-extensions','sonoma-creek','sigopt','bigdl','cnvrg'],
  "dlstreamer-tools":['dlstreamer-pipeline-framework','dlstreamer-pipeline-server','dlstreamer-pipeline-zoo','dlstreamer-pipeline-benchmark','gst-shark'],
  "audio-pipelines":['audio-event-detection-sample'],
  "video-pipelines":['action-recognition-sample','human-pose-estimation-sample','vehicle-pedestrian-tracking-sample','face-detection-classicification-sample','gvapython-sample','metadata-publishing-sample'],
  "multi-sensory-pipelines":['multi-sensor-pipeline'],
  "healthcare":['brain-tumor-segmentation','monai','openfl'],
  "industrial":['edge-controls-for-industrial','edge-insights-for-amr','edge-insights-for-industrial','industrial-surface-defect-detection','industrial-textline-recognition','rotor-bearing-defect-detector','textile-defect-classifier','weld-porosity-detection'],
  "market-places":['artifactory','dev-catalog','kube-apps','mrs','rrk'],
  "media":['ad-insertion','cdn-transcode-sample','immersive-video-sample','open-visual-cloud','smart-city','video-curation-sample'],
  "retail":['automated-checkout','edgex','interactive-kiosk-ai-chatbot','real-time-sensor-fusion-for-loss-detection','social-distancing-for-retail-settings'],
  "safety-security":['edge-aibox-for-video-analytics','edge-insights-for-vision','smart-video-and-ai-workload','social-distancing-for-retail-settings'],
  "transportation":['address-recognition-and-analytics','automatic-license-plate-recognition','cargo-management','drive-behavior-analytics','edge-insights-for-fleet','intelligent-traffic-management','public-transit-analytics','vehicle-event-recording','workzone-analytics'],
  "seo-samples":['openvino-sample-application-in-openness','sample-eaa-test-application','telemetry-sample','video-analytics-services-sample-application-in-openness'],
  "seo-reference-implementations":['intelligent-connection-management-for-automated-handover','smartvr–livestreaming-of-immersive-media','telehealth-remote-monitoring','wireless-network-ready-intelligent-traffic-management','wireless-network-ready-pcb-defect-detection','network-optimization-and-ai-inferencing-management-for-telepathology'],
  "seo-3rd-party-applications":['a5gnetworks','herta','orbo','qwilt','radisys'],
  "csp-services":['aws-greengrass','azure-iot-central','azure-iot-edge','azure-iot-hub'],
  "inference-services":['dlstreamer','dlstreamer-pipeline-server','openvino-container','openvino-model-server'],
  "observability-services":['system-telemetry','cluster-telemetry','docker-telemetry','log-analytics'],
  "automation-and-configuration":['ansible','chef','puppet'], 
  "infrastructure-as-code":['terraform','pulumi','cross-plane'],
  "continous-integration":['github-actions','tekton','jenkins'],
  "continous-deployment":['jenkins-X','argocd'],
  "videos":['bolt-multi-size-detection','fruit-and-vegetable-detection','people-detection','bottle-detection','head-pose-face-detection-female','person-bicycle-car-detection','car-detection','head-pose-face-detection-female-and-male','store-aisle-detection','classroom','head-pose-face-detection-male','worker-zone-detection',
  'face-demographics-walking','face-demographics-walking-and-pause','one-by-one-person-detection','bolt-detection']

}

# List contains service which are having enable and disable scripts
enable_list = ['openvino-dl-workbench', 'sigopt','tekton','argocd',
'dlstreamer','dlstreamer-pipeline-server','dlstreamer-pipeline-zoo','dlstreamer-pipeline-composer',
'audio-event-detection-sample',
'action-recognition-sample','human-pose-estimation-sample','vehicle-pedestrian-tracking-sample','face-detection-classification-sample','gvapython-sample','metadata-publishing-sample']

enable_list_k8s = ['kind','microk8s','minikube','rancher-k3s','rancher-rke2']

class DC(cmd2.Cmd):
    CUSTOM_CATEGORY = 'My Custom Commands'
    def __init__(self):
        super().__init__(
            multiline_commands=['echo'],
            persistent_history_file='cmd2_history.dat',
            startup_script='scripts/startup.txt',
            include_ipy=True,
            allow_cli_args=False,
            silence_startup_script=True
        )
        """"Set up interactive command line interface."""
        # delete unused commands that are baked-into cmd2 and set some options
        del cmd2.Cmd.do_py
        del cmd2.Cmd.do_edit
        del cmd2.Cmd.do_shortcuts
        del cmd2.Cmd.do_run_pyscript
        del cmd2.Cmd.do_run_script
        del cmd2.Cmd.do_ipy
        del cmd2.Cmd.do_history
        #del cmd2.Cmd.do_shell
        #del cmd2.Cmd.do_set
        #del cmd2.Cmd.do_alias
        del cmd2.Cmd.do_macro
        #del cmd2.Cmd.do_quit
        del cmd2.Cmd.do__relative_run_script
        
        cmd2.Cmd.abbrev = True
        self.allow_cli_args = False  # disable parsing of command-line args by cmd2
        self.allow_redirection = False  # disable redirection to enable right shift (>>) in custom_hash to work
        self.redirector = '\xff'  # disable redirection in the parser as well
        #self.shortcuts.update({'sh': 'show'})  # don't want "sh" to trigger the hidden "shell" command

        # init cmd2 and the history file
        #cmd2.Cmd.__init__(self, persistent_history_file=hist_file, persistent_history_length=200)

        # disable help on builtins
        #self.hidden_commands.append('shell')
        self.hidden_commands.append('exit') 
        self.hidden_commands.append('intro')
        self.hidden_commands.append('echo')

        # Prints an intro banner once upon application startup
        self.intro = style('Welcome to Intel Devcloud! \n An Interactive CLI to Install Devcloud tools & Components', fg=Fg.BLUE, bg=Bg.BLACK, bold=True)

        # Show this as the prompt when asking for input
        self.prompt = style('$>',fg=Fg.GREEN, bold=True)

        # Used as prompt for multiline commands after the first line
        self.continuation_prompt = '... '

        # Allow access to your application in py and ipy via self
        self.self_in_py = True

        # Set the default category name
        self.default_category = 'cmd2 Built-in Commands'

        # Color to output text in with echo command
        self.foreground_color = Fg.CYAN.name.lower()

        # Make echo_fg settable at runtime
        fg_colors = [c.name.lower() for c in Fg]
        self.add_settable(
            cmd2.Settable('foreground_color', str, 'Foreground color to use with echo command', self, choices=fg_colors)
        )

        # For Pyinstaller Binary temp folder
        self.bundle_dir = getattr(sys, '_MEIPASS', os.path.abspath(os.path.dirname(__file__)))
    
    @cmd2.with_category(CUSTOM_CATEGORY)
    def do_intro(self, _):
        """Display the intro banner"""
        self.poutput(self.intro)

    @cmd2.with_category(CUSTOM_CATEGORY)
    def do_echo(self, arg):
        """Example of a multiline command"""
        fg_color = Fg[self.foreground_color.upper()]
        self.poutput(style(arg, fg=fg_color))

    '''
    eval_parser=cmd2.Cmd2ArgumentParser(description='Obtain the eval command')
    eval_parser.add_argument("Dev-Tools",help="Help for Dev-Tools")

    @cmd2.with_argparser(eval_parser)
    '''
    def do_dc(self, statement: cmd2.Statement):
        """Tab completes first 3 arguments using index_based_complete"""
        #dc_utils.aptGet_uninstall("vim")
        #dc_utils.aptGet_install("vim")
        self.poutput("Args: {}".format(statement.args))
        argsList = statement.args.split(' ')        
        print("length of args:", len(argsList))

        
        if len(argsList)>6:
            self.poutput("Invalid Args: {}".format(statement.args))        
            
        if len(argsList) >= 4:
            typeName=argsList[0]
            toolName=argsList[1]
            subtoolName=argsList[2]
            commandName=argsList[3]        
            print("{0} : {1} : {2} : {3}".format(typeName,toolName,subtoolName,commandName))
            print("cd:",os.getcwd())
            installation_path = self.bundle_dir + "/scripts/" + typeName + '/' + toolName + '/' + subtoolName + '/' + commandName
            self.poutput(installation_path)
            # checking the argList if any command line args given after install
            if len(argsList)>4 and len(argsList)<6:
                dc_utils.processArgs(installation_path,serviceName=argsList[4])
            else:
                dc_utils.processArgs(installation_path,serviceName="")
        
        if len(argsList) == 3:
            typeName=argsList[0]
            toolName=argsList[1]
            commandName=argsList[2]        
            print("{0} : {1} : {2}".format(typeName,toolName,commandName))
            print("cd:",os.getcwd())
            installation_path = self.bundle_dir + "/scripts/" + typeName + '/' + toolName + '/' + commandName
            self.poutput(installation_path)
            # checking the argList if any command line args given after install
            if len(argsList)>3 and len(argsList)<5:
                dc_utils.processArgs(installation_path,serviceName=argsList[3])
            else:
                dc_utils.processArgs(installation_path,serviceName="")
                
    def complete_dc(self, text, line, begidx, endidx) -> List[str]:
        """Completion function for do_index_based"""
        SUB_TOOLS_1=[]
        CMD_TOOLS=[]
        TM_TOOLS=[]
        APP_TOOLS=[]
        CMD_TOOLS_WE=[]
        CMD_TOOLS_WE1=[]
        index_dict={}      
        
        if begidx>3:
            for t in SUB_TOOLS:    
                # print("t:",t)            
                if line.__contains__(t):                    
                    SUB_TOOLS_1=SUB_TOOLS[t]
                    # print("subtools:", SUB_TOOLS[t])
                    CMD_TOOLS = DC_COMMANDS
                    if t == "app-services":
                       APP_TOOLS =APP_COMMANDS                

                for st in TOOLS:
                    if line.__contains__(st):
                        #print(TOOLS[st])
                        TM_TOOLS = TOOLS[st] 

            for k8s_t in SUB_TOOLS_1:
                    if line.__contains__(k8s_t):
                        if k8s_t in enable_list_k8s:
                            CMD_TOOLS_WE1 = DC_COMMANDS_WE  
            
            for et in TM_TOOLS: 
                if line.__contains__(et):               
                    if et in enable_list:
                        CMD_TOOLS_WE = DC_COMMANDS_WE                       

        if len(TM_TOOLS) != 0 and len(CMD_TOOLS_WE) == 0:                
            index_dict = {
                1: DC_TOOLS,  # Tab complete food items at index 1 in command line
                2: SUB_TOOLS_1,  # Tab complete sport items at index 2 in command line
                3: TM_TOOLS,
                4: CMD_TOOLS  # Tab complete using path_complete function at index 3 in command line
                 
            }
        elif len(CMD_TOOLS_WE) != 0:                
            index_dict = {
                1: DC_TOOLS,  # Tab complete food items at index 1 in command line
                2: SUB_TOOLS_1,  # Tab complete sport items at index 2 in command line
                3: TM_TOOLS,
                4: CMD_TOOLS_WE  # Tab complete using path_complete function at index 3 in command line
                 
            }
        elif len(APP_TOOLS) != 0:
            index_dict = {
                1: DC_TOOLS,  # Tab complete food items at index 1 in command line
                2: SUB_TOOLS_1,  # Tab complete sport items at index 2 in command line
                3: APP_TOOLS,  # Tab complete using path_complete function at index 3 in command line
                
            }
        elif len(CMD_TOOLS_WE1) != 0:
            index_dict = {
                1: DC_TOOLS,  # Tab complete food items at index 1 in command line
                2: SUB_TOOLS_1,  # Tab complete sport items at index 2 in command line
                3: CMD_TOOLS_WE1,  # Tab complete using path_complete function at index 3 in command line
                
            }
        else:
            # print("Inside else")
            index_dict = {
                1: DC_TOOLS,  # Tab complete food items at index 1 in command line
                2: SUB_TOOLS_1,  # Tab complete sport items at index 2 in command line
                3: CMD_TOOLS,  # Tab complete using path_complete function at index 3 in command line
                
            }

        return self.index_based_complete(text, line, begidx, endidx, index_dict=index_dict)
        #return self.path_complete(text, line, begidx, endidx)
 

def main():
    app = DC()
    app.cmdloop()

#if __name__ == "__main__":
#   main()



