# k8s Deploy

### Prepare GCP project

* [Register GCP account](https://telegra.ph/%D0%86nstrukc%D1%96ya-yak-DDositi-sajti-za-dopomogoyu-server%D1%96v-02-26)

* Init project
    ```shell
    ./init_project.sh
    ```

### Setup tools

* [Terrafrom](https://www.terraform.io/downloads)
* [Terragrunt](https://terragrunt.gruntwork.io/docs/getting-started/install/)
* [Kubectl](https://kubernetes.io/docs/tasks/tools/)
* [Helm](https://helm.sh/docs/intro/install/)
* [Kontena Lens](https://k8slens.dev/) - optional, for management UI

### Terraform deploy
```shell
cd terraform
terragrunt init
terragrunt plan
terragrunt apply
```

### Get kubeconfig

 ```shell
gcloud container clusters get-credentials stress-runners-k8s --zone us-central1-a --project $(gcloud projects list --format=json | jq '.[]' | jq 'select(.name=="My First Project")' | jq -r '.projectId')
 ```
