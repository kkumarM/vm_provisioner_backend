# Copyright (C) 2024-2025 Baxter Corporation
# SPDX-License-Identifier: Apache-2.0
# Author: Karthik Kumaar <karthik_kumaar_mahudeeswaran@baxter.com>

From nginx 

RUN rm /etc/nginx/conf.d/default.conf
COPY build /usr/share/nginx/html
COPY conf/nginx.conf /etc/nginx/conf.d/nginx.conf

# FROM nginx:1.20

# RUN rm /etc/nginx/conf.d/default.conf
# COPY ./build /usr/share/nginx/html
# COPY ./static /etc/static
# COPY ./config/eval_qa.conf /etc/nginx/conf.d/eval.conf
# COPY ./certs /etc/nginx/ssl/certs
# COPY ./eval.intel.com /etc/nginx/ssl/eval.intel.com
# COPY ./eval.intel.com/ssl_passwords.txt /var/lib/nginx/ssl_passwords.txt
# EXPOSE 443 80

# CMD ["nginx", "-g", "daemon off;"]
