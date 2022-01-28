Using the CLI
=============
The [Kurtosis CLI][cli-installation] is the main way you will interact with Kurtosis. This document will walk you through some common CLI workflows.

### Initialize configuration
When the Kurtosis CLI is executed for the first time on a machine, we ask you to make a choice about whether you'd like to send anonymized usage metrics to help us make the product better. To make this election non-interactively, you can run either:
```
kurtosis config init send-metrics
```
to send anonymized metrics to improve the product or
```
kurtosis config init dont-send-metrics
```
if you'd prefer not to.

### Create an enclave
The environments in Kurtosis that house your containers are called "enclaves". They are isolated from each other, to ensure they don't interfere with each other. To create a new, empty enclave, run:

```
kurtosis enclave new
```

### List enclaves
To see all the enclaves in Kurtosis, run:

```
kurtosis enclave ls
```

The enclave IDs that are printed will be used in enclave manipulation commands.

### View enclave details
To view detailed information about a given enclave, run:

```
kurtosis enclave inspect $THE_ENCLAVE_ID
```

This will print detailed information about:

* The enclave's status (running or stopped)
* The services inside the enclave (if any), and the information for accessing those services' ports from your local machine
* The [modules][modules] inside the enclave (if any)
* The REPLs that have been attached to the enclave (if any)

### Delete an enclave
To delete an enclave and everything inside of it, run:

```
kurtosis enclave rm $THE_ENCLAVE_ID
```

Note that this will only delete stopped enclaves. To delete a running enclave, pass in the `-f`/`--force` flag.

### View a service's logs
To print the logs for a service, run:

```
kurtosis service logs $THE_ENCLAVE_ID $THE_SERVICE_ID
```

The service ID is printed upon inspecting an enclave.

### Run commands inside a service container
You might need to get access to a shell on a given service container. To do so, run:

```
kurtosis service shell $THE_ENCLAVE_ID $THE_SERVICE_ID
```

### Execute a module
For ease-of-use, the Kurtosis CLI provides a single command to 1) create an enclave 2) load a [module][modules] inside it and 3) execute the module. This command is:

```
kurtosis module exec $THE_MODULE_IMAGE
```

The module's behaviour can be customized with the optional `--load-params` and `--execute-params` flags.

### Remove old artifacts from Kurtosis
Kurtosis defaults to leaving containers, volumes, etc. around so that you can refer back them for debugging. To clean up artifacts from stopped enclaves, run:

```
kurtosis clean
```

To remove _everything_ in the Kurtosis engine, add the `-a`/`--all` flag.

---

[Back to index](https://docs.kurtosistech.com)

<!-- Only links below this point -->
[modules]: ./modules.md
[cli-installation]: ./installation.md
