# Introduction

Welcome to the GoCD Plugin API! You can use this API to implement GoCD plugins for SCMs, [tasks](tasks), [notifications](notifications), authentication, package repositories, [elastic agents](elastic-agents) and [authorization](authorization).

Plugins, as the name implies, help in extending the functionality of Go. Go publishes a list of extension points for which plugins can be provided. An extension point published by the GoCD - defines the interface and the lifecycle that governs the respective plugin. At present only Java based extension points and plugins are supported by GoCD, but the interface is simple enough for anyone to build plugins in other languages using a simple HTTP bridge.
