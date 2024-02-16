#!/bin/bash
# Copyright (C) 2018-2021 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

echo "Uninstall Aether in a Box"

helm -n aether-roc uninstall aether-roc-umbrella aether/aether-roc-umbrella
