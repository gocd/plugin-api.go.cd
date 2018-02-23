## Execute Task

> An example request body

```json
{
  "config": {
    "ftp_server": {
      "secure": false,
      "value": "ftp.example.com",
      "required": true
    },
    "remote_dir": {
      "secure": false,
      "value": "/pub/",
      "required": true
    }
  },
  "context": {
    "workingDirectory": "working-dir",
    "environmentVariables": {
      "ENV1": "VAL1",
      "ENV2": "VAL2"
    }
  }
}
```

> An example response body, in case of success

```json
{
  "success": true,
  "message": "Finished executing task"
}
```

> An example response body, in case of failure

```json
{
  "success": false,
  "message": "Failed to execute task. The error was: 'Server not found'"
}
```

> Here's an example snippet of code to help execute custom commands and send their output to GoCD

```java
import com.google.gson.GsonBuilder;
import com.thoughtworks.go.plugin.api.request.GoPluginApiRequest;
import com.thoughtworks.go.plugin.api.response.DefaultGoPluginApiResponse;
import com.thoughtworks.go.plugin.api.task.JobConsoleLogger;

import java.io.File;
import java.util.*;

public class PluginExecutor {
  public DefaultGoPluginApiResponse execute(GoPluginApiRequest request) throws Exception {
    JobConsoleLogger console = JobConsoleLogger.getConsoleLogger();

    // create the process with the right cli args environment variables and working directory
    // all this is available in the requestBody
    ProcessBuilder builder = new ProcessBuilder(...);
    builder.directory(...);
    builder.environment().putAll(...);

    // print out the environment variables to the console
    console.printEnvironment(builder.environment());

    // start the process
    Process process = builder.start();

    // ensure that the process's stderr and stdout and connected to GoCD
    console.readErrorOf(process.getErrorStream());
    console.readOutputOf(process.getInputStream());

    // wait for the process to exit
    int exitCode = process.waitFor();

    if (exitCode != 0) {
      // send error response
      return new DefaultGoPluginApiResponse(200, "...");
    } else {
      // send success response
      return new DefaultGoPluginApiResponse(200, "...");
    }
  }
}
```

This message is sent by the GoCD agent to the plugin to execute the task.

<p class='request-name-heading'>Request name</p>

`execute`

<p class='request-body-heading'>Request body</p>

The request body will contain a JSON containing the necessary configuration provided by the user, along with the working directory where the task is expected to run, and the environment variables configured.

<p class='response-code-heading'>Response code</p>

The plugin is expected to return status `200` if it can understand the request.

<p class='response-body-heading'>Response Body</p>

The plugin is expected to return a status object indicating `success`, and a `message`. During the execution of the plugin, messages that need to be shown on the output console of the job can be sent to the Go Server using the an instance of `JobConsoleLogger`.
