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

import static com.tw.go.plugin.scm.GoPluginImpl.EXTENSION_NAME;
import static com.tw.go.plugin.scm.GoPluginImpl.SUPPORTED_API_VERSIONS;

public class ConsoleLogger {
    private static ConsoleLogger consoleLogger;
    private final GoApplicationAccessor accessor;
    private static final String SEND_CONSOLE_LOG = "go.processor.scm.console-log";

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
public class SCMPlugin implements GoPlugin {
  public static final Logger LOG = Logger.getLoggerFor(SCMPlugin.class);
  public static final ConsoleLogger CONSOLE_LOGGER;
  
  public void initializeGoApplicationAccessor(GoApplicationAccessor accessor) {
    CONSOLE_LOGGER = ConsoleLogger.getLogger(accessor);
  }

  public GoPluginIdentifier pluginIdentifier() {
    return new GoPluginIdentifier("scm", Arrays.asList("1.0"))
  }

  @Override
  public GoPluginApiResponse handle(GoPluginApiRequest request) throws UnhandledRequestTypeException {
      if ("scm-configuration".equals(goPluginApiRequest.requestName())) {
        return handleSCMConfiguration();
      } else if ("scm-view".equals(goPluginApiRequest.requestName())) {
        return handleSCMView();
      } else if ("go.plugin-settings.get-configuration".equals(goPluginApiRequest.requestName())) {
        return handlePluginConfiguration();
      } else if ("go.plugin-settings.get-view".equals(goPluginApiRequest.requestName())) {
        return handlePluginView();
      } else if ("go.plugin-settings.validate-configuration".equals(goPluginApiRequest.requestName())) {
        return handlePluginValidation(goPluginApiRequest);
      } else if ("validate-scm-configuration".equals(goPluginApiRequest.requestName())) {
        return handleSCMValidation(goPluginApiRequest);
      } else if ("check-scm-connection".equals(goPluginApiRequest.requestName())) {
        return handleSCMCheckConnection(goPluginApiRequest);
      } else if ("latest-revision".equals(goPluginApiRequest.requestName())) {
        return handleGetLatestRevision(goPluginApiRequest);
      } else if ("latest-revisions-since".equals(goPluginApiRequest.requestName())) {
        return handleLatestRevisionSince(goPluginApiRequest);
      } else if ("checkout".equals(goPluginApiRequest.requestName())) {
        return handleCheckout(goPluginApiRequest);
      }
      throw new UnhandledRequestTypeException(request.requestName());
  }
  
  ...
  
  private GoPluginApiResponse handleCheckout(GoPluginApiRequest goPluginApiRequest) {
      Map<String, Object> requestBodyMap = (Map<String, Object>) fromJSON(goPluginApiRequest.requestBody());
         Map<String, String> configuration = keyValuePairs(requestBodyMap, "scm-configuration");
         String destinationFolder = (String) requestBodyMap.get("destination-folder");
         Map<String, Object> revisionMap = (Map<String, Object>) requestBodyMap.get("revision");
         String revision = (String) revisionMap.get("revision");
         LOGGER.info(String.format("destination: %s. commit: %s", destinationFolder, revision));
 
         try {
             CONSOLE_LOGGER.info("Cloning git material " + configuration.get("url"));
             // do checkout here
             Map<String, Object> response = new HashMap<String, Object>();
             response.put("status", "success");
             response.put("messages", Arrays.asList(String.format("Checked out to revision %s", revision)));
             CONSOLE_LOGGER.info(String.format("Checked out to revision %s", revision));
             return renderJSON(SUCCESS_RESPONSE_CODE, response);
         } catch (Throwable t) {
             CONSOLE_LOGGER.error("Failed to clone material " + configuration.get("url"));
             LOGGER.warn("checkout: ", t);
             return renderJSON(500, t.getMessage());
         }
    }
}
```

This messages allows a plugin to update the scm checkout progress to console log.

<p class='request-name-heading'>Request name</p>

`go.processor.scm.console-log`

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
