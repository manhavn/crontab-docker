#!/bin/bash
cd "$(dirname "$0")"

DI_DOMAIN=my_domain.com
DI_PROJECT=repo.$DI_DOMAIN
DI_PACKAGE=crontab
DI_VERSION=v0.0.1

if [ $1 ]; then
  DI_VERSION=$1
fi

docker build -t $DI_PROJECT/$DI_PACKAGE:$DI_VERSION .
docker image prune --filter="dangling=true"
docker push $DI_PROJECT/$DI_PACKAGE:$DI_VERSION

# ssh root@$DI_DOMAIN "docker stop $DI_PACKAGE && docker rm $DI_PACKAGE"
# ssh root@$DI_DOMAIN "docker rmi $DI_PROJECT/$DI_PACKAGE:$DI_VERSION"
# ssh root@$DI_DOMAIN "docker run -d --restart always --network host --name crontab -v ${PWD}/cron.d:/etc/cron.d -v ${PWD}/script:/root/script -it $DI_PROJECT/$DI_PACKAGE:$DI_VERSION"
# ssh root@$DI_DOMAIN "docker run -d --restart always --name crontab -v ${PWD}/job/crontab:/root/crontab -v ${PWD}/script:/script -it $DI_PROJECT/$DI_PACKAGE:$DI_VERSION"
