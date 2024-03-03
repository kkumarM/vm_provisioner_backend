# Copyright (C) 2024-2025 Baxter Corporation
# SPDX-License-Identifier: Apache-2.0
# Author: Karthik Kumaar <karthik_kumaar_mahudeeswaran@baxter.com>

FROM python:3.5
RUN mkdir -p /usr/app
RUN useradd -ms /bin/bash devclouduser

COPY requirements.txt /usr/app
COPY app /usr/app
WORKDIR /usr/app

RUN pip install -r requirements.txt --no-cache-dir

RUN chown -R devclouduser:devclouduser /usr/app
RUN chmod a+x run-server.sh
USER devclouduser

ENTRYPOINT ["./run-server.sh"]



