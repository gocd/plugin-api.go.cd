# Structure of a Plugins Bundle

Starting from GoCD version 19.11.0, it allows developer to package multiple plugins in a bundle. e.g. It allows developer
to package all GitHub plugins in a bundle which may use the same libraries. This will allows users to just download one
jar instead downloading various jars for each extensions.

## Directory Structure Conventions

```
bundle.jar
|
|-- gocd-bundle.xml
|-- com
|   \-- example
|       \-- go
|           \-- test_plugin_1
|               \-- ExampleSCMExtension.class
|               \-- ExampleSecretsExtension.class
|               \-- x.class
|               \-- y.class
|
|-- com
|   \-- example
|       \-- go
|           \-- test_plugin_2
|               \-- ExampleNotificationExtension.class
|               \-- x.class
|               \-- y.class
|
\-- lib
    \-- shared-dependency-1.jar
    \-- shared-dependency-2.jar
```

The bundle jar is a self contained-jar. It is expected to contain the following inside it:

1. **Bundle XML(`gocd-bundle.xml`):** The [metadata](#the-bundle-xml) of your plugin. 
2. **Plugins:** Each plugin with the [plugin extension class](#example-extension-class) 
    - `ExampleSCMPlugin.class`, `ExampleSecretsExtension.class` and `ExampleNotificationPlugin.class` in 
       the example shown) and any other classes that form your plugin.
3. **Dependencies:** Any shared [dependencies](#dependencies) for all bundles (inside the `lib`)


## The Bundle XML

This is an XML file that should be present in the bundle jar at the top level. You can find the XML Schema for the plugins in the [main repository](https://github.com/gocd/gocd/blob/master/plugin-infra/go-plugin-api/src/main/resources/gocd-bundle-descriptor.xsd).

> Example `gocd-bundle.xml`

```xml
<?xml version="1.0" encoding="utf-8"?>
<gocd-bundle version="1">
  <!-- Allows to register multiple plugins and each of the plugin can have one or more extensions -->  
  <plugins>
    <!-- The id of your first plugin -->
    <plugin id="id-of-the-plugin-1">
      <about>
        <!-- The name of your plugin -->
        <name>Example Git SCM plugin</name>
        <!--  The version of your plugin -->
        <version>1.0.0</version>
        <!-- A longer description of your plugin  -->
        <description>Allows to example git SCM as material</description>
        <!-- The minimum version of GoCD that this plugin requires -->
        <target-go-version>19.11.0</target-go-version>

        <!-- If this plugin only supports certain OSes -->
        <target-os>
          <value>Linux</value>
          <value>Windows</value>
        </target-os>
        <vendor>
          <name>ACME Corp</name>
          <url>https://www.example.com</url>
        </vendor>
      </about>
      <!-- Register extension classes in the plugin -->  
      <extensions>
        <extension class="com.example.go.test_plugin_1.ExampleSCMPlugin" />
        <extension class="com.example.go.test_plugin_1.ExampleSecretsExtension" />
      </extensions>
    </plugin>

    <!-- The id of your second plugin -->
    <plugin id="id-of-the-plugin-2">
      ...
    </plugin>
  </plugins>
</gocd-bundle>
```

The GoCD server will look for the `gocd-bundle.xml` in the jar and uses it to load the plugins. The XML also allows developer 
to register class(es) as extensions and unregister extension classes will be ignored by the server.

## Examples

1. [Docker bundle](https://github.com/gocd-contrib/gocd-docker-plugins-bundle)
2. [Github bundle](https://github.com/gocd-contrib/gocd-github-plugins-bundle)
