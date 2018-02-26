## Verify Connection

The plugin must implement this message in order to verify if a connection can be established with the authorization server using the authorization configuration.

The plugin is expected to validate the configuration before trying to check connection.

<p class='request-name-heading'>Request name</p>

`go.cd.authorization.auth-config.verify-connection`

<p class='request-body-heading'>Request body</p>

> An example LDAP plugin authorization configuration request body to verify connection

```json
{
  "Url": "ldap://foo.bar.com:389",
  "SearchBase": "ou=users,ou=system",
  "ManagerDN": "Dummy manager dn",
  "UserLoginFilter": "(uid={0})",
  "Password": "secret",
  "DisplayNameAttribute": "displayName",
  "EmailAttribute": "mail"
}
```
The request body will contain the authorization configuration for which verify connection is executed.

<p class='response-code-heading'>Response code</p>

The plugin is expected to return status `200` if it can understand the request.

<p class='response-body-heading'>Response Body</p>

> Example response body based on successful verification
    
```json
{
  "status": "success",
  "message": "Check connection passed"
}
```

> Example response body based on verification failed

```json
{
  "status": "failure",
  "message": "Check connection failed, unable to reach ldap://my_ldap_server"
}
```

> Example response body based on validation failed

```json
{
  "status": "validation-failed",
  "message": "Validation failed for the given authorization config",
  "errors": [
    {
      "key": "ManagerDN",
      "message": "Manager dn is invalid."
    }
  ]
}
```

The response body will contain the following JSON elements:

<p class='attributes-table-follows'></p>

| Key       | Type     | Description |
|-----------|----------|-------------|
| `status`  | `String` | Status of verify connection call, can be eithe of `success` or `failure` or `validation-failure` |
| `message` | `String` | Message corresponding to the verify connection status. |
| `errors`  | `Object` | In case of validation errors plugin should return a list of [validation error objects](#the-validation-error-object).|
