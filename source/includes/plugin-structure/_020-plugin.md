# Structure of a GoCD Plugin

Plugins in GoCD are implemented in Java and packaged as a JAR file.

## Directory Structure Conventions

```
plugin.jar
|
|-- plugin.xml
|-- com
|   \-- example
|       \-- go
|           \-- testplugin
|               \-- ExampleExtension.class
|               \-- x.class
|               \-- y.class
\-- lib
    \-- dependency-1.jar
    \-- dependency-2.jar
```

The plugin jar is a self contained-jar. It is expected to contain the following inside it:

1. **Plugin XML(`plugin.xml`):** The [metadata](#the-plugin-xml) of your plugin.
2. **Java Classes:** 
    - The [plugin extension classes](#example-extension-class) e.g. `ExampleExtension.class` in the example shown 
    - Any other classes used by the in the plugin.
3. **Dependencies:** Any optional [dependencies](#dependencies) your plugin may requires (inside the `lib`).

<a id='the-plugin-metadata'></a>

## The Plugin XML

This is an XML file that should be present in the plugin jar file at the top level.

You can find the XML Schema for the plugins in the  [main repository](https://github.com/gocd/gocd/blob/master/plugin-infra/go-plugin-api/src/main/resources/plugin-descriptor.xsd).

> Here is an example `plugin.xml`:

```xml
<?xml version="1.0" encoding="utf-8" ?>
<!-- Your plugin id and version
     of this XML document, the
     version must be set to "1" -->
<go-plugin
  id="com.example.rocket.launcher"
  version="1">
  <about>
    <!-- The name of your plugin -->
    <name>Launches rockets</name>
    <!--  The version of your plugin -->
    <version>0.0.1</version>
    <!-- The minimum version of GoCD that this plugin requires -->
    <target-go-version>19.1.0</target-go-version>
    <!-- A longer description of your plugin  -->
    <description>Launches rockets, spaceships and other things to a destination of your choice.</description>

    <!-- Tell us who you are -->
    <vendor>
      <name>ACME Corp</name>
      <url>https://www.example.com</url>
    </vendor>

    <!-- If this plugin only supports certain OSes -->
    <target-os>
      <value>Linux</value>
      <value>Windows</value>
    </target-os>
  </about>
</go-plugin>
```

## Example/Skeleton plugins

1. [Artifact Plugin](https://github.com/gocd/docker-registry-artifact-plugin)
2. [Authorization Plugin](https://github.com/gocd-contrib/authorization-skeleton-plugin)
3. [Elastic Agent Plugin](https://github.com/gocd-contrib/elastic-agent-skeleton-plugin)
4. [Notification Plugin](https://github.com/gocd-contrib/notification-skeleton-plugin)
5. [Secrets Plugin](https://github.com/gocd-contrib/secrets-skeleton-plugin)
6. [Task Plugin](https://github.com/gocd-contrib/task-skeleton-plugin)
7. [Analytics Plugin](https://github.com/gocd-contrib/analytics-skeleton-plugin)
