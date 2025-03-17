FROM stirlingtools/stirling-pdf:latest

RUN apk add --no-cache tini

COPY run.sh /run.sh
RUN chmod +x /run.sh

ENTRYPOINT ["/usr/bin/tini", "--"]

CMD ["/run.sh"]