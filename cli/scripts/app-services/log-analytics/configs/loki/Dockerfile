FROM grafana/loki:2.4.2

ARG LOKI_FILE

ENV LOKI_FILE=${LOKI_FILE}

ADD ${LOKI_FILE} /etc/loki/
