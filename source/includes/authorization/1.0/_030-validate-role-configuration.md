## Validate Role Configuration

If a plugin requires any authorization configuration, this message must be implemented in order to validate the configuration.

<p class='request-name-heading'>Request name</p>

`go.cd.authorization.role-config.validate`

<p class='request-body-heading'>Request body</p>

> An example validation request body for LDAP plugin

```json
{
  "MemberOf": "ou=blackbird,ou=area51,dc=example,dc=com"
}
```

The request body will contain a role configuration, for which validation would have been called.

<p class='response-code-heading'>Response code</p>

The plugin is expected to return status `200` if it can understand the request.

<p class='response-body-heading'>Response Body</p>

> The plugin should respond with JSON array response for each configuration key that has a validation error

```json
[
  {
   "key": "MemberOf",
   "message": "MemberOf cannot be blank"
  }
]
```

If any of the input keys have a validation error on them, the plugin is expected to return a list of [validation error objects](#the-validation-error-object). If the configuration is valid, the plugin should return an empty JSON array.
