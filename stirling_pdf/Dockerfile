FROM stirlingtools/stirling-pdf:latest

RUN apk add --no-cache tini bash
RUN apk add --no-cache bash bashio


COPY run.sh /run.sh
RUN chmod +x /run.sh

ENTRYPOINT ["/sbin/tini", "-s", "--"]

CMD ["/run.sh"]