## List Agents

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

  private List listAgents() {
    // create a request
    DefaultGoApiRequest request = new DefaultGoApiRequest(
      "go.processor.elastic-agents.list-agents",
      "1.0",
      pluginIdentifier()
    );

    // submit the request
    GoApiResponse response = accessor.submit(request);

    // check status
    if (response.responseCode() != 200) {
      LOG.error("The server sent an unexpected status code " + response.responseCode() + " with the response body " + response.responseBody());
    }

    // parse the response, using a json parser of your choice
    List agents = new Gson().fromJson(response.responseBody(), ArrayList.class);
    return agents;
  }
}
```

This messages allows a plugin to query the server for a list of elastic agents that belong to a particular plugin.

<p class='request-name-heading'>Request name</p>

`go.processor.elastic-agents.list-agents`

<p class='request-body-heading'>Request version</p>

The request version must be set to `1.0`.

<p class='request-body-heading'>Request body</p>

Can be left blank, the server does not parse the request body.

<p class='response-code-heading'>Response code</p>

The server is expected to return status `200` if it could process the request.

<p class='response-body-heading'>Response Body</p>

The server will send a list of [agents](#elastic-agent-object).
