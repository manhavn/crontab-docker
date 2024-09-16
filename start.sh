#!/bin/bash
# shellcheck disable=SC2086
# shellcheck disable=SC2164
cd "$(dirname "$0")"

docker run -d --restart always \
  --name crontab \
  -v ${PWD}/job/crontab:/root/crontab \
  -v ${PWD}/script:/script \
  -it manhavn/crontab:v0.0.1
