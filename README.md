# Healthcare Infrastructure on AWS with Terraform

Project 5: Infrastructure as Code with Terraform.
AWS infrastructure for a healthcare application, written as code, stored in Git, and built with Terraform.

## What this project shows
- Infrastructure written in code (HCL) instead of clicking in the AWS console
- Code split into provider, variables, main and outputs files
- Remote state in an S3 bucket (versioning, encryption, no public access)
- State locking with a DynamoDB table
- A reusable VPC module
- Separate dev, qa and prod folders, each with its own state file

## Tools
- Terraform
- AWS CLI
- AWS (region: ap-south-1, Mumbai)
- Ubuntu (WSL) and VS Code
- Git and GitHub

## Folder structure
```
healthcare-terraform-infra/
├── lab1/        First resource: one S3 bucket
├── lab2/        Same bucket, files split (provider, variables, main, outputs)
├── lab3/        State bucket with versioning + DynamoDB lock table
├── modules/
│   └── vpc/     Reusable VPC module
└── envs/
    ├── dev/     Calls the VPC module, own state file
    ├── qa/      Own state file
    └── prod/    Own state file
```

## Labs
| Lab | What I did |
|---|---|
| 1 | Created one S3 bucket with Terraform (init, plan, apply, destroy) |
| 2 | Split the code into provider.tf, variables.tf, main.tf, outputs.tf and used a tfvars file |
| 3 | Created an S3 bucket (versioning, encryption, public access blocked) and a DynamoDB lock table |
| 4 | Added the S3 backend and moved local state to remote state |
| 5 | Created dev, qa and prod folders, each with its own state key |
| 6 | Built a VPC module: 3 public subnets, 3 private subnets, Internet Gateway, NAT Gateway, route tables |

## How state is stored
- Bucket: S3 with versioning and encryption
- Lock: DynamoDB table `terraform-locks`
- One state file per environment:
  - `dev/terraform.tfstate`
  - `qa/terraform.tfstate`
  - `prod/terraform.tfstate`

## How to run an environment
```bash
export AWS_PROFILE=terraform
cd envs/dev
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

## Clean up
```bash
terraform destroy
```
Run this the same day. The NAT Gateway is not free tier.

## Rules I followed
- Never commit state files or tfvars (see .gitignore)
- Pin the provider version
- Read the plan before apply
- No secrets in code
- Destroy practice resources the same day

## What I learned
- What a provider and a module are
- Why state must be remote and locked
- Why each environment has its own state
- How to build a network with `count` and modules

## Next steps
EC2, load balancer, Auto Scaling Group, RDS, S3, IAM and EKS, added one module at a time.