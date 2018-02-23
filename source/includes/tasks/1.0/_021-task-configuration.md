## Task Configuration

> An example response body

```json
{
  "url": {
    "default-value": "",
    "secure": false,
    "required": true
  },
  "user": {
    "default-value": "bob",
    "secure": true,
    "required": true
  },
  "password": {}
}
```

This message is sent by the GoCD server to the plugin to know what properties are supported by this plugin that should to be stored in the `cruise-config.xml` file.

<p class='request-name-heading'>Request name</p>

`configuration`

<p class='request-body-heading'>Request body</p>

The server will not provide a request body.

<p class='response-code-heading'>Response code</p>

The plugin is expected to return status `200` if it can understand the request.

<p class='response-body-heading'>Response Body</p>

The plugin is expected to return an object containing the configuration property along with [task configuration properties](#the-task-configuration-response-object)
