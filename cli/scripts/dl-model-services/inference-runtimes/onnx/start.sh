#!/bin/bash


# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

echo -e "\e[1;32mentered into onnx\e[0m"

echo -e "\e[1;32menter exit to come out of the onnx\e[0m"

docker run -it --rm --device-cgroup-rule='c 189:* rmw' -v /dev/bus/usb:/dev/bus/usb openvino/onnxruntime_ep_ubuntu18:latest



