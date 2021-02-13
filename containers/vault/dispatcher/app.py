import os

from flask import Flask, request
import json
# set the project root directory as the static folder, you can set others.

TRUSTED_TOKEN=os.getenv('TRUSTED_TOKEN')
VAULT_TOKEN_JSON=os.getenv('VAULT_TOKEN_JSON')

print(f"TRUSTED TOKEN {TRUSTED_TOKEN}")

app = Flask(__name__, static_url_path='')

def init_vault_secrets():
  secrets=os.getenv('SECRET_JSON_STR')
  
  print(f"Secrets: {secrets}")

  load_secrets=json.loads(secrets)

  # We assume the json datastructure is in the form: {'service':[...collection of secrets...]}
  for key in load_secrets:
    print(f"key:{key}, {load_secrets}")
    for secret in load_secrets[key]:
      print(secret)
      print(f"vault kv put secret/creds/{key} {secret['key']}={secret['value']}")
      print(os.system(f"vault kv put secret/creds/{key} {secret['key']}={secret['value']}"))

init_vault_secrets()

@app.route('/')
def root():
  return 'Im a vault plugin! :D '

@app.route('/token')
def token():
  token=request.args.get('token')
  if token == TRUSTED_TOKEN:
    return VAULT_TOKEN_JSON
  else: 
    return "no auth, or missing servicename"

app.run(host='0.0.0.0', port=8080)