## Get User Roles

This is a message that a web based plugin should implement, in case the plugin supports `can_get_user_roles` [capability](#get-plugin-capabilities). The plugin will receive this message when GoCD requires to reauthorize the user. 

   - e.g. while accessing API(s) via Access Token.

<p class='request-name-heading'>Request name</p>

`go.cd.authorization.get-user-roles`

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
  "role_configs": [
    {
      "auth_config_id": "ldap",
      "configuration": {
        "key2": "value2"
      },
      "name": "super-admin"
    }
  ],
  "username": "Bob"
}
```


<p class='attributes-table-follows'></p>

| Key            | Type     | Description                                                                   |
|----------------|----------|-------------------------------------------------------------------------------|
| `auth_config`  | `Object` | This key represents `<authconfig>` configured for the plugin.                 |
| `role_configs` | `Object` | This key contains list of `<roleconfig>` configured for the `<authconfig>`. |
| `username`     | `String` | This key represents username of the user for which this request has been made.|

<p class='request-body-heading'>Request parameters</p>

The server will not provide any parameters.

<p class='request-body-heading'>Request headers</p>

The server will not provide any headers.

<p class='response-code-heading'>Response Body</p>

The response should be a JSON array of `String` which represents role names assigned to the given user.

The plugin is expected to return status `200` if it can understand the request.
