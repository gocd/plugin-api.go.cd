# Requests from the GoCD server

In order to implement an elastic agent extension point the following messages must be implemented by the plugin.

* [Create Agent](#create-agent)
* [Should Assign Work](#should-assign-work)
* [Server Ping](#server-ping)

These are general purpose messages that a plugin must implement to allow users to configure the plugin through the browser.

* [Get Settings View](#get-settings-view)
* [Get Plugin Configuration](#get-plugin-configuration)
* [Validate Plugin Configuration](#validate-plugin-configuration)
* [Get Plugin Icon](#get-plugin-icon)

These are messages that a plugin must implement in order to allow users to configure elastic profiles through the browser.

* [Validate Profile](#validate-profile)
* [Get Profile View](#get-profile-view)
* [Get Profile Metadata](#get-profile-metadata)
