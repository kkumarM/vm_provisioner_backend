#!/bin/bash
# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

echo "Deleting Namespace"

kubectl delete namespace monitoring

echo "Checking Namespace"

kubectl get namespace

