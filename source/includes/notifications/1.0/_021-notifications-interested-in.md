## Notifications Interested In

This message is a request to the plugin to check what sort of notifications the plugin is interested to receive.


<p class='request-name-heading'>Request name</p>

`notifications-interested-in`

<p class='request-body-heading'>Request body</p>

The server will not provide a request body.

<p class='response-code-heading'>Response code</p>

The plugin is expected to return status `200` if it can understand the request.

<p class='response-body-heading'>Response Body</p>

The plugin is expected to return a JSON object with the key `notifications` that lists all notifications.

Currently supported notifications include:

* `stage-status`. See [stage status changed](#stage-status-changed) for the information that the plugin receives on stage status change.

> An example response body

```json
{
  "notifications": ["stage-status"]
}
```
