## Stage Status Changed

This message is sent by the server, when it wants to notify the plugin about a "stage status change".

<p class='request-name-heading'>Request name</p>

`stage-status`

<p class='request-body-heading'>Request body</p>

> An example stage status changed request body

```json
{
  "pipeline": {
    "name": "pipeline-name",
    "counter": "1",
    "label": "pipeline-label",
    "group": "pipeline-group",
    "build-cause": [
      {
        "material": {
          "git-configuration": {
            "shallow-clone": false,
            "branch": "branch",
            "url": "http://user:******@gitrepo.com"
          },
          "type": "git"
        },
        "changed": true,
        "modifications": [
          {
            "revision": "1",
            "modified-time": "2016-04-06T12:50:03.317Z",
            "data": {}
          }
        ]
      }
    ],
    "stage": {
      "name": "stage-name",
      "counter": "1",
      "approval-type": "success",
      "approved-by": "changes",
      "state": "Passed",
      "result": "Passed",
      "create-time": "2011-07-13T19:43:37.100Z",
      "last-transition-time": "2011-07-13T19:43:39.100Z",
      "jobs": [
        {
          "name": "job-name",
          "schedule-time": "2011-07-13T19:43:37.100Z",
          "assign-time": "2011-07-13T19:43:38.100Z",
          "complete-time": "2011-07-13T19:43:39.100Z",
          "state": "Completed",
          "result": "Passed",
          "agent-uuid": "uuid"
        }
      ]
    }
  }
}
```

The request body will contain a JSON representing the stage.

<p class='response-code-heading'>Response code</p>

The plugin is expected to return status `200` if it can understand the request.

<p class='response-body-heading'>Response Body</p>

> An example response body if the plugin could send the notification successfully

```json
{
  "status": "success"
}
```

> An example response body if the plugin could not send the notification

```json
{
  "status": "failure",
  "messages": ["Could not send email for build/1/compile/1"]
}
```

The plugin is expected to return a JSON object to indicate if the notifications could be processed.

<aside class="warning">
  <strong>Note</strong>: If plugin responds with error messages Go Server shows those in "server health messages".
</aside>
