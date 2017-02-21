# Requests from the GoCD server

In order to implement an authorization extension point, following messages must be implemented by the plugin.

* [Get Plugin Icon](#get-plugin-icon)
* [Capabilities](#get-plugin-capabilities)
* [Get Authorization Configuration](#get-authorization-configuration-metadata)
* [Get Authorization Configuration View](#get-authorization-configuration-view)
* [Validate Authorization Configuration](#validate-authorization-configuration)
* [Authenticate User](#authenticate-user)

In order to create plugin role configuration `<pluginRole>`, following messages must be implemented by plugin.

* [Get Role Metadata](#get-role-configuration-metadata)
* [Get Role View](#get-role-configuration-view)
* [Validate Role](#validate-role-configuration)

If a plugin supports search, the following message must be implemented in order to serve search request from server.

* [Search user](#search-users)

Nice to have

* [Verify Connection](#verify-connection)
