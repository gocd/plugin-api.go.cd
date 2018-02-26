## Validate Configuration

> An example validation request body

```json
{
  "URL": {
    "secure": false,
    "value": "http://localhost.com",
    "required": true
  },
  "USERNAME": {
    "secure": false,
    "value": "user",
    "required": false
  },
  "PASSWORD": {
    "secure": true,
    "value": "password",
    "required": false
  }
}
```

> An example response body, in case there are validation errors

```json
{
  "errors": {
    "URL": "URL is not well formed",
    "USERNAME": "Invalid character present"
  }
}
```

> An example response body, in case there are no validation errors

```json
{
  "errors": {}
}
```

This message is sent by the GoCD server to the plugin to validate if the settings entered by the user are valid, so that the server may persist those settings in the `cruise-config.xml` file.

<p class='request-name-heading'>Request name</p>

`validate`

<p class='request-body-heading'>Request body</p>

The request body will contain a JSON, which contains an object with the configuration keys and values that the plugin is expected to validate. If the configuration is valid, the `errors` object should be empty `{}`.

<p class='response-code-heading'>Response code</p>

The plugin is expected to return status `200` if it can understand the request.

<p class='response-body-heading'>Response Body</p>

The plugin is expected to return an error object validation errors.
