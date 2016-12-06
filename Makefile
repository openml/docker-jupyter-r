IMAGE:=openml/jupyter-r
EMAIL=someone@gmail.com

include version

help:
	echo '${VERSION}'

build:
	docker build --tag ${IMAGE}:dev .

tag:
	docker tag ${IMAGE}:dev ${IMAGE}:latest
	docker tag ${IMAGE}:latest ${IMAGE}:${VERSION}

_login:
	@if [ -n "${DUSER}" ] ; then \
		docker login -u ${DUSER} -p ${DPASS} -e ${EMAIL}; \
	fi

_is_published:
	if curl -s -S 'https://registry.hub.docker.com/v2/repositories/${IMAGE}/tags/' | \
		jq '."results"[]["name"]' | \
		grep -q '^"${VERSION}"\$$' ; then \
			echo "ERROR: version ${VERSION} of ${IMAGE} is already published." ; exit 1 ; \
	fi

push: _login _is_published
	docker push ${IMAGE}:latest
	docker push ${IMAGE}:${VERSION}

# TODO: check that images with -dev should not go to registry