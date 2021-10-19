
PROJECT ?= ""

all: push

build:
	docker build \
		-t bentsherman/nextflow-gcloud \
		--build-arg PROJECT=${PROJECT} \
		.

push: build
	docker push bentsherman/nextflow-gcloud

clean:
	docker image rm -f bentsherman/nextflow-gcloud
