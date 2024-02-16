# Copyright 2021 Intel Corporation

# This software and the related documents are Intel copyrighted materials,
# and your use of them is governed by the express license under which they
# were provided to you ("License"). Unless the License provides otherwise,
# you may not use, modify, copy, publish, distribute, disclose or transmit
# this software or the related documents without Intel's prior written permission.

# This software and the related documents are provided as is, with no express or
# implied warranties, other than those that are expressly stated in the License

FROM grafana/grafana:7.5.8-ubuntu
USER root

ARG DEBIAN_FRONTEND=noninteractive
ARG GF_INSTALL_IMAGE_RENDERER_PLUGIN="true"
ARG GF_REPORTER="true"
ARG GF_VARIABLES="true"

ENV GF_PATHS_PLUGINS="/var/lib/grafana/plugins"

RUN mkdir -p "$GF_PATHS_PLUGINS" \
&& chown -R grafana:${GF_GID} "$GF_PATHS_PLUGINS"



ENV HTTPS_PROXY=http://proxy-dmz.intel.com:911
ENV HTTP_PROXY=http://proxy-dmz.intel.com:911
ENV https_proxy=http://proxy-dmz.intel.com:911
ENV http_proxy=http://proxy-dmz.intel.com:911
ENV NO_PROXY=localhost,.intel.com
ENV no_proxy=localhost,.intel.com

RUN if [ $GF_VARIABLES = "true" ]; then \
apt-get update -y \
&& apt-get install -y --no-install-recommends apt-utils \
&& apt-get install -y curl gettext-base && apt-get install -y git && apt-get install -y texlive-latex-base \
&& apt-get install -y wget ;\
fi

RUN if [ $GF_INSTALL_IMAGE_RENDERER_PLUGIN = "true" ]; then \
apt-get update \
&& apt-get upgrade -y \
&& apt-get install -y gdebi-core \
&& cd /tmp \
&& curl -LO https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
&& gdebi --n google-chrome-stable_current_amd64.deb \
&& apt-get autoremove -y \
&& rm -rf /var/lib/apt/lists/*; \
fi

ENV GF_PLUGIN_RENDERING_CHROME_BIN="/usr/bin/google-chrome"

RUN if [ $GF_INSTALL_IMAGE_RENDERER_PLUGIN = "true" ]; then \
grafana-cli \
--pluginsDir "$GF_PATHS_PLUGINS" \
--pluginUrl https://github.com/grafana/grafana-image-renderer/releases/download/v3.5.0/plugin-linux-x64-glibc-no-chromium.zip \
plugins install grafana-image-renderer; \
fi

WORKDIR /tmp

RUN if [ $GF_REPORTER = "true" ]; then \
cd /tmp \
&& wget https://dl.google.com/go/go1.10.2.linux-amd64.tar.gz \
&& tar -C /usr/local -xzf go1.10.2.linux-amd64.tar.gz; \
fi

ENV GOROOT=/usr/local/go
ENV GOPATH=/root/go
ENV PATH=$GOROOT/bin:$PATH
RUN go get github.com/IzakMarais/reporter/...
RUN go install github.com/IzakMarais/reporter/cmd/grafana-reporter

RUN grafana-cli --pluginsDir "/var/lib/grafana/plugins" plugins install ryantxu-ajax-panel

#WORKDIR /opt
#COPY entrypoint.sh ./
#RUN chmod 777 entrypoint.sh

#USER grafana

#ENTRYPOINT ["./entrypoint.sh"]

