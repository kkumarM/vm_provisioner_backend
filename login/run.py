#!/usr/bin/env python3 

from flask import Flask, request
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

@app.route("/login",methods=['POST','GET'])
def login():
    data = request.get_json()
    print("data", data) 
    return "Login Successfull"


if __name__ == "__main__":
    app.run(host='0.0.0.0', port= 5000, debug= True)


