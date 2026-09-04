# ESPHome MCP

Runs [ESPHome-MCP](https://github.com/loryanstrant/ESPHome-MCP) as a Home
Assistant add-on. It exposes a Model Context Protocol (MCP) server so LLM
clients (e.g. Claude) can manage your ESPHome devices through the ESPHome
Device Builder dashboard.

## Configuration

| Option | Description |
|---|---|
| `esphome_dashboard_url` | URL of the ESPHome Device Builder dashboard. Defaults to `http://core_esphome:6052`, the internal address of the official ESPHome add-on. Use `https://...` if the dashboard sits behind a reverse proxy — `wss` is derived automatically. |
| `esphome_dashboard_username` | Username, if the ESPHome dashboard reports `requires_auth=true`. |
| `esphome_dashboard_password` | Password, if the ESPHome dashboard reports `requires_auth=true`. |
| `log_level` | `DEBUG`, `INFO`, `WARNING` or `ERROR`. Defaults to `INFO`. |

## Connecting a client

Once running, point your MCP client (Streamable HTTP transport) at:

```
http://<home-assistant-ip>:8080/mcp
```
