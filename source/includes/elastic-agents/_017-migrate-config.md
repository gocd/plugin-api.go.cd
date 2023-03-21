## Migrate config

This message is a request to the plugin perform migration of the existing config on load of the plugin. This allows 
a plugin to perform the migration on the existing config in order to support the newer version of the plugin. 

<aside class="warning">
  <strong>Important:</strong> Starting from elastic agent extension version v5 the plugin settings are not supported for 
  the extension and we expect plugin author to migrate existing plugin settings to the cluster profile. 
</aside>

<aside class="notice">
  <strong>Important:</strong> The GoCD server will update the `cluster profiles` and `elastic profiles` in configuration
  as returned by the plugin in the response body. The plugin settings won't be deleted and will remain unchanged. This 
  allows users to revert to a previous version of the plugin without any manual intervention.  
</aside>

<p class='request-name-heading'>Request name</p>

`cd.go.elastic-agent.migrate-config`

<p class='request-body-heading'>Request body</p>

> The plugin will receive the following JSON body —

```json
{
  "cluster_profiles": [
    {
      "id": "cluster_profile_id",
      "plugin_id": "plugin_id",
      "properties": {
        "some_key": "some_value",
        "some_key2": "some_value2"
      }
    }
  ],
  "elastic_agent_profiles": [
    {
      "id": "profile_id",
      "plugin_id": "plugin_id",
      "cluster_profile_id": "cluster_profile_id",
      "properties": {
        "some_key": "some_value",
        "some_key2": "some_value2"
      }
    }
  ],
  "plugin_settings": {
    "url": "https://some-url",
    "password": "my-password"
  }
}
```

<p class='attributes-table-follows'></p>

| Key                         | Type      | Description                                               |
| --------------------------- | --------- | --------------------------------------------------------- |
| `cluster_profiles`          | `Array`   | List of cluster profiles configured for the plugin.       |
| `elastic_agent_profiles`    | `Array`   | List of elastic agent profiles configured for the plugin. |
| `plugin_settings`           | `Array`   | Plugin settings of the plugin.                            |

<p class='response-code-heading'>Response Body</p>

> An example response body:

```json
{
  "cluster_profiles": [
    {
      "id": "cluster_profile_id",
      "plugin_id": "plugin_id",
      "properties": {
        "some_key": "some_value",
        "some_key2": "some_value2"
      }
    },
    {
      "id": "migrated_from_plugin_settings",
      "plugin_id": "plugin_id",
      "properties": {
        "url": "https://some-url",
        "password": "my-password"
      }
    }
  ],
  "elastic_agent_profiles": [
    {
      "id": "profile_id",
      "plugin_id": "plugin_id",
      "cluster_profile_id": "cluster_profile_id",
      "properties": {
        "some_key": "some_value",
        "some_key2": "some_value2"
      }
    }
  ]
}
```

The response body will contain the following JSON elements:

<p class='attributes-table-follows'></p>

| Key                       | Type      | Description                                               |
| ------------------------- | --------- | --------------------------------------------------------  |
| `cluster_profiles`        | `Array`   | List of cluster profiles configured for the plugin.       |
| `elastic_agent_profiles`  | `Array`   | List of elastic agent profiles configured for the plugin. |

The plugin is expected to return status `200` if it can understand the request otherwise the plugin will be marked as 
invalid.
