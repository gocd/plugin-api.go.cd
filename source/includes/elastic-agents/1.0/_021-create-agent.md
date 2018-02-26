## Create Agent

This message is a request to the plugin to create an agent for a job that has been scheduled.

<aside class="notice">
  <strong>Important:</strong> A plugin may, at its discretion, choose to not actually launch an agent. This could be because your servers do not have any capacity available, OR there are sufficient number of idle agents that may be able to fulfill the particular job configuration.
</aside>

<aside class="warning">
  <strong>Important:</strong> Since this call may potentially make network requests to spin up new agents, the server will, in order to improve performance, use multiple threads to deliver the this message. It is important that plugin implementors ensure that their code is thread-safe.
</aside>

<p class='request-name-heading'>Request name</p>

`go.cd.elastic-agent.create-agent`

<p class='request-body-heading'>Request body</p>

> Given the following config XML snippet —

```xml
<server agentAutoRegisterKey="1e0e05fc-eb45-11e5-bc83-93882adfccf6" />
<pipelines>
  <pipeline name='build'>
    <job name='...'>
      <tasks/>
      <agentConfig pluginId='...'>
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
  <environment name="gocd">
    <pipelines>
      <pipeline name="build" />
    </pipelines>
  </environment>
</environment>
```

> The plugin will receive the following JSON body —

```json
{
  "auto_register_key": "1e0e05fc-eb45-11e5-bc83-93882adfccf6",
  "environment": "production",
  "properties": {
    "ami-id": "ami-c79d704a",
    "region": "us-east-1"
  }
}
```

The request body will contain the following JSON elements:

<p class='attributes-table-follows'></p>

| Key                 | Type     | Description |
| ------------------- | -------- | ----------- |
| `auto_register_key` | `String` | The key that an agent should use, if it should be auto-registered with the server. The plugin is expected to use the key to create an appropriate `autoregister.properties` file on the agent instance, before it starts the agent process. See the [auto-register documentation](https://docs.gocd.org/current/advanced_usage/agent_auto_register.html) for more information. |
| `environment`       | `String` | The `environment` that this job belongs to. Agents are expected to auto-register using this environment so that they can be assigned to the correct job. See the [environments section](https://docs.gocd.org/current/introduction/concepts_in_go.html#environment) to know more about environments. |
| `properties`        | `Object` | Jobs that require elastic agents, will have an `<agentConfig/>` element on it. This object represents the key value pairs that form this configuration. |

<p class='response-code-heading'>Response code</p>

The plugin is expected to return status `200` if it can understand the request.

<p class='response-body-heading'>Response Body</p>

Can be left blank, the server does not parse any response body returned.
