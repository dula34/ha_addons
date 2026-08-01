#!/usr/bin/with-contenv bashio

bashio::log.info "Starting FreeRadius"

set -e

PATH=/opt/sbin:/opt/bin:$PATH
export PATH

AzureAdDomain=$(bashio::config 'ad_domain')
AzureAdClientId=$(bashio::config 'ad_client')
AzureAdSecret=$(bashio::config 'ad_secret')
NASName=$(bashio::config 'nas_name')
NASNetwork=$(bashio::config 'nas_network')
NASSecret=$(bashio::config 'nas_secret')


cat >> /etc/raddb/proxy.conf <<EOF
realm $AzureAdDomain {
    oauth2 {
        discovery = "https://login.microsoftonline.com/%{Realm}/v2.0"
        client_id = "$AzureAdClientId"
        client_secret = "$AzureAdSecret"
        cache_password = yes
    }
}
EOF

cat >> /etc/raddb/clients.conf <<EOF
client $NASName {
    ipaddr = $NASNetwork
    secret = $NASSecret
}
EOF

# this if will check if the first argument is a flag
# but only works if all arguments require a hyphenated flag
# -v; -SL; -f arg; etc will work, but not arg1 arg2
if [ "$#" -eq 0 ] || [ "${1#-}" != "$1" ]; then
    set -- radiusd -X "$@"
fi

# check for the expected command
if [ "$1" = 'radiusd' ]; then
    shift
    exec radiusd -X -f "$@"
fi

# debian people are likely to call "freeradius" as well, so allow that
if [ "$1" = 'freeradius' ]; then
    shift
    exec radiusd -X -f "$@"
fi

# else default to run whatever the user wanted like "bash" or "sh"
exec "$@"