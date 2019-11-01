## Build Environments for app_swift

Contains scripts for building test environments for validating app_swift builds

## Setup Environment

These configuration scripts was built for Digital Ocean (DO)

1. Login to Digital Ocean, create a token and setup your token in your environment

```
DIGITALOCEAN_TOKEN=<your token>
```

2. Download terraform from https://releases.hashicorp.com/terraform/.  Use any version starting with 0.12

```
wget https://releases.hashicorp.com/terraform/0.12.13/terraform_0.12.13_darwin_amd64.zip
unzip terraform_0.12.13_darwin_amd64.zip
cp 
```

3. Execute Terraform to build the environment

```
terraform init
terraform apply
```

4. Destroy Terraform to build the environment

```
terraform destroy
```


