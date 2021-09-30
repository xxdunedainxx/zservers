#!/bin/bash

export ZK_DISCOVERY_PATH=${ZK_DISCOVERY_PATH:=zk:2181}
export ES_INTERNAL_HOST=${ES_INTERNAL_HOST:=es:9200}

nohup python3 /workbench/zk.py >/dev/stdout 2>&1 &

/usr/local/bin/docker-entrypoint.sh