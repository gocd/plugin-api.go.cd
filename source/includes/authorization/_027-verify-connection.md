## Verify Connection

If a plugin requires to verify connection, this message must be implemented in order to verify connection using current authorization configuration.

<p class='request-name-heading'>Request name</p>

`go.cd.authorization.plugin-config.verify-connection`

<p class='request-body-heading'>Request body</p>

> An example validation request body for LDAP plugin 

```json
{
  "Url": "ldap://foo.bar.com:389",
  "SearchBase": "ou=users,ou=system",
  "ManagerDN": "Dummy manager dn",
  "SearchFilter": "uid",
  "Password": "secret",
  "DisplayNameAttribute": "displayName",
  "EmailAttribute": "mail"
}
```
The request body will contain a configuration, for which verify connection is executed. 

<p class='response-code-heading'>Response code</p>

The plugin is expected to return status `200` if it can understand the request.

<p class='response-body-heading'>Response Body</p>

> The plugin should respond with JSON array response for each configuration key that has a validation error

```json
[
  {
    "key": "ManagerDN",
    "message": "Manager dn is invalid."
  }
]
```

The response body will contain the following JSON elements:

<p class='attributes-table-follows'></p>

| Key       | Type      | Description |
| --------- | --------- | ----------- |
| `key`     | `String`  | The name of configuration key that has an error. |
| `message` | `String`  | The error message associated with that key. |

