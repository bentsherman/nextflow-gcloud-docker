#!/bin/bash

set -e

# run kinc pipeline w/ unified datasets
export GOOGLE_APPLICATION_CREDENTIALS="nextflow-service-account-private-key.json"
export NXF_MODE="google"
export NXF_WORK=""

nextflow run systemsgenetics/kinc-nf \
    -latest \
    -profile google \
    -r google-test \
    -resume \
    --import_emx false \
    --similarity true \
    --similarity_hardware_type "nvidia-tesla-v100" \
    --similarity_threads 2 \
    --corrpower false \
    --condtest false \
    --extract false

# delete input, intermediate, output files
gsutil -m rm -r gs://nextflow-data/work/stage
gsutil -m rm gs://nextflow-data/work/*/*/*.abd
# gsutil -m rm gs://nextflow-data/work/*/*/*.ccm
# gsutil -m rm gs://nextflow-data/work/*/*/*.cmx

# download work directory
gsutil -m cp -r gs://nextflow-data/work .
gsutil -m rm -r gs://nextflow-data/work

