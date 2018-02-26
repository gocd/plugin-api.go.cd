## Server Ping

Each elastic agent plugin will receive a periodic signal at regular intervals for it to perform any cleanup operations. Plugins may use this message to disable and/or terminate agents at their discretion.

<aside class="warning">
  <strong>Important:</strong> Since this call may potentially make network requests to terminate agents, the server will, in order to improve performance, use multiple threads to deliver the this message. It is important that plugin implementors ensure that their code is thread-safe.
</aside>

<p class='request-name-heading'>Request name</p>

`go.cd.elastic-agent.server-ping`

<p class='request-body-heading'>Request body</p>

The server will not provide a request body.

<p class='response-code-heading'>Response code</p>

The plugin is expected to return status `200` if it can understand the request.

<p class='response-body-heading'>Response Body</p>

Can be left blank, the server does not parse any response body returned.
