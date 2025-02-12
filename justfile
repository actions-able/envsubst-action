#!/usr/bin/env -S just --justfile

set quiet := true

default:
	just --choose

# Build docker image
[group('Development mode')]
docker-build:
	docker build -t actions-able/envsubst-action .

# Generate site for production
[group('Development mode')]
test:
	cd tests/ && ./tests.sh
	