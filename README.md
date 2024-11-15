# Repository for testing ideas using GCP
The Terraform code provisions a GKE cluster and deploys an Ethereum node with integrated monitoring.

[!WARNING]
This is not production ready code. Please, use carefully. Consider consulting DevOps Engineer and Security Engineer befor using in any environment.

## Grafana Ethereum Exporter Dashboard
![overview](https://github.com/user-attachments/assets/067ac8aa-269e-469d-9496-4a6d357d887d)
![consensus](https://github.com/user-attachments/assets/b35f2c42-5b3c-472e-a22d-33e3c39efd67)
![execution](https://github.com/user-attachments/assets/96f7738a-3ea7-4f35-94bf-39d2518e0a3e)

## Logs from applications
![lighthouse](https://github.com/user-attachments/assets/b50ff5b4-2491-45e8-b8d7-e4f3b166de48)
![geth](https://github.com/user-attachments/assets/c60618a2-31d6-4070-b4cc-2b13d6c226a1)

## TODO
- Wait for the application to fully sync with the blockchain and verify its state.
- Update the CI/CD pipeline to use artifacts from terraform plan in terraform apply.
- Refactor the Terraform code into modules.
- Add scaling of the application.
- Update security and make cluster private.
- Refactor code and make different repositories and CI/CD pipeline for deploying infra and for deploying application.

## Deployment instruction
1. Craete GCP account and GCP project.
2. Create Storage Bucket for terraform backend configuration.
3. Craete `terraform.tfvars` file with variables `project_id` and `region` of your project. (Be careful, terraform code has hardcoded zones for GKE cluster)
4. ![Install](https://cloud.google.com/sdk/docs/install) gcloud cli and login to your GCP account with it.
5. ![Install](https://cloud.google.com/kubernetes-engine/docs/how-to/cluster-access-for-kubectl) kubectl and other tools.
6. ![Install](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) terraform version 1.9.3.
7. ![Install](https://helm.sh/docs/intro/install/) helm.
8. Run `terraform init` in the project directory's root.
9. Run `terraform plan` to get the execution plan and see what resources will be created with this terraform code.
10. Run `terraform apply` to apply the code to the GKE. Terraform will ask if you want to do the changes, you will need to type 'Yes'.
11. Connect to the GKE cluster with kubectl and check the application.
