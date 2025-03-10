#checkov:skip=CKV_DOCKER_2
#checkov:skip=CKV_DOCKER_3
FROM alpine:3.21

RUN apk add --update --no-cache gettext=0.22.5-r0

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["sh", "/entrypoint.sh"]
