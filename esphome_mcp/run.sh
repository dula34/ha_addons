#!/usr/bin/with-contenv bashio

bashio::log.info "Starting ESPHome MCP server..."

export ESPHOME_URL=$(bashio::config 'esphome_url')
export ESPHOME_USERNAME=$(bashio::config 'esphome_username')
export ESPHOME_PASSWORD=$(bashio::config 'esphome_password')
export ESPHOME_PSK=$(bashio::config 'esphome_psk')
export ESPHOME_HA_ADDON=$(bashio::config 'ha_addon_mode')

bashio::log.info "Connecting to ESPHome dashboard at ${ESPHOME_URL}"

exec /usr/local/bin/esphome-mcp serve --http-addr 0.0.0.0:3333
