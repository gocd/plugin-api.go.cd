## Validate Authorization Configuration

This message must be implemented in order to validate the configuration. The plugin would receive this message from GoCD server during config save.

<p class='request-name-heading'>Request name</p>

`go.cd.authorization.auth-config.validate`

<p class='request-body-heading'>Request body</p>

> An example validation request body for LDAP plugin

```json
{
  "Url": "Any invalid Url",
  "SearchBase": "ou=users,ou=system",
  "ManagerDN": "uid=admin,ou=system",
  "SearchFilter": "uid",
  "Password": "secret",
  "DisplayNameAttribute": "displayName",
  "EmailAttribute": "mail"
}
```

The request body will contain a configuration from authorization configuration, for which validation would have been called.

<p class='response-code-heading'>Response code</p>

The plugin is expected to return status `200` if it can understand the request.

<p class='response-body-heading'>Response Body</p>

> The plugin should respond with JSON array response for each configuration key that has a validation error

```json
[
  {
   "key": "Url",
   "message": "Url is invalid."
  }
]
```

If any of the input keys have a validation error on them, the plugin is expected to return a list of [validation error objects](#the-validation-error-object). If the configuration is valid, the plugin should return an empty JSON array.
