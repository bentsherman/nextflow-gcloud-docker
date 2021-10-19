# nextflow-gcloud

This repository contains the build files for the nextflow-gcloud Docker image, which contains nextflow and gcloud. You must provide your own service account credentials (`nextflow-service-account-private-key.json`) and you must specify your Google Cloud project.

To build the Docker image:
```bash
make build PROJECT=<project>
```