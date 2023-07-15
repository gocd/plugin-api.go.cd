## Fetch Access Token

This is a message that a web based plugin should implement. In case of web based authentication a user is authenticated by an external authorization server. On successful authentication, the authorization server should redirect to GoCD endpoint returned by [authorization server url](#authorization-server-url) request. We would refer to these requests as pre-authenticated requests. Depending upon the authorization server, the pre-authenticated requests can contain user information either in HTTP header or request params. GoCD, upon receiving a pre-authenticated request, would make the fetch access token request to the plugin by passing all the user information provided by the authorization server. The plugin in turn should exchange this information with the authorization server to request for an access token to make subsequent requests on behalf of the user.


<p class='request-name-heading'>Request name</p>

`go.cd.authorization.fetch-access-token`

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
  "auth_session": {
    "key": "value"
  }
}
```


<p class='attributes-table-follows'></p>

| Key            | Type     | Description                                                                                                                                                                                                                                          |
|----------------|----------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `auth_configs` | `Object` | This key contains list of `<authconfig>` configured for the plugin.                                                                                                                                                                                  |
| `role_configs` | `Object` | This key contains list of `<roleconfig>` configured for the plugin.                                                                                                                                                                                  |
| `auth_session` | `Object` | This key contains a flat object/dictionary of string keys and values that was previously provided during the [get authentication server URL](#authorization-server-url) exchange. Will be empty if nothing was earlier supplied, and can be ignored. |

See [get authentication server URL](#authorization-server-url) for an example of how `auth_session` might be used for additional validation
within these subsequent calls.

<p class='request-body-heading'>Request parameters</p>

Request parameters would contain all request parameters sent by the external authorization server to GoCD.

<p class='request-body-heading'>Request headers</p>

Request headers would contain all the HTTP request headers sent by the external authorization server to GoCD.

<p class='response-code-heading'>Response Body</p>

The response should be a JSON with the necessary information required by the plugin to make any subsequent calls to the authorization server on behalf of the user.
GoCD would pass the returned json as credentials for the [Authenticate User](#authenticate-user) request.

The plugin is expected to return status `200` if it can understand the request.
