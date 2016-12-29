## Should Assign Work

When there are multiple agents available to run a job, the server will ask the plugin if jobs should be assigned to a particular agent. The request will contain information about the agent, the job configuration and the environment that the agent belongs to.

<p class='request-name-heading'>Request name</p>

`go.cd.elastic-agent.should-assign-work`

<p class='request-body-heading'>Request body</p>

> Given the following config XML snippet —

```xml
<server agentAutoRegisterKey="1e0e05fc-eb45-11e5-bc83-93882adfccf6" />
<pipelines>
  <pipeline name='build'>
    <job name='...'>
      <tasks/>
      <agentConfig pluginId='com.example.go.testplugin'>
        <property>
          <key>ami-id</key>
          <value>ami-c79d704a</value>
        </property>
        <property>
          <key>region</key>
          <value>us-east-1</value>
        </property>
      </agentConfig>
    </job>
  </pipeline>
</pipelines>
<environments>
  <environment name="staging">
    <pipelines>
      <pipeline name="build" />
    </pipelines>
  </environment>
</environment>
<agents>
  <agent elasticAgentId='i-283432d4' elasticPluginId='com.example.go.testplugin' />
</agents>
```

> The plugin will receive the following JSON body —

```json
{
  "environment": "staging",
  "agent": {
    "agent_id": "i-283432d4",
    "agent_state": "Idle",
    "build_state": "Idle",
    "config_state": "Enabled"
  },
  "properties": {
    "property_name": "property_value"
  }
}
```

The request body will contain the following JSON elements:

<p class='attributes-table-follows'></p>

| Key                 | Type     | Description |
| ------------------- | -------- | ----------- |
| `environment`       | `String` | The `environment` that this job belongs to. See the [environments section](https://docs.gocd.io/current/introduction/concepts_in_go.html#environment) to know more about environments. |
| `agent`             | `Object` | An object describing the [elastic agent](#elastic-agent-object). |
| `properties`        | `Object` | Jobs that require elastic agents, will have an `<agentConfig/>` element on it. This object represents the key value pairs that form this configuration. |

<p class='response-code-heading'>Response code</p>

The plugin is expected to return status `200` if it can understand the request.

<p class='response-body-heading'>Response Body</p>

The server must return a JSON string response with a boolean — `true` or `false` to indicate whether the agent should be assigned work.
