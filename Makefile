VERSION=0.1
IMAGE=openml/jupyter-r

build:
	docker build --tag ${IMAGE}:dev .

tag:
	docker tag ${IMAGE}:dev ${IMAGE}:latest

_login:
	@if [ -n "${DUSER}" ] ; then \
		docker login -u ${DUSER} -p ${DPASS} -e andrey.u@gmail.com; \
	fi \

push: _login
	docker tag ${IMAGE}:${VERSION} ${IMAGE}:latest
	docker push ${IMAGE}:${VERSION}
	docker push ${IMAGE}:latest
