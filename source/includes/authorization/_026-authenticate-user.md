## Authenticate User

This message is a request to the plugin to authenticate and authorize a user, along with the user credentials and all known `<authConfig />` configured for the plugin.

<p class='request-name-heading'>Request name</p>

`go.cd.authorization.authenticate-user`

<p class='request-body-heading'>Request body</p>

> The plugin will receive the following JSON body for password based authorization —

```json
{
  "username": "jdoe",
  "password": "secret",
  "profiles": {
    "ldap1": {
      "Url": "ldap://ldap1.example.com",
      "...": "..."
    },
    "ldap2": {
      "Url": "ldap://ldap2.example.com",
      "...": "..."
    }
  }
}
```

<p class='attributes-table-follows'></p>

| Key        | Type     | Description                                                                   |
|------------|----------|-------------------------------------------------------------------------------|
| `username` | `String` | This key contains value for `username` provided by user at the time of login. |
| `password` | `String` | This key contains value for `password` provided by user at the time of login. |
| `profiles` | `Object` | This key contains list of `<authconfig>` configured for plugin. |

<p class='response-code-heading'>Response Body</p>

> An example response body —

```json
{
  "user": {
    "username": "jdoe",
    "display_name": "John Doe",
    "email_id": "jdoe@example.com"
  },
  "roles": ["blackbird", "spacetiger"]
}
```

The response body will contain the following JSON elements:

<p class='attributes-table-follows'></p>

| Key                   | Type      | Description |
| --------------------- | --------- | ----------- |
| `user`                | `Object`  | This json object contains user details like `username`, `display_name` and `email_id`. |
| `roles`               | `Array`   | Array of roles associated with authenticated user. |

The plugin is expected to return status `200` if it can understand the request.
