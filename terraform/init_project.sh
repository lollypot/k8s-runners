#!/usr/bin/env bash

set -Eeu -o pipefail

export PROJECT_ID=$(gcloud projects list --format=json | jq '.[]' | jq 'select(.name=="My First Project")' | jq -r '.projectId')
gcloud auth application-default login
gcloud config set core/project ${PROJECT_ID}

gsutil mb \
        -b off \
        -c Standard \
        -l us-central1 \
        -p ${PROJECT_ID} \
        gs://${PROJECT_ID}-tfstate
gsutil versioning set on gs://${PROJECT_ID}-tfstate
