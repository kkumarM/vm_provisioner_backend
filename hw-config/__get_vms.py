#!/usr/bin/env python3 

from pymongo import MongoClient

client = MongoClient('10.40.128.197', 27017)

def get_vm_list():
    vm_list = []

    mydb = client["dev_test"]
    mycollection = mydb['hw_list']

    for x in mycollection.find():
        x.pop('_id')
        vm_list.append(x)

    return vm_list    