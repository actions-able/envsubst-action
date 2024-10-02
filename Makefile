
.PHONY: docker-build tests

docker-build:
	docker build -t actions-able/envsubst-action .

tests:
	cd tests/ && ./tests.sh