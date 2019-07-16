## Get Secret Configuration Metadata

This is a message that the plugin should implement. The response should be a JSON which lists the required configuration and its metadata to connect to an external Secrets Manager. Users would rely on this configuration to configure the Secret Configuration (`<secretConfig>`) through the Secret Management View in GoCD.

<p class='request-name-heading'>Request name</p>

`go.cd.secrets.get-metadata`

<p class='request-body-heading'>Request body</p>

The server will not provide a request body.

<p class='response-code-heading'>Response Body</p>

> An example response body:

```json
[
  {
    "key": "FilePath",
    "metadata": {
      "required": true,
      "secure": false
    }
  }
]
```

The response body will contain the following JSON elements:

<p class='attributes-table-follows'></p>

| Key        | Type     | Description                                                                                                    |
|------------|----------|----------------------------------------------------------------------------------------------------------------|
| `key`      | `String` | The name of the configuration property supported by an secret configuration.                                   |
| `metadata` | `Object` | The metadata associated with the key used in the secret configuration. Valid keys are `required` and `secure`. |

The plugin is expected to return status `200` if it can understand the request.
