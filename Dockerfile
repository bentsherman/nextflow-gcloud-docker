FROM bentsherman/nextflow

# install gcloud
WORKDIR /opt

RUN apk add python3 \
    && curl -s -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-360.0.0-linux-x86_64.tar.gz \
    && tar -xzf google-cloud-sdk-360.0.0-linux-x86_64.tar.gz \
    && rm -f google-cloud-sdk-360.0.0-linux-x86_64.tar.gz \
    && google-cloud-sdk/install.sh -q

ENV PATH="${PATH}:/opt/google-cloud-sdk/bin"
