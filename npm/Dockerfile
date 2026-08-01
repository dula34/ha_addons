# Base image version used for building the Nginx Proxy Manager add-on.
#
# Version 2.15.1 has a known issue with Certbot, therefore version 2.14.0
# is used as the default base image version.
#
# The version is defined as a build argument to allow overriding it during
# the Docker image build process:
#
#   docker build --build-arg NPM_VERSION=2.14.0 .
#
ARG NPM_VERSION=2.14.0

# Use the official Nginx Proxy Manager image as the base image.
FROM jc21/nginx-proxy-manager:${NPM_VERSION}

# Re-declare the build argument so it can be used after the FROM instruction.
ARG NPM_VERSION

# Copy the initialization hook script into the container.
#
# The script prepares persistent storage paths and creates required symbolic
# links before the application starts.
COPY stage2-hook.sh /etc/stage2-hook.sh

# Make the initialization script executable.
RUN chmod +x /etc/stage2-hook.sh

# Home Assistant add-on metadata.
#
# io.hass.version:
#   Version of the Nginx Proxy Manager add-on exposed to Home Assistant.
#
# io.hass.type:
#   Defines the add-on type.
#
# io.hass.arch:
#   Supported CPU architectures for this add-on.
LABEL \
  io.hass.version="${NPM_VERSION}" \
  io.hass.type="app" \
  io.hass.arch="amd64|aarch64"