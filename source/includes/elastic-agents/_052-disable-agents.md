## Disable Agents

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
    return new GoPluginIdentifier("elastic-agent", Arrays.asList("5.0"))
  }

  private disableAgents(List agents) {
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

Before a plugin terminates an agent instance, it must first disable it in order to prevent jobs from being assigned to it. This call is the equivalent of setting `isDisabled` on an `<agent/>` element in the config XML. More information about the agent config here, can be found in the [configuration reference](https://docs.gocd.org/current/configuration/configuration_reference.html#agent).

Agents in any state can be disabled, this will prevent jobs from being assigned to it. Any jobs the agent is running will eventually complete.

<p class='request-name-heading'>Request name</p>

`go.processor.elastic-agents.disable-agents`

<p class='request-body-heading'>Request version</p>

The request version must be set to `1.0`.

<p class='request-body-heading'>Request body</p>

The body must contain a list of [agents](#elastic-agent-object).

<p class='response-code-heading'>Response code</p>

The server is expected to return status `200` if it could process the request.

<p class='response-body-heading'>Response Body</p>

The server will not send a response body.
