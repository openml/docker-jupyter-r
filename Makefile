VERSION=0.1
IMAGE=openml/jupyter-r

build:
	docker build --tag ${IMAGE}:dev .

tag:
	docker tag ${IMAGE}:dev ${IMAGE}:latest

login:
	@if [ -n "${DUSER}" ] ; then \
		docker login -u ${DUSER} -p ${DPASS} ; \
	fi \

push: login
	docker push ${IMAGE}:${VERSION}
	docker push ${IMAGE}:latest
