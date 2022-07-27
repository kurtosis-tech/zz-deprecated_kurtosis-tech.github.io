Kurtosis Modules
================
### What is a module?
A Kurtosis module is a set of instructions for setting up an environment, written in any programming language that [the Kurtosis SDK][kurtosis-core_enclave-context] supports (Golang and Typescript as of 2022-07-27). The instructions are packaged inside a Docker image, so that anybody who has the image can execute the module and get a running environment. 

### How do I run a module?
The Kurtosis CLI provides an easy command for creating a new enclave and executing a module inside the enclave (make sure to replace `YOUR_MODULE_IMAGE` with the module Docker image you want to run):

```
kurtosis module exec YOUR_MODULE_IMAGE
```

Once the module finishes executing, you can manage the new enclave [using the same CLI commands that you use to manage any enclave][using-the-cli]. You can also run `kurtosis module exec -h` for more detailed information about the flags that can be passed in.

### Why would I use a module?
The knowledge of how to start a server and make sure it's available is usually held by the dev team building the server. Unfortunately, many other groups beyond the dev team will need to start the server - quality assurance teams, other dev teams that depend on the server, or even external developers (e.g. dApp developers who want a local blockchain node as they develop their dApp). It is therefore essential that the dev team building the server provides a way to start it, for other people who don't know how the server works.

Furthermore, a distributed application will often contain many servers. Even more knowledge is required to understand how to connect these servers together, and that knowledge may not live inside of any one dev team. 

A Kurtosis module provides a central place for dev teams to store their knowledge of starting servers, connecting them together, and ensuring they're available. Modules are packaged inside of Docker images, so they're easy to get from Dockerhub and the same Kurtosis module can be used by dev teams, quality assurance teams, and even external users.

### What does a module look like?
A module is really just a code repository with an "execute" function that takes in some parameters, makes some calls to Kurtosis using [the Kurtosis SDK][kurtosis-core_enclave-context], and returns a response. 

For example, [this is the repository of the "datastore army" module](https://github.com/kurtosis-tech/datastore-army-module) that the Kurtosis team maintains. We gave it its name because it starts as many [datastore servers](https://github.com/kurtosis-tech/example-datastore-server) as the user asks for (creating an "army" of datastore servers). 

To do its job, the datastore army module must receive a requested number of datastore servers from the user, use the Kurtosis SDK to start the servers, and return information about the servers back to the user. This means that the module's "execute" function must take in a "number of servers" parameter and Kurtosis SDK object, start the servers, and return a response object containing information about the servers that it started. 

If we look at [the module's execute function here](https://github.com/kurtosis-tech/datastore-army-module/blob/master/kurtosis-module/impl/datastore_army_kurtosis_module.go#L28), we can see this is exactly what happens:

1. The function takes in a `serializedParams` object containing the requested number of servers to start in JSON-serialized format
1. The function also takes in an `EnclaveContext` object which is the Kurtosis object used for starting servers in the enclave
1. The function returns a `serializedResults` object containing information about the servers it started in JSON-serialized format

We can also see that [the module repository has a `build.sh` script](https://github.com/kurtosis-tech/datastore-army-module/blob/master/scripts/build.sh). This script is used to compile the module's execute function and package it inside a Docker image.

### How do I create a module?
You can create your own custom module repository by following [the instructions in the README of our module "starter pack" repository](https://github.com/kurtosis-tech/kurtosis-module-starter-pack#kurtosis-module-starter-pack).

### Why would I use Kurtosis modules over X?
The three most common methods for shipping environments to users are shell scripts, Docker compose files, and Helm charts. Each have their own problems:

- Shell scripts: difficult to develop and maintain due to high level of knowledge required to do shell scripting safely, not portable (e.g. `bash` vs `zsh` peculiarities), difficult to distribute, no compile-time guarantees
- Docker compose: can't have a Docker compose file that includes another Docker compose file, oftentimes has portability issues (e.g. assuming a volume already exists within the Docker engine or relying on Linux Docker-exclusive features), difficult to distribute, no compile-time guarantees due to YAML
- Helm charts: complex, require deep knowledge of Kubernetes, sometimes has portability issues (e.g. assuming a volume already exists in Kubernetes), no compile-time guarantees due to YAML

Kurtosis modules don't suffer these same problems because:
- They run as compiled, checked code rather than YAML
- They can be executed on either Docker or Kubernetes
- They don't require any Kubernetes knowledge
- They don't allow dependencies on preexisting volumes inside the Docker/Kubernetes engine
- They can call other modules through the SDK (composition)
- They can be pushed to and pulled from Dockerhub

### Technical Details
Under the covers, modules are:

1. A gRPC server
1. In an arbitrary language
1. With a connection to the Kurtosis engine 
1. With an "execute" endpoint
1. That is packaged inside a Docker image

The containerized nature of modules means that they can be written in your language of choice, and easily distributed via Dockerhub.

The API that a module must implement is defined in [the module API lib](https://github.com/kurtosis-tech/kurtosis-module-api-lib).

### Known Modules

* [Ethereum 1 Module](https://github.com/kurtosis-tech/ethereum-kurtosis-module): Starts an Ethereum 1 network in Kurtosis
* [Ethereum 2 Merge Module](https://github.com/kurtosis-tech/eth2-merge-kurtosis-module): Starts an Ethereum 1 network, and then tests the merge to Ethereum 2
* [NEAR Module](https://github.com/kurtosis-tech/near-kurtosis-module): Starts a NEAR blockchain and accompanying wallet, explorer, etc. in Kurtosis
* [Datastore Army Module](https://github.com/kurtosis-tech/datastore-army-module): An example module that we built which starts multiple [datastore services](https://github.com/kurtosis-tech/example-microservices); used for demonstration purposes

---

[Back to index](https://docs.kurtosistech.com)


<!---------------------------- ONLY LINKS BELOW HERE --------------------------->
[kurtosis-core_enclave-context]: ./kurtosis-core/lib-documentation
[using-the-cli]: ./using-the-cli.md
