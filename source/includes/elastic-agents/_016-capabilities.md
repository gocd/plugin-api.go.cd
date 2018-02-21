## Get Plugin Capabilities

This message is a request to the plugin to provide plugin capabilities. Based on these capabilities GoCD would enable or disable the plugin features for a user.

<p class='request-name-heading'>Request name</p>

`go.cd.elastic-agent.get-capabilities`

<p class='request-body-heading'>Request body</p>

Server sends request with `Empty` request body.

<p class='response-code-heading'>Response Body</p>

> An example response body —

```json
{
  "supports_status_report": true
}
```

The response body will contain the following JSON elements:

<p class='attributes-table-follows'></p>

| Key                      | Type      | Description                                                                             |
|--------------------------|-----------|-----------------------------------------------------------------------------------------|
| `supports_status_report` | `String`  |  Whether plugin supports status [Agent status report](#get-agent-status-report) and [Plugin status report](#get-plugin-status-report) or not, depends on this `boolean` value |


The plugin is expected to return status `200` if it can understand the request.
