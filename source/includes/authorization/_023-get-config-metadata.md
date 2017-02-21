## Get Authorization Configuration Metadata

This is a message that the plugin should implement, to allow users to configure authorization configuration (`<authConfig>`) from the Authorization Configuration View in GoCD.

<p class='request-name-heading'>Request name</p>

`go.cd.authorization.plugin-config.get-metadata`

<p class='request-body-heading'>Request body</p>

The server will not provide a request body.

<p class='response-code-heading'>Response Body</p>

> An example response body

```json
[
  {
    "key": "Url",
    "metadata": {
      "required": true,
      "secure": false
    }
  },
  {
    "key": "ManagerDN",
    "metadata": {
      "required": true,
      "secure": false
    }
  }
]
```

The response body will contain the following JSON elements:

<p class='attributes-table-follows'></p>

| Key        | Type     | Description                                                                                                           |
|------------|----------|-----------------------------------------------------------------------------------------------------------------------|
| `key`      | `String` | The name of the configuration property supported by an authorization configuration.                                   |
| `metadata` | `Object` | The metadata associated with the key used in the authorization configuration. Valid keys are `required` and `secure`. |

The plugin is expected to return status `200` if it can understand the request.
