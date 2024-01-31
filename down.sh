#!/bin/bash
cd "$(dirname "$0")"

docker stop crontab
docker rm crontab
