## Task View

> An example response body

```json
{
  "displayValue": "MavenTask",
  "template": "<div class=\"form_item_block\">...</div>"
}
```

This message is sent by the GoCD server to the plugin to get an AngularJS based HTML template to allow the task to be configured.

<p class='request-name-heading'>Request name</p>

`view`

<p class='request-body-heading'>Request body</p>

The server will not provide a request body.

<p class='response-code-heading'>Response code</p>

The plugin is expected to return status `200` if it can understand the request.

<p class='response-body-heading'>Response Body</p>

The plugin is expected to return an object containing the view rendering information [task view response object](#the-task-view-response-object)
