## Lookup secrets

This message must be implemented in order to access the secret key used in GoCD. The plugin would receive this message from GoCD server when it tries to resolve the secret param.

<p class='request-name-heading'>Request name</p>

`go.cd.secrets.secrets-lookup`

<p class='request-body-heading'>Request body</p>

> An example lookup request body for File based secret plugin

```json
{
  "configuration": {
    "SecretFilePath":"path\to\test_secrets.db"
  },
  "keys": [ "key1", "key2" ]
}
```

The request body will contain the configuration from secret configuration and list of lookup keys to resolve.

<p class='response-code-heading'>Response code</p>

The plugin is expected to return status `200` if it can understand the request and is able to resolve all the given lookup keys.

<p class='response-body-heading'>Response Body</p>

> The plugin should respond with JSON array response containing the list of resolved key-value pair

```json
[
  {
    "key": "key1",
    "value": "value1"
  },
  {
    "key": "key2",
    "value": "value2"
  }
]
```

> The plugin should respond with JSON object with a proper error message if it fails to resolve any lookup key(s)

```json
{
 "message": "Unable to resolve lookup key(s) [key1, key2]"
}
```

A JSON [lookup object](#the-lookup-response-object)
