## Fetch Artifact

This message is a request to the plugin to fetch an artifact from the specified artifact store.

<p class='request-name-heading'>Request name</p>

`cd.go.artifact.fetch-artifact`

<p class='request-body-heading'>Request body</p>


> Given the following config XML snippet —

```xml

<artifactStores>
      <artifactStore id="dockerhub" pluginId="cd.go.artifact.docker.registry">
        <property>
          <key>RegistryURL</key>
          <value>https://index.docker.io/v1/</value>
        </property>
        <property>
          <key>Username</key>
          <value>boohoo</value>
        </property>
        <property>
          <key>Password</key>
          <value>password</value>
        </property>
      </artifactStore>
    </artifactStores>
<pipelines group="first">
  <pipeline name="build">
    ...
    <job name="build-job">
      ...
      <artifacts>
        <artifact type="external" id="app-image" storeId="dockerhub">
          <configuration>
            <property>
              <key>Image</key>
              <value>gocd/gocd-demo</value>
            </property>
            <property>
              <key>Tag</key>
              <value>v${GO_PIPELINE_COUNTER}</value>
            </property>
          </configuration>
        </artifact>
      </artifacts>
    </job>
    ...
    
    <stage name="downstream_stage">
      ...
      <job name="downstream_job">
        <tasks>
            <fetchartifact artifactOrigin="external" stage="upstream_stage" job="build-job" artifactId="app-image">
              <configuration>
                <property>
                  <key>image_name</key>
                  <value>release-candidate</value>
                </property>
              </configuration>
            </fetchartifact>
        </tasks>
      </job>
      ...
    </stage>
  </pipeline>
</pipelines>
```

> The plugin will receive the following JSON body —

```json
{
  "fetch_artifact_configuration":{
    "image_name": "release-candidate"
  },
  "artifact_metadata":{
    "image":"gocd/gocd-demo:v23",
    "digest":"sha256:f7840887b6f09f531935329a4ad1f6176866675873a8b3eed6a5894573da8247"
  },
  "store_configuration":{
    "RegistryURL":"https://index.docker.io/v1/",
    "Username":"boohoo",
    "Password":"password"
  },
  "agent_working_directory":"/Users/varshavs/gocd/agent/pipelines/build"
}
```

The request body will contain the following JSON elements:

<p class='attributes-table-follows'></p>

| Key                             | Type     | Description                                                                                                                                               |
| ------------------------------- | -------- | --------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `fetch_artifact_configuration`  | `Object` | This mainly contains the configuration properties that inform the plugin about the specific artifact that needs to be fetched.                                                                  |
| `artifact_metadata`             | `Object` | This is the information that was uploaded as a json file to the GoCD server at publish time. The json file is parsed and its contents are passed to the plugin at fetch time so that the plugin can fetch the right artifact.                             |
| `store_configuration`           | `Object` | This section contains the details about the artifact store from which the plugin has to fetch the artifact.                                               |
| `agent_working_directory`       | `String` | Since the artifact download happens on the go-agent side, the working directory is also passed along in the request in case the plugin wants to use it.   |

<p class='response-code-heading'>Response code</p>

The plugin is expected to return status `200` if it can understand the request.

<p class='response-body-heading'>Response Body</p>

The plugin can respond with a list of environment variables which will be set on the job, for all further tasks in that job to use. It can also return an empty list (`[]`). Existing environment variables will be overridden, if they are returned as a part of this response.

> Example response body:

```json
[
  {
    "name": "IMAGE_ID",
    "value": "image1/v23",
    "secure": false
  },
  {
    "name": "MY_SECRET_ENV_VAR",
    "value": "some-password",
    "secure": true
  }
]
```

The response body will contain the following JSON elements:

<p class='attributes-table-follows'></p>

| Key      | Type      | Description                                         |
|----------|-----------|-----------------------------------------------------|
| `name`   | `String`  | The key or name of the environment variable to set. |
| `value`  | `String`  | The value of the environment variable to set.       |
| `secure` | `Boolean` | Should it be a secure environment variable or not?  |
