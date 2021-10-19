FROM bentsherman/nextflow

# define build args
ARG PROJECT=""
ENV GOOGLE_APPLICATION_CREDENTIALS="nextflow-service-account-private-key.json"

# install gcloud
WORKDIR /root

RUN apk add python3 \
    && curl -s -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-360.0.0-linux-x86_64.tar.gz \
    && tar -xzf google-cloud-sdk-360.0.0-linux-x86_64.tar.gz \
    && rm -f google-cloud-sdk-360.0.0-linux-x86_64.tar.gz \
    && google-cloud-sdk/install.sh -q

RUN echo "source /root/google-cloud-sdk/completion.bash.inc" >> .bashrc
RUN echo "source /root/google-cloud-sdk/path.bash.inc" >> .bashrc

# install gcloud credentials from build context
ADD ${GOOGLE_APPLICATION_CREDENTIALS} .

RUN google-cloud-sdk/bin/gcloud auth activate-service-account --key-file ${GOOGLE_APPLICATION_CREDENTIALS}
RUN google-cloud-sdk/bin/gcloud config set project ${PROJECT}