
all: push

build:
	docker build -t bentsherman/nextflow-gcloud .

push: build
	docker push bentsherman/nextflow-gcloud

clean:
	docker image rm -f bentsherman/nextflow-gcloud
