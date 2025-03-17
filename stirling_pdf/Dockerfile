FROM stirlingtools/stirling-pdf:latest

RUN apk add --no-cache tini

COPY run.sh /run.sh
RUN chmod +x /run.sh

ENTRYPOINT ["tini", "--"]

CMD ["/run.sh"]