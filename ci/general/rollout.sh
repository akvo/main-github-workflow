#!/usr/bin/env bash
set -exuo pipefail

# ${1} for repo name
# ${2} for service name
# ${3} for image version

gcloud_project="akvo-lumen"
registry="eu.gcr.io"

auth () {
    gcloud auth activate-service-account --key-file=gcp.json
    gcloud config set project ${gcloud_project}
    gcloud config set container/cluster europe-west1-d
    gcloud config set compute/zone europe-west1-d
    gcloud config set container/use_client_certificate False
    gcloud container clusters get-credentials "production"
}

auth

kubectl set image deployment/${1} ${2}=${registry}/${gcloud_project}/${1}/${2}:${3}

kubectl rollout status deployment/${1}
