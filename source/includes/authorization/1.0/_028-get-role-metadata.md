## Get Role Configuration Metadata

This is a message that the plugin should implement to allow users to configure role configuration(`<pluginRole>`) from the Role Configuration View in GoCD. The role configuration should provide a way for admins to map Authorization Server roles with GoCD roles(e.g map LDAP groups to GoCD roles).

<p class='request-name-heading'>Request name</p>

`go.cd.authorization.role-config.get-metadata`

<p class='request-body-heading'>Request body</p>

The server will not provide a request body.

<p class='response-code-heading'>Response Body</p>

> An example response body

```json
[
  {
    "key": "MemberOf",
    "metadata": {
      "required": true,
      "secure": false
    }
  }
]
```

The response body will contain the following JSON elements:

<p class='attributes-table-follows'></p>

| Key          | Type      | Description |
| ------------ | --------- | ----------- |
| `key`        | `String`  | The name of the configuration property supported by an authorization configuration. |
| `metadata`   | `Object`  | The metadata associated with the key used in the authorization configuration. Valid keys are `required` and `secure`. |

The plugin is expected to return status `200` if it can understand the request.
