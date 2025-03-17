FROM stirlingtools/stirling-pdf:latest

RUN #apk add --no-cache tini bash

RUN apk add --no-cache dumb-init

COPY run.sh /run.sh
RUN chmod +x /run.sh

#ENTRYPOINT ["/sbin/tini", "-s", "--"]
ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["/run.sh"]