ARG BUILD_FROM
FROM $BUILD_FROM

RUN apk add --no-cache freeradius freeradius-utils

COPY freeradius /etc/raddb/

EXPOSE 1812/udp 1813/udp

CMD ["/usr/sbin/radiusd", "-X"]
