# Dependencies

> Add this to your maven `pom.xml`:

```xml
<dependency>
  <groupId>cd.go.plugin</groupId>
  <artifactId>go-plugin-api</artifactId>
  <version>GOCD_VERSION</version>
</dependency>
```

In order to use the plugin extension class, you must add `go-plugin-api` as dependency.
Where replace `GOCD_VERSION` with the actual version. You can find the available versions of the library in [maven central](https://mvnrepository.com/artifact/cd.go.plugin/go-plugin-api).

> Add this to your `build.gradle` under dependencies section:
    
```groovy
dependencies {
  compileOnly 'cd.go.plugin:go-plugin-api:GOCD_VERSION'
}
```

Any dependencies that your plugin requires, should go into the `lib` directory inside the plugin JAR.

## Example extension class

```java
package com.example.go.testplugin;

import com.thoughtworks.go.plugin.api.*;
import com.thoughtworks.go.plugin.api.annotation.*;
import com.thoughtworks.go.plugin.api.exceptions.*;
import com.thoughtworks.go.plugin.api.request.*;
import com.thoughtworks.go.plugin.api.response.*;
import com.google.gson.Gson;
import java.util.*;

@Extension
public class ExampleExtension implements GoPlugin {
  private GoApplicationAccessor accessor;

  // this method is executed once at startup
  public void initializeGoApplicationAccessor(GoApplicationAccessor accessor) {
    this.accessor = accessor;
  }

  // a GoPluginIdentifier tells GoCD what kind of a plugin this is
  // and what version(s) of the request/response API it supports
  public GoPluginIdentifier pluginIdentifier() {
    return new GoPluginIdentifier("<%= plugin_type %>", Arrays.asList("<%= endpoint_version %>"));
  }

  // handle the request and return a response
  // the response is very much like a HTTP response —
  // it has a status code, a response body and optional headers
  public GoPluginApiResponse handle(GoPluginApiRequest request) throws UnhandledRequestTypeException {
    if (request.requestName().equals("go.plugin-settings.get-view")) {
      String viewHtml = read(getClass().getResourceAsStream("/plugin-settings.template.html"));
      return new DefaultGoPluginApiResponse(200, viewHtml);
    }
    if (request.requestName().equals("go.plugin-settings.validate-configuration")) {
      List errors = validate(request);
      return new DefaultGoPluginApiResponse(200, new Gson().toJson(errors));
    } else {
      throw new UnhandledRequestTypeException(request.requestName());
    }
  }
}
```

The plugin extension class is a Java class that implements the `GoPlugin` interface.

The other types in the example are:

<p class='attributes-table-follows'></p>

| Type                   | Description |
| ---------------------- | ----------- |
| `GoApplicationAccessor`| So that the plugin can make requests to the GoCD application to get additional information that is not provided by each request. For example, the plugin can ask for settings, credentials etc. |
| `GoPluginIdentifier`   | Provides information about the type of plugin and the version of the request/response it supports. |
| `GoPluginApiRequest`   | Represents the request message sent from GoCD to a plugin. The message will have a name and an optional JSON request body and the version of the extension. |
| `GoPluginApiResponse`  | Represents the response message as a result of processing the `GoPluginApiRequest`. Similar to `GoPluginApiRequest`, the response will have a status code and an optional JSON response body. |

If you're familiar with http request/responses handled by a web application, you will find this very familiar.

<aside class="notice">
  GoCD has built in support for allowing plugins to enhance their capabilities in the future without having to break compatibility. This is achieved by ensuring that each extension-point and messages that is sent to the plugin is versioned.
</aside>

<a id='the-plugin-dependencies'></a>

