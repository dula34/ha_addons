# Base image provided by Home Assistant add-on build environment.
ARG BUILD_FROM

FROM $BUILD_FROM

# Clone FreeRADIUS Azure AD OAuth2 integration repository.
#
# The repository contains the required Perl module, dictionary and policy
# definitions needed for Azure AD authentication support in FreeRADIUS.
#
# The source is cloned during the image build and the Git metadata is removed
# afterwards to keep the final image smaller.
RUN apk add --no-cache git && \
    git clone https://github.com/ARKlab/freeradius-azuread.git /tmp/freeradius-azuread && \
    rm -rf /tmp/freeradius-azuread/.git

# Copy container startup entrypoint script.
COPY docker-entrypoint.sh /

# Install FreeRADIUS and required dependencies.
#
# Packages:
# - freeradius: FreeRADIUS server
# - freeradius-utils: RADIUS testing and administration tools
# - freeradius-perl: Perl module support for custom authentication logic
# - ca-certificates: TLS certificate validation
# - perl-json: JSON parsing support
# - perl-libwww and perl-lwp-protocol-https: HTTPS communication support
RUN apk update && apk upgrade && \
    apk add --no-cache --update \
        freeradius \
        freeradius-utils \
        freeradius-perl \
        ca-certificates \
        perl-json \
        perl-libwww \
        perl-lwp-protocol-https && \
    chmod +x /docker-entrypoint.sh

# Install Azure AD OAuth2 FreeRADIUS integration files.
#
# The module provides:
# - custom FreeRADIUS Perl authentication module
# - dictionary extensions
# - OAuth2 policy definitions
COPY --from=0 /tmp/freeradius-azuread/freeradius-oauth2-perl /opt/freeradius-oauth2-perl

# Configure FreeRADIUS virtual servers.
COPY inner-tunnel default /etc/raddb/sites-available/

# Enable Azure AD OAuth2 authentication module.
#
# Adds the custom dictionary definition and enables:
# - oauth2 module
# - oauth2 policy rules
RUN printf '\n$INCLUDE /opt/freeradius-oauth2-perl/dictionary\n' >> /etc/raddb/dictionary && \
    ln -s /opt/freeradius-oauth2-perl/module /etc/raddb/mods-enabled/oauth2 && \
    ln -s /opt/freeradius-oauth2-perl/policy /etc/raddb/policy.d/oauth2

# Expose standard RADIUS ports.
#
# 1812/udp - Authentication requests
# 1813/udp - Accounting requests
EXPOSE 1812/udp 1813/udp

# Copy Home Assistant add-on startup script.
COPY run.sh /run.sh

# Make startup script executable.
RUN chmod +x /run.sh

# Start FreeRADIUS using the add-on startup script.
CMD ["/run.sh"]