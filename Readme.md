## azure-byok
This repo contains the terraform code to build and test BYOK in Azure. 
It also contains a script that fetches the public key from Azure KeyVault and reconstructs it from the modulus and exponent. 

Detailed documentation is available at - https://ambidextrous-dev.medium.com/secure-your-data-in-azure-with-byok-d011b7ffbd97

### Steps

```
1. Update providers.tf with correct settings
2. Execute terraform scripts
terraform init
terraform validate
terraform plan -var-file variables\sandbox_env.tfvars
terraform apply -var-file variables\sandbox_env.tfvars
terraform destroy -var-file variables\sandbox_env.tfvars
```
