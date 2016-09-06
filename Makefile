VERSION=0.1.1
IMAGE=openml/jupyter-r

build:
	docker build --tag ${IMAGE}:dev .

tag:
	docker tag ${IMAGE}:dev ${IMAGE}:latest
	docker tag ${IMAGE}:latest ${IMAGE}:${VERSION}

_login:
	@if [ -n "${DUSER}" ] ; then \
		docker login -u ${DUSER} -p ${DPASS} -e andrey.u@gmail.com; \
	fi \

push: _login
	docker push ${IMAGE}:latest
	docker push ${IMAGE}:${VERSION}
