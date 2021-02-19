#!/bin/bash

export ZK_DISCOVERY_PATH=${ZK_DISCOVERY_PATH:=zk:2181}
export REDIS_INTERNAL_HOST=${REDIS_INTERNAL_HOST:=redis:6379}

nohup python3 /workbench/zk.py >/dev/stdout 2>&1 &

/usr/bin/redis-server /workbench/redis.conf