Kurtosis Modules
================
### What's a module?
You might want to package your logic for a wider audience (e.g. your users), or you might want to consume someone else's logic. Kurtosis' solution to this are "modules", which are chunks of code, packaged as container images, that execute within the Kurtosis context. You can think of a module as a language-agnostic library.

To write your own module, visit [the module starter pack repo](https://github.com/kurtosis-tech/kurtosis-module-starter-pack).

### Uses
Some hypothetical modules that could be built:

* Occasionally kill services in the network (like Netflix' [Chaos Monkey](https://netflix.github.io/chaosmonkey/))
* Repartition the network periodically
* Mutate the state of the network

### Executable Modules
The most basic module is an executable module - a module that responds to exactly one command, "execute". To make these easy to run, the Kurtosis CLI comes with the following command that will load an executable module and call its execute command:

```
kurtosis module exec EXECUTABLE_MODULE_IMAGE
```

You can run `kurtosis module exec -h` for more detailed information about the flags that can be passed in.

### Known Modules
The current modules we know about:

* [Ethereum Module](https://github.com/kurtosis-tech/ethereum-kurtosis-module): Starts an Ethereum network in Kurtosis
* [NEAR Module](https://github.com/kurtosis-tech/near-kurtosis-module): Starts a NEAR blockchain and accompanying wallet, explorer, etc. in Kurtosis
* [Datastore Army Module](https://github.com/kurtosis-tech/datastore-army-module): Starts multiple [datastore services](https://github.com/kurtosis-tech/example-microservices); used for demonstration purposes


### Technical Details
Under the covers, modules are:

1. A gRPC server
1. In an arbitrary language
1. With a connection to the Kurtosis engine 
1. With endpoints for interacting with the module
    * E.g. an executable module will have an "execute" endpoint
1. That is packaged inside a Docker image

The containerized nature of modules means that they can be written in your language of choice, and easily distributed via Dockerhub.

The API that a module must implement is defined in [the module API lib](https://github.com/kurtosis-tech/kurtosis-module-api-lib).

---

[Back to index](https://docs.kurtosistech.com)
