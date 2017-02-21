## Search users

If a plugin supports search, this message must be implemented in order for GoCD users to search for users in external authorization systems.

<p class='request-name-heading'>Request name</p>

`go.cd.authorization.search-users`

<p class='request-body-heading'>Request body</p>

> An search request body

```json
{
  "search_term": "queried string",
  "profiles": {
    "foo-ldap": {
      "Url": "ldap://foo.url"
    },
    "bar-ldap": {
      "Url": "ldap://bar.url"
    }
  }
}
```

<p class='attributes-table-follows'></p>

The request body will contain the following JSON elements:

| Key           | Type     | Description                            |
|---------------|----------|----------------------------------------|
| `search_term` | `String` | The search string entered by the user. |
| `profiles`    | `Object` | This key contains list of `<authconfig>` configured for plugin. |

<p class='response-code-heading'>Response code</p>

The plugin is expected to return status `200` if it can understand the request.

<p class='response-body-heading'>Response Body</p>

> The plugin should respond with JSON array of users

```json
[
  {
    "username": "sbanks",
    "display_name": "Sarah Banks",
    "email_id": "sbanks@example.com"
  },
  {
    "username": "pbanks",
    "display_name": "Phillip Banks",
    "email_id": "pbanks@example.com"
  }
]
```

Plugin should respond with JSON array of users and each user must have following JSON elements in it.

<p class='attributes-table-follows'></p>

| Key            | Type      | Description |
| -------------- | --------- | ----------- |
| `username`     | `String`  | `username` of user which has to be unique  across user base. |
| `display_name` | `String`  | `display_name` of user which gets displayed on GoCD  server. If `display_name` is not provided then `username` will be displayed. |
| `email_id`     | `String`  | `email_id` of user |
