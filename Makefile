VERSION=0.1
IMAGE=openml/jupyter-r

build:
	docker build --tag ${IMAGE}:dev .

tag:
	docker tag ${IMAGE}:dev ${IMAGE}:latest

push:
	docker push ${IMAGE}:$(VERSION)
	docker push ${IMAGE}:latest
