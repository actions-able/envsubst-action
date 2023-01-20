
.PHONY: docker-build tests

docker-build:
	docker build -t fhbaguidi/action-envsubst .

tests:
	cd tests/ && ./tests.sh