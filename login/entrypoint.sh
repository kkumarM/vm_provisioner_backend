#!/bin/bash 

uwsgi --http-socket 0.0.0.0:5000 --wsgi-file run.py --callable app --processes 4 --threads 2  
