Kurtosis Sandbox
================
Often, Kurtosis is used for its testing ability: run a testsuite, where each test spins up a test network that the test logic runs against. However, it can sometimes be valuable to spin up a test network for freeform manipulation without any test logic. This is the Kurtosis sandbox: a testnet that can be freeform manipulated with a Javascript REPL with [the same tools for interacting with the Kurtosis engine][lib-documentation].

To start a Kurtosis sandbox, [install the Kurtosis CLI](./installation.md) and run:

```
kurtosis sandbox
```

The Javascript REPL that starts will 1) have `await` available and 2) have a `enclaveCtx` variable instance of the `EnclaveContext` object from [the documentation][enclavecontext].

E.g. starting an Ethereum network using [the Ethereum module](https://github.com/kurtosis-tech/ethereum-kurtosis-module):

![Starting an Ethereum network](./images/starting-eth-network-in-kurtosis-interactive.png)

The commands from above, for copy-pasting:
```
kurtosis sandbox
loadModuleResult = await networkCtx.loadModule("my-module", "kurtosistech/ethereum-kurtosis-module", "{}")
moduleCtx = loadModuleResult.value
executeResult = await moduleCtx.execute("{}")
executeResultObj = JSON.parse(executeResult.value)
console.log(executeResultObj)
```

---

[Back to index](https://docs.kurtosistech.com)

[enclavecontext]: ./kurtosis-core/lib-documentation#enclavecontext
