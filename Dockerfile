FROM alpine AS runtime
RUN apk add zip bash curl rsync openssh
# RUN echo "* * * * * echo '111'" >> /root/crontab
# RUN echo "@reboot echo '222'" >> /root/crontab
RUN echo 'if [ $(sh -c "crontab /root/crontab"; echo $?) = 0 ]; then crond -f -l 8;else echo 1;fi' >> /crond.sh
ENTRYPOINT ["sh", "/crond.sh"]
# docker build -t test .
# docker image prune --filter="dangling=true"
# docker run --rm -it test
# docker run --rm -v ${PWD}/job/crontab:/root/crontab -v ${PWD}/script:/script -it test
# docker rmi test

# docker run --rm -it alpine
# crond -f
