# ESPHome MCP

Runs [esphome-mcp](https://github.com/jeeftor/esphome-mcp) as a Home Assistant
add-on. It exposes a Model Context Protocol (MCP) server so LLM clients (e.g.
Claude) can manage your ESPHome devices: read/write YAML configs, compile
firmware, install OTA updates, fetch logs and read live entity states.

## Configuration

| Option | Description |
|---|---|
| `esphome_url` | URL of the ESPHome Device Builder dashboard. Defaults to `http://core_esphome:6052`, the internal address of the official ESPHome add-on. |
| `esphome_username` | Username, if the ESPHome dashboard has basic auth enabled. |
| `esphome_password` | Password, if the ESPHome dashboard has basic auth enabled. |
| `esphome_psk` | Native API encryption key (PSK), if your devices use encrypted native API connections. |
| `ha_addon_mode` | Send the `X-HA-Ingress: YES` header so requests are treated as authenticated when the ESPHome add-on's own ingress auth is enabled. Set to `false` if you disabled the ESPHome add-on's authentication instead. |

## Connecting a client

Once running, point your MCP client (Streamable HTTP transport) at:

```
http://<home-assistant-ip>:3333/mcp
```
