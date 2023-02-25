## Is Valid User

This is a message that a plugin should implement, in case of access token based authentication. User can configure access 
token after authenticating him/her self using the plugin. The plugin will receive this message when a user is trying to 
access API(s) via access token created using the same plugin.

<p class='request-name-heading'>Request name</p>

`go.cd.authorization.is-valid-user`

<p class='request-body-heading'>Request body</p>

> The plugin will receive the following JSON body which is a list of all auth configs configured for the plugin —

```json
{
  "auth_config": {
    "configuration": {
      "key1": "value2"
    },
    "id": "ldap"
  },
  "username": "Bob"
}
```


<p class='attributes-table-follows'></p>

| Key            | Type     | Description                                                                               |
|----------------|----------|-------------------------------------------------------------------------------------------|
| `auth_config`  | `Object` | This key represents the `<authconfig>` using which token is created.                      |
| `username`     | `String` | This key represents username of the user for which this validation request has been made. |

<p class='request-body-heading'>Request parameters</p>

The server will not provide any parameters.

<p class='request-body-heading'>Request headers</p>

The server will not provide any headers.

<p class='response-code-heading'>Response Body</p>

The plugin is expected to return status `200` if the user belongs to specified username is still valid.
