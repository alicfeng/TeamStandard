FROM nginx:1.17.6-alpine
MAINTAINER AlicFeng <a@samego.com>

ENV VERSION=3.2.3

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories\
    && apk update \
    && apk --no-cache add --virtual .build-deps nodejs npm \
    && npm set registry https://registry.npm.taobao.org/ \
    && npm install --global gitbook-cli -ddd \
    && gitbook fetch ${VERSION} \
    && gitbook install \
    && npm cache clear --force \
    && apk del .build-deps -f \
    && rm -rf /src /tmp/* /var/cache/apk/*

EXPOSE 80

CMD ["gitbook","serve","--port","80"]