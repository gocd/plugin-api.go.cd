## Invalidate Users Cache

This message allows a plugin invalidate logged in user session in GoCD.

With authorization plugins a user is authenticated using an external authorization server, upon successful authentication GoCD creates a looged in session for the user. Changes on the external authorization server like removing a user or change of role needs to be notified to GoCD. This message can be used by plugins to trigger a re-authentication of users in GoCD.
  
<p class='request-name-heading'>Request name</p>

`go.processor.authorization.invalidate-cache`

<p class='request-body-heading'>Request body</p>

The server will not parse a request body.

<p class='response-code-heading'>Response code</p>

The plugin is expected to return status `200` if it can understand the request.

The server will not provide any response body.
