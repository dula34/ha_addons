# Upstream image already ships a full Python runtime with esphome-mcp-web
# installed, so we build directly on top of it instead of the HA add-on
# base image.
FROM ghcr.io/loryanstrant/esphome-mcp:latest

# Home Assistant add-on startup script: translates /data/options.json into
# the environment variables this app expects, then execs the upstream entrypoint.
COPY run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 8080

CMD [ "/run.sh" ]

# Home Assistant add-on metadata.
LABEL \
  io.hass.type="addon" \
  io.hass.arch="amd64|aarch64"
