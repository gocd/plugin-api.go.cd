## Get Plugin Capabilities

This message is a request to the plugin to provide plugin capabilities. Based on these capablities GoCD would enable or disable the plugin features for a user.

<p class='request-name-heading'>Request name</p>

`go.cd.authorization.get-capabilities`

<p class='request-body-heading'>Request body</p>

Server sends request with `Empty` request body.

<p class='response-code-heading'>Response Body</p>

> An example response body —

```json
{
  "supported_auth_type": "password",
  "can_search": true,
  "can_authorize": true
}
```

The response body will contain the following JSON elements:

<p class='attributes-table-follows'></p>

| Key                   | Type      | Description                                                                             |
|-----------------------|-----------|-----------------------------------------------------------------------------------------|
| `supported_auth_type` | `String`  | This key determines plugin authentication method. It can be one of `password` or `web`. |
| `can_search`          | `Boolean` | Whether Plugin supports search or not, depends on this `boolean` value.                 |
| `can_authorize`       | `Boolean` | Whether Plugin supports authorization, depends on this `boolean` value.                 |

The plugin is expected to return status `200` if it can understand the request.
