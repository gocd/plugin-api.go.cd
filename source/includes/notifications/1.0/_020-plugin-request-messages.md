# Requests from the GoCD server

In order to implement an elastic agent extension point the following messages must be implemented by the plugin.

* [Notifications Interested In](#notifications-interested-in)
* [Stage Status Changed](#stage-status-changed)

These are general purpose messages that a plugin may implement to allow users to configure the plugin through the browser.

* [Get Settings View](#get-settings-view)
* [Get Plugin Configuration](#get-plugin-configuration)
* [Validate Plugin Configuration](#validate-plugin-configuration)
