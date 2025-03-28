ARG BUILD_FROM
FROM $BUILD_FROM

RUN apk add --no-cache freeradius freeradius-utils

COPY freeradius /etc/freeradius/

EXPOSE 1812/udp 1813/udp

CMD ["freeradius", "-X"]
