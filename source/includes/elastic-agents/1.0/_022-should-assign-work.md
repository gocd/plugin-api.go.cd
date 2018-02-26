## Should Assign Work

When there are multiple agents available to run a job, the server will ask the plugin if jobs should be assigned to a particular agent. The request will contain information about the agent, the job configuration and the environment that the agent belongs to.
This allows plugin to decide if proposed agent is suitable to schedule a job on it. For example, plugin can check if flavor or region of VM is suitable.

<p class='request-name-heading'>Request name</p>

`go.cd.elastic-agent.should-assign-work`

<p class='request-body-heading'>Request body</p>

> Given the following config XML snippet —

```xml
<server agentAutoRegisterKey="1e0e05fc-eb45-11e5-bc83-93882adfccf6" />
<profile id="ec2.small-us-east" pluginId="com.example.ec2">
  <property>
    <key>ami-id</key>
    <value>ami-6ac7408f</value>
  </property>
  <property>
    <key>region</key>
    <value>us-east-1</value>
  </property>
</profile>
<pipelines>
  <pipeline name='build'>
    <job name="run-upgrade" runOnAllAgents="true" timeout='30' elasticProfileId="ec2.small-us-east">
      <tasks>
        <ant target="upgrade" />
      </tasks>
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
    "ami-id": "ami-6ac7408f",
    "region" : "us-east-1"
  }
}
```

The request body will contain the following JSON elements:

<p class='attributes-table-follows'></p>

| Key                 | Type     | Description |
| ------------------- | -------- | ----------- |
| `environment`       | `String` | The `environment` that this job belongs to. See the [environments section](https://docs.gocd.org/current/introduction/concepts_in_go.html#environment) to know more about environments. |
| `agent`             | `Object` | An object describing the [elastic agent](#elastic-agent-object). |
| `properties`        | `Object` | Jobs that require elastic agents, will have an `elasticPluginId` attribute on it, which refers to elastic `<profile/>` element. This object represents the key value pairs from the `<profile/>` element. |

<p class='response-code-heading'>Response code</p>

The plugin is expected to return status `200` if it can understand the request.

<p class='response-body-heading'>Response Body</p>

The server must return a JSON string response with a boolean — `true` or `false` to indicate whether the agent should be assigned work.
