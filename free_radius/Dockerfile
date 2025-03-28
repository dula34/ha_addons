FROM ghcr.io/hassio-addons/base:latest

RUN apk add --no-cache freeradius freeradius-utils

COPY freeradius /etc/raddb/

EXPOSE 1812/udp 1813/udp

CMD ["/usr/sbin/radiusd", "-X"]
