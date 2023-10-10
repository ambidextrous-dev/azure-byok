from azure.identity import ClientSecretCredential
from azure.keyvault.keys import KeyClient
from Crypto.PublicKey import RSA
import json

# get the Modulus and Exponent of the public key from Azure Vaults
def getKeyFromAzureVault(key_name):
    with open('secrets.json') as f:
        secrets = json.load(f)
        client_id = secrets["client_id"]
        client_secret = secrets["client_secret"]
        tenant_id = secrets["tenant_id"]
        vault_url = secrets["vault_url"]

    # Authenticate and obtain access token
    credential = ClientSecretCredential(tenant_id, client_id, client_secret)
    key_client = KeyClient(vault_url=vault_url, credential=credential)
    key = key_client.get_key(key_name)

    return {"modulus": key.key.n, "exponent": key.key.e}

# convert modulus and exponent to int
def decodeToInt(encoded_bytes):
    return int.from_bytes(encoded_bytes, byteorder='big')

# create the public key in PEM
def create_public_key_pem(data):
    modulus_int = decodeToInt(data["modulus"])
    exponent_int = decodeToInt(data["exponent"])
    key = RSA.construct((modulus_int, exponent_int))
    public_key = key.publickey().export_key()
   
    with open('data\public_key.pem', 'wb') as f:
        f.write(public_key)
        print("Public key saved to 'public_key.pem'")
        
key_name = "clearsense-tst"
key_data = getKeyFromAzureVault(key_name)
create_public_key_pem(key_data)