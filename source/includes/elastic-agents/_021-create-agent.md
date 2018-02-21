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
<elastic>
  <profiles>
    <profile id="gocd-dev-build" pluginId="plugin-id">
      <property>
        <key>Image</key>
        <value>gocd/gocd-agent-alpine-3.5:v18.1.0</value>
      </property>
      <property>
        <key>MaxMemory</key>
        <value>500Mb</value>
      </property>
    </profile>
  </profiles>
</elastic>
<pipelines group="first">
  <pipeline name="build">
    ...
    <job name="test-job" elasticProfileId="gocd-dev-build">
      ...
    </job>
    ...
  </pipeline>
</pipelines>
```

> The plugin will receive the following JSON body —

```json
{
  "auto_register_key": "1e0e05fc-eb45-11e5-bc83-93882adfccf6",
  "environment": "prod",
  "job_identifier": {
    "job_id": 100,
    "job_name": "test-job",
    "pipeline_counter": 1,
    "pipeline_label": "build",
    "pipeline_name": "build",
    "stage_counter": "1",
    "stage_name": "test-stage"
  },
  "properties": {
    "Image": "gocd/gocd-agent-alpine-3.5:v18.1.0",
    "MaxMemory": "500Mb"
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
| `job_identifier`    | `Object` | Job identifier of the job for which this call is being made. |

<p class='response-code-heading'>Response code</p>

The plugin is expected to return status `200` if it can understand the request.

<p class='response-body-heading'>Response Body</p>

Can be left blank, the server does not parse any response body returned.
