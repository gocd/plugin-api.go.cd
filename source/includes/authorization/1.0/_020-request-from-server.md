# Requests from the GoCD server

Authorization extension exposes endpoints to support authentication and authorization.

All Authorization plugins should implement the following messages to support authentication.

* [Get Plugin Icon](#get-plugin-icon)
* [Capabilities](#get-plugin-capabilities)
* [Get Authorization Configuration](#get-authorization-configuration-metadata)
* [Get Authorization Configuration View](#get-authorization-configuration-view)
* [Validate Authorization Configuration](#validate-authorization-configuration)
* [Authenticate User](#authenticate-user)
* [Authorization Server URL](#authorization-server-url)
* [Verify Connection](#verify-connection)

If a plugin supports web based authentication, apart from the above, the plugin must implement the following messages. The plugin should use the `supported_auth_type` [capability](#get-plugin-capabilities) to expose this feature.

* [Fetch Access Token](#fetch-access-token)
* [Get Authorization Server Redirect URL](#authorization-server-redirect-url)

For a plugin to support authorization, the following messages must be implemented. The plugin should use the `can_authorize` [capability](#get-plugin-capabilities) to expose this feature.

* [Get Role Metadata](#get-role-configuration-metadata)
* [Get Role View](#get-role-configuration-view)
* [Validate Role](#validate-role-configuration)

If a plugin supports search, the following message must be implemented in order to serve search request from server. The plugin should use the `can_search` [capability](#get-plugin-capabilities) to expose this feature.

* [Search user](#search-users)
