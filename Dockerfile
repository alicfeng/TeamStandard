FROM hub.c.163.com/library/nginx:alpine

MAINTAINER AlicFeng <a@samego.com>

COPY _book /usr/share/nginx/html

RUN sed -i "s/800px/1000px/g" /usr/share/nginx/html/gitbook/style.css
