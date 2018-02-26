## Authorization Server URL

This is a message that a web based plugin should implement. A web based plugin uses an external authorization server for authentication. For this request the plugin should return the URL of the external authorization server to which GoCD redirects the user for authentication.

<p class='request-name-heading'>Request name</p>

`go.cd.authorization.authorization-server-url`

<p class='request-body-heading'>Request body</p>

> The plugin will receive the following JSON body which is a list of all auth configs configured for the plugin —

```json
{
  "auth_configs": [{
    "id": "github_oauth",
    "configuration": {
      "url": "http://git_hub.com",
      "client_id": "jd9no0f",
      "client_secret": "0njfg8fgmfvufv"
    }
  }],
  "authorization_server_callback_url": "http://my_go_server/go/plugin/my_plugin_id/authenticate"
}
```


<p class='attributes-table-follows'></p>

| Key                                 | Type     | Description                                                                                                     |
|-------------------------------------|----------|-----------------------------------------------------------------------------------------------------------------|
| `auth_configs`                      | `Object` | This key contains list of `<authconfig>` configured for the plugin.                                             |
| `authorization_server_callback_url` | `String` | This key contains the GoCD url to which the authorization server should redirect on a successful authentication |


<p class='response-code-heading'>Response Body</p>

> An example response body —


```json
{
  "authorization_server_url": "http://external_auth_server_url/login?redirect_url=http://my_go_server/go/plugin/my_plugin_id/authenticate&client_id=hdfjh3r&client_secret=vbvdv1493"
}
```

The response body will contain the following JSON elements:


<p class='attributes-table-follows'></p>

| Key                        | Type     | Description                                                                                 |
|----------------------------|----------|---------------------------------------------------------------------------------------------|
| `authorization_server_url` | `String` | The external authorization server URL to which GoCD redirects the user for authentication.  |

The plugin is expected to return status `200` if it can understand the request.
