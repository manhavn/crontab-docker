#!/bin/bash
cd "$(dirname "$0")"

docker run -d --restart always --name crontab -v ${PWD}/job/crontab:/root/crontab -v ${PWD}/script:/script -it repo.my_domain.com/crontab:v0.0.1
