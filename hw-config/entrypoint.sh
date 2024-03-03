#!/bin/bash 

uwsgi --http-socket 0.0.0.0:5001 --wsgi-file run.py --callable app --processes 4 --threads 2  
#!/bin/bash

# Copyright (C) 2018-2021 
# SPDX-License-Identifier: Apache-2.0
# Author: Karthik Kumaar <karthikx.kumaar@intel.com>

export FLASK_APP=run.py
source /opt/intel/openvino_2021/bin/setupvars.sh 
uwsgi --master --processes 2 --https 0.0.0.0:5012,certs/eval.crt,certs/eval.key --disable-logging --lazy-apps --enable-threads --wsgi-file run.py --callable app -b 32768
#uwsgi --master --processes 2 --uwsgi-socket  0.0.0.0:5012 --disable-logging --lazy-apps --enable-threads --wsgi-file run.py --callable app -b 32768