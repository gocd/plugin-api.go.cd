## Console Log

> Console Logger example

```java
import com.google.gson.Gson;
import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import com.thoughtworks.go.plugin.api.GoApplicationAccessor;
import com.thoughtworks.go.plugin.api.GoPluginIdentifier;
import com.thoughtworks.go.plugin.api.request.DefaultGoApiRequest;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import static com.tw.go.plugin.task.GoPluginImpl.EXTENSION_NAME;
import static com.tw.go.plugin.task.GoPluginImpl.SUPPORTED_API_VERSIONS;

public class ConsoleLogger {
    private static ConsoleLogger consoleLogger;
    private final GoApplicationAccessor accessor;
    private static final String SEND_CONSOLE_LOG = "go.processor.task.console-log";

    private ConsoleLogger(GoApplicationAccessor accessor) {
        this.accessor = accessor;
    }

    public void info(String message) {
        sendLog(new ConsoleLogMessage(ConsoleLogMessage.LogLevel.INFO, message));
    }

    public void error(String message) {
        sendLog(new ConsoleLogMessage(ConsoleLogMessage.LogLevel.ERROR, message));
    }

    public void process(InputStream out, InputStream error) throws IOException {
        processInputStream(out);
        processErrorStream(error);
    }

    public void processErrorStream(InputStream error) throws IOException {
        BufferedReader errorReader = new BufferedReader(new InputStreamReader(error));
        String errorLine;
        while ((errorLine = errorReader.readLine()) != null) {
            consoleLogger.error(errorLine);
        }
    }

    public void processInputStream(InputStream out) throws IOException {
        BufferedReader in = new BufferedReader(new InputStreamReader(out));
        String infoLine;
        while ((infoLine = in.readLine()) != null) {
            consoleLogger.info(infoLine);
        }
    }

    private void sendLog(ConsoleLogMessage consoleLogMessage) {
        DefaultGoApiRequest request = new DefaultGoApiRequest(SEND_CONSOLE_LOG, "1.0", 
            new GoPluginIdentifier(EXTENSION_NAME, SUPPORTED_API_VERSIONS));
        request.setRequestBody(consoleLogMessage.toJSON());
        accessor.submit(request);
    }

    public static ConsoleLogger getLogger(GoApplicationAccessor accessor) {
        if (consoleLogger == null) {
            synchronized (ConsoleLogger.class) {
                if (consoleLogger == null) {
                    consoleLogger = new ConsoleLogger(accessor);
                }
            }
        }

        return consoleLogger;
    }

    static class ConsoleLogMessage {
        @Expose
        @SerializedName("logLevel")
        private LogLevel logLevel;

        @Expose
        @SerializedName("message")
        private String message;

        public ConsoleLogMessage(LogLevel logLevel, String message) {
            this.message = message;
            this.logLevel = logLevel;
        }

        public String toJSON() {
            return new Gson().toJson(this);
        }

        enum LogLevel {
            INFO, ERROR
        }
    }
}
```


> Use ConsoleLogger.java to update proggress on consloe log


```java
import com.thoughtworks.go.plugin.api.*;
import com.thoughtworks.go.plugin.api.annotation.Extension;
import com.thoughtworks.go.plugin.api.logging.Logger;
import com.thoughtworks.go.plugin.api.request.*;
import com.thoughtworks.go.plugin.api.response.*;
import com.google.gson.Gson;
import java.util.*;

@Extension
public class TaskPlugin implements GoPlugin {
  public static final Logger LOG = Logger.getLoggerFor(TaskPlugin.class);
  public static final ConsoleLogger CONSOLE_LOGGER;
  
  public void initializeGoApplicationAccessor(GoApplicationAccessor accessor) {
    CONSOLE_LOGGER = ConsoleLogger.getLogger(accessor);
  }

  public GoPluginIdentifier pluginIdentifier() {
    return new GoPluginIdentifier("task", Arrays.asList("1.0"))
  }

  @Override
  public GoPluginApiResponse handle(GoPluginApiRequest request) throws UnhandledRequestTypeException {
      if ("configuration".equals(request.requestName())) {
          return new GetConfigRequest().execute();
      } else if ("validate".equals(request.requestName())) {
          return new ValidateRequest().execute(request);
      } else if ("execute".equals(request.requestName())) {
          return new ExecuteRequest().execute(request);
      } else if ("view".equals(request.requestName())) {
          return new GetViewRequest().execute();
      }
      throw new UnhandledRequestTypeException(request.requestName());
  }

  class ExecuteRequest {
  	public GoPluginApiResponse execute(GoPluginApiRequest request) {
  		  CONSOLE_LOGGER.info("Executing curl task.");
  		  int exitCode = executeCommand(...);
        if (exitCode == 0) {
          response.put("success", true);
          CONSOLE_LOGGER.info("Script completed with exit code: " + exitCode + ".");
        } else {
          CONSOLE_LOGGER.error("Script completed with exit code: " + exitCode + ".");
          response.put("success", false);
        }

        return new DefaultGoPluginApiResponse(result.responseCode(), {}));
    }

    private int executeCommand(String workingDirectory, 
                               Map<String, String> environmentVariables, 
                               String... command) 
      throws IOException, InterruptedException {

        ProcessBuilder processBuilder = new ProcessBuilder(command);
        processBuilder.directory(new File(workingDirectory));
        if (environmentVariables != null && !environmentVariables.isEmpty()) {
            processBuilder.environment().putAll(environmentVariables);
        }
        Process process = processBuilder.start();
        CONSOLE_LOGGER.process(process.getInputStream(), process.getErrorStream());
        return process.waitFor();
    }
  }
}
```

This messages allows a plugin to update the task execution progress to console log.

<p class='request-name-heading'>Request name</p>

`go.processor.task.console-log`

<p class='request-body-heading'>Request body</p>

> Example request body

```json
{
  "logLevel": "INFO",
  "message": "This is info message."
}
```

<p class='response-code-heading'>Response code</p>

The server is expected to return status `200` if it could process the request.

<p class='response-body-heading'>Response Body</p>

The server will not send a response body.
