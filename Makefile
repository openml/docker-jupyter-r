VERSION=0.1

build:
	docker build --tag openml/r-base:dev .

tag:
	docker tag openml/r-base:dev openml/r-base:latest

push:
	docker push openml/r-base:$(VERSION)
	docker push openml/r-base:latest
