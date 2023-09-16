## Steps

```
1. Update providers.tf with correct settings
2. Execute terraform scripts
terraform init
terraform validate
terraform plan -var-file variables\sandbox_env.tfvars
terraform apply -var-file variables\sandbox_env.tfvars
terraform destroy -var-file variables\sandbox_env.tfvars
```