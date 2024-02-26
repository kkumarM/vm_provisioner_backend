from pymongo import MongoClient

client = MongoClient('10.40.128.197', 27017)



mydb = client["dev_test"]
mycollection = mydb['hw_list']

for x in mycollection.find():
    print(x)