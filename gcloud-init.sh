#!/bin/bash

export GOOGLE_APPLICATION_CREDENTIALS="nextflow-service-account-private-key.json"
export PROJECT=""

gcloud auth login
gcloud auth activate-service-account --key-file ${GOOGLE_APPLICATION_CREDENTIALS}
gcloud config set project ${PROJECT}
