#!/bin/bash

set -x

# install gcloud
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
sudo apt-get install apt-transport-https ca-certificates gnupg
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt-get update && sudo apt-get install google-cloud-sdk

# initialize gcloud project, region, zone
gcloud init
gcloud config set compute/region us-central1
gcloud config set compute/zone us-central1-c

# initialize bucket for nextflow
export BUCKET="gs://nextflow-data"

gsutil mb ${BUCKET}

# create service account for nextflow
export PROJECT=`gcloud config get-value project`
export SERVICE_ACCOUNT_NAME=nextflow-service-account
export SERVICE_ACCOUNT_ADDRESS=${SERVICE_ACCOUNT_NAME}@${PROJECT}.iam.gserviceaccount.com

gcloud iam service-accounts create ${SERVICE_ACCOUNT_NAME}

gcloud projects add-iam-policy-binding ${PROJECT} \
    --member serviceAccount:${SERVICE_ACCOUNT_ADDRESS} \
    --role roles/lifesciences.workflowsRunner

gcloud projects add-iam-policy-binding ${PROJECT} \
    --member serviceAccount:${SERVICE_ACCOUNT_ADDRESS} \
    --role roles/iam.serviceAccountUser

gcloud projects add-iam-policy-binding ${PROJECT} \
    --member serviceAccount:${SERVICE_ACCOUNT_ADDRESS} \
    --role roles/serviceusage.serviceUsageConsumer

gcloud projects add-iam-policy-binding ${PROJECT} \
    --member serviceAccount:${SERVICE_ACCOUNT_ADDRESS} \
    --role roles/storage.objectAdmin

# initialize credentials (service account)
export SERVICE_ACCOUNT_KEY=${SERVICE_ACCOUNT_NAME}-private-key.json

gcloud iam service-accounts keys create \
  --iam-account=${SERVICE_ACCOUNT_ADDRESS} \
  --key-file-type=json ${SERVICE_ACCOUNT_KEY}

export SERVICE_ACCOUNT_KEY_FILE=${PWD}/${SERVICE_ACCOUNT_KEY}
export GOOGLE_APPLICATION_CREDENTIALS=${PWD}/${SERVICE_ACCOUNT_KEY}
