#!/bin/sh
set -e

CONFIG_PATH=/data/options.json

get_option() {
  python3 -c "import json; v = json.load(open('$CONFIG_PATH')).get('$1') or ''; print(v)"
}

export ESPHOME_DASHBOARD_URL="$(get_option esphome_dashboard_url)"
export ESPHOME_DASHBOARD_USERNAME="$(get_option esphome_dashboard_username)"
export ESPHOME_DASHBOARD_PASSWORD="$(get_option esphome_dashboard_password)"
export LOG_LEVEL="$(get_option log_level)"

echo "[esphome_mcp] Connecting to ESPHome dashboard at ${ESPHOME_DASHBOARD_URL}"

exec esphome-mcp-web
