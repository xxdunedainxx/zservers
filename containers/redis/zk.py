from kazoo.client import KazooClient, KazooState
import time
import os

REDIS_INTERNAL_HOST=os.getenv('REDIS_INTERNAL_HOST')
REDIS_INTERNAL_HOST_PORT=os.getenv('REDIS_INTERNAL_HOST_PORT')
REDIS_EXTERNAL_HOST=os.getenv('REDIS_EXTERNAL_HOST')
REDIS_EXTERNAL_HOST_PORT=os.getenv('REDIS_EXTERNAL_HOST_PORT')

ZK_DISCOVERY_HOST=os.getenv('SERVICE_DISCOVERY')
ZK_DISCOVERY_PATH="/services/redis"

print(f"ZK_DISCOVERY_HOST {ZK_DISCOVERY_HOST}")

zk = KazooClient(hosts=ZK_DISCOVERY_HOST)
zk.start()

def my_listener(state):
  print('ZK event')
  if state == KazooState.CONNECTED:
    print('connected...')
  if state == KazooState.LOST:
    print('lost?')
    # Register somewhere that the session was lost
  elif state == KazooState.SUSPENDED:
    # Handle being disconnected from Zookeeper
    print('suspsended?')
  else:
    # Handle being connected/reconnected to Zookeeper
    print('state change')


def init_zk_client():
  zk.add_listener(my_listener)
  zk.ensure_path(ZK_DISCOVERY_PATH)
  discoveryString=f"""
      {{
      \"REDIS_INTERNAL_HOST\":\"{REDIS_INTERNAL_HOST}\",
      \"REDIS_INTERNAL_HOST_PORT\":\"{REDIS_INTERNAL_HOST_PORT}\",
      \"REDIS_EXTERNAL_HOST\":\"{REDIS_EXTERNAL_HOST}\",
      \"REDIS_EXTERNAL_HOST_PORT\":\"{REDIS_EXTERNAL_HOST_PORT}\"
      }}
  """
  zk.set(ZK_DISCOVERY_PATH, bytes(discoveryString, encoding='UTF-8'))

init_zk_client()

while(True):
  print('Waiting for Zookeeper events..')
  time.sleep(5)