## Lookup secrets

This message is a request to the plugin to look up for secrets for a given list of keys.

The plugin would receive this message from GoCD when it tries to resolve a secret param. Apart from the list of keys in the JSON request, the request body will also have the configuration required to connect and lookup for secrets from the external Secret Manager.

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

<p class='attributes-table-follows'></p>

The request body will contain the following JSON elements:

| Key             | Type     | Description                                                                                      |
|-----------------|----------|--------------------------------------------------------------------------------------------------|
| `configuration` | `Object` | The secret configuration associated with the plugin.                                             |
| `keys`          | `Array`  | A list of keys which needs to be resolved with <br/> actual secret defined in external Secret Manager  |


<p class='response-code-heading'>Response code</p>

The plugin is expected to return status `200` if it can understand the request and is able to resolve all the given lookup keys.

If the plugin is unable to resolve all the keys it should return status `404`, for any other errors during lookup return `500`.

<p class='response-body-heading'>Response Body</p>

The response body should contain a JSON array with the following JSON elements:

| Key     | Type     | Description                                |
|---------|----------|--------------------------------------------|
| `key`   | `String` | The secret key which has been resolved.    |
| `value` | `String` | The value corresponding to the secret key. |


The error response body should contain the following JSON elements:

| Key       | Type     | Description                                                                          |
|-----------|----------|--------------------------------------------------------------------------------------|
| `message` | `String` | The error message with reason for error or list of keys<br/> which could not be resolved. |

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
