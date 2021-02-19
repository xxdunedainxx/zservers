import os
import json
from kazoo.client import KazooClient, KazooState
import time

VAULT_TOKEN_JSON=os.getenv('VAULT_TOKEN_JSON') if os.getenv('VAULT_TOKEN_JSON') is not None else {}
ZK_DISCOVERY_HOST=os.getenv('SERVICE_DISCOVERY')
VAULT_INTERNAL_ADDR=os.getenv('VAULT_INTERNAL_ADDR')
TRUSTED_TOKEN=os.getenv('TRUSTED_TOKEN')
VAULT_EXTERNAL_ADDR=os.getenv('VAULT_EXTERNAL_ADDR')

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
  #children = zk.get_children("/my/favorite/node", watch=my_listener)
  if(zk.exists('services')):
    print('services exists?')

  zk.ensure_path("/services/vault")
  discoveryString=f"{{\"VAULT_INTERNAL_ADDR\":\"{VAULT_INTERNAL_ADDR}\",\"VAULT_EXTERNAL_ADDR\":\"{VAULT_EXTERNAL_ADDR}\",\"TRUSTED_TOKEN\":\"{TRUSTED_TOKEN}\"}}"
  zk.set("/services/vault", bytes(discoveryString, encoding='UTF-8'))

def init_vault_secrets():
  secrets=os.getenv('SECRET_JSON_STR') if os.getenv('SECRET_JSON_STR') is not None else '{}'
  print(f"Secrets: {secrets}")
  load_secrets=json.loads(secrets)
  # We assume the json datastructure is in the form: {'service':[...collection of secrets...]}
  for key in load_secrets:
    print(f"key:{key}, {load_secrets}")
    for secret in load_secrets[key]:
      print(secret)
      print(f"vault kv put secret/creds/{key} {secret['key']}={secret['value']}")
      print(os.system(f"vault kv put secret/creds/{key} {secret['key']}={secret['value']}"))
  print('FINISHED SETTING UP SECRETS')

init_vault_secrets()

if ZK_DISCOVERY_HOST != '' and ZK_DISCOVERY_HOST is not None:
  init_zk_client()
else:
  print('Service discovery is not configured!')

print('Running main loop')
while(True):
  print('Waiting for Zookeeper events..')
  time.sleep(5)