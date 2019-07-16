## Validate Secret Configuration

This message must be implemented in order to validate the configuration. The plugin would receive this message from GoCD server during config save.

<p class='request-name-heading'>Request name</p>

`go.cd.secrets.validate`

<p class='request-body-heading'>Request body</p>

> An example validation request body for File based secret plugin

```json
{
  "SecretsFilePath": "path\to\test_secrets.db"
}
```

The request body will contain the JSON array with the keys and values that form the part of the Secret Configuration.

<p class='response-code-heading'>Response code</p>

The plugin is expected to return status `200` if it can understand the request.

<p class='response-body-heading'>Response Body</p>

> The plugin should respond with JSON array response for each configuration key that has a validation error

```json
[
  {
   "key": "SecretsFilePath",
   "message": "No file exists at the given path"
  }
]
```

If any of the input keys have a validation error on them, the plugin is expected to return a list of [validation error objects](#the-validation-error-object). If the configuration is valid, the plugin should return an empty JSON array.
