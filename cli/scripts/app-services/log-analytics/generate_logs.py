#! /usr/bin/env python3
# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0
# Author: Karthik Kumaar <karthikx.kumaar@intel.com>

import docker
import subprocess
import threading
from http.server import HTTPServer, BaseHTTPRequestHandler
import ssl
import time
import os 
import json
import requests
#client = docker.APIClient(base_url='unix://var/run/docker.sock')


def get_logs():
  if not os.path.exists('results/logs'):
      os.makedirs('results/logs')

  client = docker.from_env()
  running_container = client.containers.list()
  if len(running_container) != 0:
    container_ID = [container.short_id for container in running_container]
    print(container_ID)  
    container_name = [container.name for container in running_container]

    for container in running_container:
      logs = client.containers.get(container.short_id).logs(stream = True, follow = False)
      try:
        with open('results/logs/{}.txt'.format(container.name),'a') as txtfile:
          while True:
            line = next(logs).decode("utf-8")        
            txtfile.write(line)
            print(line)
      except StopIteration:
        print('log stream ended for {}'.format(container.name)) 
  else: 
    print("No Containers are running")
  
  

if __name__ == "__main__": 
  try:    
    while True:
      get_logs()
      time.sleep(60)
  except StopIteration:
      print('log stream ended')







