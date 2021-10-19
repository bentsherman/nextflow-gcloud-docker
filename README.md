# nextflow-gcloud

This repository contains the build files for the nextflow-gcloud Docker image, which contains nextflow and gcloud.

To build the Docker image:
```bash
make build
```

You must set your Google Cloud account and project when running the image. I have not yet figured out how to fully authenticate a project during the build process. Here are the steps to follow:
```bash
export CLOUDSDK_CORE_PROJECT="<project>"
export GOOGLE_APPLICATION_CREDENTIALS="nextflow-service-account-private-key.json"

gcloud auth login
gcloud auth activate-service-account --key-file ${GOOGLE_APPLICATION_CREDENTIALS}
```

To run the minibench Nextflow pipeline with Google Cloud:
```bash
# run pipeline
export NXF_MODE="google"

nextflow run bentsherman/minibench \
    -profile google \
    -resume \
    --google_bucket "gs://nextflow-data/work" \
    --google_zone "us-central1-c"

# download work directory
gsutil -m cp -r gs://nextflow-data/work .
gsutil -m rm -r gs://nextflow-data/work
```