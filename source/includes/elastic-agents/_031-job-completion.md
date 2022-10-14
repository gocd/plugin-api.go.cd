## Job Completion

The intent on this message is to notify the plugin on completion of the job. The plugin may choose to terminate the elastic agent or keep it running in case the same agent can be used for another job configuration.

<p class='request-name-heading'>Request name</p>

`cd.go.elastic-agent.job-completion`

<p class='request-body-heading'>Request body</p>

> Given the following config XML snippet —

```xml
<cruise>
  <server agentAutoRegisterKey="1e0e05fc-eb45-11e5-bc83-93882adfccf6" />
  <elastic>
    <clusterProfiles>
      <clusterProfile id="docker-local" pluginId="cd.go.contrib.elastic-agent.docker">
        <property>
          <key>DockerURI</key>
          <value>https://docker-uri/</value>
        </property>
      </clusterProfile>
    </clusterProfiles>
    <agentProfiles>
      <agentProfile  id="docker.unit-test" clusterProfileId="docker-local">
        <property>
          <!--
            The plugin currently only supports the `Image` property,
            which allows you to select the docker image that the build should run with
          -->
          <key>Image</key>
          <value>gocdcontrib/ubuntu-docker-elastic-agent</value>
        </property>
      </agentProfile>
    </agentProfiles>
  </elastic>
  <pipelines group="first">
    <pipeline name="build">
      ...
      <job name="test-job" elasticProfileId="docker.unit-test">
        ...
      </job>
      ...
    </pipeline>
  </pipelines>
  ...
  <agents>
    <agent hostname="1697e6b164f7" ipaddress="172.17.0.6" uuid="a45e3ca1-4419-4bd5-b18b-882f75ffd4c2" elasticAgentId="GoCD18efbeef995e40f688cd92dc22a4d332" 
      elasticPluginId="cd.example.elastic-agent" />
  </agents>
</cruise>
```

> The plugin will receive the following JSON body —

```json
{
  "elastic_agent_id": "GoCD18efbeef995e40f688cd92dc22a4d332",
  "elastic_agent_profile_properties": {
    "Image": "gocd/gocd-agent-alpine-3.5:v18.1.0",
    "MaxMemory": "https://docker-uri/"
  },
  "cluster_profile_properties": {
    "Image": "DockerURI",
    "MaxMemory": "500Mb"
  },
  "job_identifier": {
    "job_id": 100,
    "job_name": "test-job",
    "pipeline_counter": 1,
    "pipeline_label": "build",
    "pipeline_name": "build",
    "stage_counter": "1",
    "stage_name": "test-stage"
  }
}
```

The request body will contain the following JSON elements:

<p class='attributes-table-follows'></p>

| Key                                | Type     | Description                                                                                                                           |
| -------------------                | -------- | -----------                                                                                                                           |
| `elastic_agent_id`                 | `String` | The Elastic agent ID of the agent on which the job has completed.                                                                     |
| `elastic_agent_profile_properties` | `Object` | Elastic agent profile associated with the job. It represents the elastic agent configuration for the job  in form of key value pairs. |
| `cluster_profile_properties`       | `Object` | The field represents the cluster profile associated with elastic profile.                                                             |
| `job_identifier`                   | `Object` | Job identifier of the job for which this call is being made.                                                                          |

<p class='response-code-heading'>Response code</p>

The plugin is expected to return status `200` if it can understand the request.

<p class='response-body-heading'>Response Body</p>

Can be left blank, the server does not parse any response body returned.
