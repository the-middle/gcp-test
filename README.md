# Repository for testing ideas using GCP
The Terraform code provisions a GKE cluster and deploys an Ethereum node with integrated monitoring.

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
