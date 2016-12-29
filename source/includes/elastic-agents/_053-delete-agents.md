## Delete Agents

```java
import com.thoughtworks.go.plugin.api.*;
import com.thoughtworks.go.plugin.api.annotation.Extension;
import com.thoughtworks.go.plugin.api.logging.Logger;
import com.thoughtworks.go.plugin.api.request.*;
import com.thoughtworks.go.plugin.api.response.*;
import com.google.gson.Gson;
import java.util.*;

@Extension
public class DockerPlugin implements GoPlugin {
  private GoApplicationAccessor accessor;
  public static final Logger LOG = Logger.getLoggerFor(DockerPlugin.class);

  public void initializeGoApplicationAccessor(GoApplicationAccessor accessor) {
    this.accessor = accessor;
  }

  public GoPluginIdentifier pluginIdentifier() {
    return new GoPluginIdentifier("elastic-agent", Arrays.asList("1.0"))
  }

  private deleteAgents(List agents) {
    // first terminate the instance from AWS, or a cloud provider of your choice
    aws.terminateInstances(agents);
    // ensure that they are really terminated,
    // to prevent stray agents from re-registering
    aws.waitForTermination(agents);

    // create a request
    DefaultGoApiRequest request = new DefaultGoApiRequest(
      "go.processor.elastic-agents.disable-agents",
      "1.0",
      pluginIdentifier()
    );

    // set the request body
    request.setRequestBody(new Gson().toJson(agents));

    // submit the request
    GoApiResponse response = accessor.submit(request);

    // check status
    if (response.responseCode() != 200) {
      LOG.error("The server sent an unexpected status code " + response.responseCode() + " with the response body " + response.responseBody());
    }
  }
}
```

Before the delete-agent message is sent to the server, the plugin MUST ensure that the agent is terminated. This call is the equivalent of removing the `<agent/>` element in the config XML. More information about the agent config here, can be found in the [configuration reference](https://docs.gocd.io/current/configuration/configuration_reference.html#agent).

<aside class="notice">
  <strong>Important:</strong> Before an agent is terminated, it is recommended to ensure that it is first <a href='#disable-agents'>disabled</a> and that the <code>agent_state</code> is <code>Idle</code>. This will ensure that any jobs that an agent is running are completed.
  <br/>
  <br/>
  Not doing so will cause jobs to be rescheduled on another instance after a timeout interval.
</aside>


<p class='request-name-heading'>Request name</p>

`go.processor.elastic-agents.delete-agents`

<p class='request-body-heading'>Request body</p>

The body must contain a list of [agents](#elastic-agent-object) that should be removed from the config XML.

<p class='response-code-heading'>Response code</p>

The server is expected to return status `200` if it could process the request.

<p class='response-body-heading'>Response Body</p>

The server will not send a response body.
