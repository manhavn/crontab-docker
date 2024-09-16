#!/bin/bash
# shellcheck disable=SC2029
# shellcheck disable=SC2164
# shellcheck disable=SC2086
# shellcheck disable=SC2209
cd "$(dirname "$0")"

DI_PROJECT=manhavn
DI_PACKAGE=crontab
DI_VERSION=v0.0.1

if [ $1 ]; then
  DI_VERSION=$1
fi

DOCKER_TAG=$DI_PROJECT/$DI_PACKAGE:$DI_VERSION

docker buildx build --platform linux/amd64,linux/arm64 -t $DOCKER_TAG --push .

# shellcheck disable=SC2016
OLD_TAG_NAME='$(docker inspect '$DI_PACKAGE' | jq .[].Config.Image | sed -e "s/\"//g")'
NEW_TAG_NAME="pending_remove/$DI_PACKAGE"

DI_DOMAIN=domain.test

ssh root@$DI_DOMAIN "docker tag $OLD_TAG_NAME $NEW_TAG_NAME; docker rmi $OLD_TAG_NAME; docker pull $DOCKER_TAG"

ssh root@$DI_DOMAIN "docker stop $DI_PACKAGE; docker rm $DI_PACKAGE"
ssh root@$DI_DOMAIN "docker run -d --restart always --name crontab -v ${PWD}/job/crontab:/root/crontab -v ${PWD}/script:/script -it $DOCKER_TAG"

ssh root@$DI_DOMAIN "docker rmi $NEW_TAG_NAME"
