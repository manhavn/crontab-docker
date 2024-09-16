#!/bin/bash
# shellcheck disable=SC2164
cd "$(dirname "$0")"

docker stop crontab
docker rm crontab
