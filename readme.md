# CRONTAB DOCKER

- Dockerfile

```Dockerfile
FROM alpine AS runtime
RUN apk add curl rsync openssh
RUN echo 'if [ $(sh -c "crontab /root/crontab"; echo $?) = 0 ]; then crond -f -l 8;else echo 1;fi' >> /crond.sh
ENTRYPOINT ["sh", "/crond.sh"]
```

- Docker Build CRONTAB

```shell
sh build.sh
```

- Run CRONTAB

```shell
sh start.sh
```
