# k8s Deploy to fight for freedom

### Prepare GCP project

* https://cloud.google.com/free - the most safe for New customers also get $300 in free credits to fully explore and conduct an assessment of Google Cloud Platform. You won’t be charged until you choose to upgrade.
* UA instruction: [Register GCP account](https://telegra.ph/%D0%86nstrukc%D1%96ya-yak-DDositi-sajti-za-dopomogoyu-server%D1%96v-02-26)
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
If you want to add more compute resources just increase values of `maximum_cpu` and `maximum_memory` at `terragrunt.hcl` file and run `terragrunt apply` again.

### Get kubeconfig

```shell
gcloud container clusters get-credentials stress-runners --zone europe-west3 --project $(gcloud projects list --format=json | jq '.[]' | jq 'select(.name=="My First Project")' | jq -r '.projectId')
```

### Deploy helm charts

* deploy tor-proxy
  ```shell
  cd helm/tor-proxy
  helm upgrade --install tor-proxy .
  ```
* prepare and deploy runners
  ```shell
  cd helm/runners
  cp targets.example.yaml targets.yaml
  ```
  edit `targets.yaml` and add additional targets
  ```shell
  helm upgrade --install runners -f targets.yaml .
  ```

### Use Lens for checking state and management

# Enjoy and keep calm

#### Vpn integration is coming...

---
***Attention!!! If you want to improve performance and help to the community:***

You can improve network performance by setting up additional tor nodes in the ***target*** (you know ;)) country.
* Buy the cheapest virtual server instance in any hosting provider.
* Setup [Docker service](https://docs.docker.com/engine/install/) on it:
  ```shell
  curl -fsSL https://get.docker.com -o get-docker.sh
  sh get-docker.sh
  ```
* [Run Tor node](https://community.torproject.org/relay/setup/bridge/docker/)
