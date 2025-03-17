FROM stirlingtools/stirling-pdf:latest

#RUN apk add --no-cache tini bash

COPY run.sh /run.sh
RUN chmod +x /run.sh

#ENTRYPOINT ["/sbin/tini", "-s", "--"]
ENTRYPOINT ["/usr/bin/with-contenv", "bashio"]

CMD ["/run.sh"]