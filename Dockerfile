FROM gcr.io/google.com/cloudsdktool/cloud-sdk:alpine

# install nextflow
WORKDIR /opt

RUN apk add openjdk8-jre \
 && curl -s https://get.nextflow.io | bash \
 && chmod 755 nextflow \
 && mv nextflow /usr/local/bin \
 && nextflow info
