# Base image provided by Home Assistant add-on build environment.
ARG BUILD_FROM

FROM $BUILD_FROM

# Azure AD OAuth2 configuration parameters.
#
# These values are provided through Home Assistant add-on options
# and are used by the FreeRADIUS OAuth2 authentication integration.
#ENV AzureAdDomain=\
#    AzureAdClientId=\
#    AzureAdSecret=\
#    NASName=\
#    NASNetwork=\
#    NASSecret=

# Copy container entrypoint script.
COPY docker-entrypoint.sh /

# Install FreeRADIUS and required dependencies.
#
# Installed packages:
# - freeradius: RADIUS authentication server
# - freeradius-utils: RADIUS administration and testing tools
# - freeradius-perl: Perl module support for custom authentication logic
# - ca-certificates: TLS certificate validation
# - perl-json: JSON parsing support
# - perl-libwww: HTTP client support
# - perl-lwp-protocol-https: HTTPS communication support
RUN apk update && apk upgrade && \
    apk add --no-cache \
        freeradius \
        freeradius-utils \
        freeradius-perl \
        ca-certificates \
        perl-json \
        perl-libwww \
        perl-lwp-protocol-https \
        git && \
    chmod +x /docker-entrypoint.sh

# Clone FreeRADIUS OAuth2 Perl integration.
#
# The repository provides the OAuth2 authentication module required
# for Azure AD authentication support.
#
# Included components:
# - FreeRADIUS Perl authentication module
# - module configuration
# - dictionary definitions
# - OAuth2 policy rules
#
# The repository is copied to the application directory and the
# temporary clone is removed afterwards.
RUN git clone https://github.com/jimdigriz/freeradius-oauth2-perl.git /tmp/freeradius-oauth2-perl && \
    cp -r /tmp/freeradius-oauth2-perl /opt/freeradius-oauth2-perl && \
    rm -rf /tmp/freeradius-oauth2-perl

# Copy FreeRADIUS virtual server configurations.
COPY inner-tunnel default /etc/raddb/sites-available/

# Enable OAuth2 authentication module.
#
# Adds the custom dictionary and enables:
# - OAuth2 module configuration
# - OAuth2 policy rules
RUN printf '\n$INCLUDE /opt/freeradius-oauth2-perl/dictionary\n' >> /etc/raddb/dictionary && \
    ln -s /opt/freeradius-oauth2-perl/module /etc/raddb/mods-enabled/oauth2 && \
    ln -s /opt/freeradius-oauth2-perl/policy /etc/raddb/policy.d/oauth2

# Expose RADIUS ports.
#
# 1812/udp - Authentication
# 1813/udp - Accounting
EXPOSE 1812/udp 1813/udp

# Copy Home Assistant add-on startup script.
COPY run.sh /run.sh

# Make startup script executable.
RUN chmod +x /run.sh

# Start FreeRADIUS.
CMD ["/run.sh"]