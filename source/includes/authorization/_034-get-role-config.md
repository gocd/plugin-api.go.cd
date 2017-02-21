## Get Role Configurations

This message allows a plugin to query the server for a list of Role Configurations that belong to a particular plugin.

<p class='request-name-heading'>Request name</p>

`go.processor.authorization.get-role-config`

<p class='request-body-heading'>Request body</p>

The body must contain a `auth_config_id` for which plugin inquired role config.

> An example request body

```json
{
  "auth_config_id": "foo-ldap"
}
```

<p class='response-code-heading'>Response code</p>

The plugin is expected to return status `200` if it can understand the request.

<p class='response-body-heading'>Response Body</p>

> The server will send a JSON array of Role Configurations

```json
[
  {
    "name": "blackbird",
    "configuration": {
      "memberOf": "ou=blackbird,ou=area51,dc=example,dc=com"
    }
  },
  {
    "name": "redflower",
    "configuration": {
      "group": "ou=dev,ou=area51,dc=example,dc=com"
    }
  }
]
```

The response body will contain a JSON array of `Role` with following elements

<p class='attributes-table-follows'></p>

| Key             | Type     | Description                      |
|-----------------|----------|----------------------------------|
| `name`          | `String` | Name of `<pluginRole>`           |
| `configuration` | `String` | Configuration for `<pluginRole>` |
