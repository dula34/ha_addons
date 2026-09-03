# Base image provided by Home Assistant add-on build environment.
ARG BUILD_FROM

# Pull the upstream esphome-mcp binary out of its official (FROM scratch)
# release image, since that image has no shell/bashio for HA add-on startup.
FROM ghcr.io/jeeftor/esphome-mcp:latest AS upstream

FROM $BUILD_FROM

COPY --from=upstream /usr/local/bin/esphome-mcp /usr/local/bin/esphome-mcp

# Copy Home Assistant add-on startup script.
COPY run.sh /run.sh
RUN chmod a+x /run.sh /usr/local/bin/esphome-mcp

EXPOSE 3333

CMD [ "/run.sh" ]

# Home Assistant add-on metadata.
LABEL \
  io.hass.type="addon" \
  io.hass.arch="amd64|aarch64"
