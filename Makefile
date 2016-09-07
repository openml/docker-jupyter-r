IMAGE:=openml/jupyter-r
EMAIL=andrey.u@gmail.com

include version

help:
	echo ${VERSION}

build:
	docker build --tag ${IMAGE}:dev .

tag:
	docker tag ${IMAGE}:dev ${IMAGE}:latest
	docker tag ${IMAGE}:latest ${IMAGE}:${VERSION}

_login:
	@if [ -n "${DUSER}" ] ; then \
		docker login -u ${DUSER} -p ${DPASS} -e ${EMAIL}; \
	fi

push: _login
	docker push ${IMAGE}:latest
	docker push ${IMAGE}:${VERSION}
