Kurtosis Lambdas
================
### What's a Lambda?
You might want to provide your testnet definition logic to a wider audience (e.g. your users), or you might want to consume someone else's testnet definition logic. Kurtosis' solution to this are "Lambdas", which are packages of code that execute against the Kurtosis testnet. You can think of a Lambda as a language-agnostic library that executes in the Kurtosis environment. 

### Uses
Some hypothetical Lambdas that could be built:

* Occasionally kill services in the network (like Netflix' [Chaos Monkey](https://netflix.github.io/chaosmonkey/))
* Repartition the network periodically
* Mutate the state of the network

### Running Lambdas
The easiest way to run a Lambda is in the [sandbox][sandbox].

### Known Lambdas
The current Lambdas we know about:

* [Ethereum Lambda](https://github.com/kurtosis-tech/ethereum-kurtosis-lambda): Starts an Ethereum network in Kurtosis
* [NEAR Lambda](https://github.com/kurtosis-tech/near-kurtosis-lambda): Starts a NEAR blockchain and accompanying wallet, explorer, etc. in Kurtosis
* [Datastore Army Lambda](https://github.com/kurtosis-tech/datastore-army-lambda): Starts multiple [datastore services](https://github.com/kurtosis-tech/example-microservices); used for demonstration purposes


### Technical Details
Under the covers, Lambdas are:

1. A gRPC server
1. In an arbitrary language
1. With a connection to the Kurtosis engine 
1. And a single endpoint for executing the Lambda
1. That is packaged inside a Docker image

The containerized nature of Lambdas means that they can be written in your language of choice, and easily distributed via Dockerhub.

The API that a Lambda must implement is defined in [the Lambda API Lib](https://github.com/kurtosis-tech/kurtosis-lambda-api-lib). To see a Lambda example, visit the [Datastore Army Lambda](https://github.com/kurtosis-tech/datastore-army-lambda).

---

[Back to index](https://docs.kurtosistech.com)

[sandbox]: ./sandbox.md
