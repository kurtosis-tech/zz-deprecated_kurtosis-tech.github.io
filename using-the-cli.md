Using the CLI
=============
The [Kurtosis CLI][cli-installation] is the main way you will interact with Kurtosis. This document will walk you through some common CLI workflows.

**TIP:** The `kurtosis` command, and all of its subcommands, will print helptext when passed the `-h` flag. You can use this at any time to see information on the command you're trying to run.

**TIP:** Kurtosis supports tab-completion. To add it, [follow these instructions](./adding-tab-completion.md).

### Initialize configuration
When the Kurtosis CLI is executed for the first time on a machine, we ask you to make a choice about whether [you'd like to send anonymized usage metrics to help us make the product better](./metrics-philosophy.md). To make this election non-interactively, you can run either:

```bash
kurtosis config init send-metrics
```

to send anonymized metrics to improve the product or

```bash
kurtosis config init dont-send-metrics
```

if you'd prefer not to.

### Start the engine
The CLI functions through calls to the Kurtosis engine, which is a very lightweight container. The CLI will start the engine container automatically for you so you should never need to start it manually, but you can do so if you please:

```bash
kurtosis engine start
```

### Check engine status
The engine's version and status can be printed with:

```bash
kurtosis engine status
```

### Stop the engine
To stop the engine, run:

```bash
kurtosis engine stop
```

### Create an enclave
The environments in Kurtosis that house your containers are called "enclaves". They are isolated from each other, to ensure they don't interfere with each other. To create a new, empty enclave, run:

```bash
kurtosis enclave new
```

### List enclaves
To see all the enclaves in Kurtosis, run:

```bash
kurtosis enclave ls
```

The enclave IDs that are printed will be used in enclave manipulation commands.

### View enclave details
To view detailed information about a given enclave, run:

```bash
kurtosis enclave inspect $THE_ENCLAVE_ID
```

This will print detailed information about:

* The enclave's status (running or stopped)
* The services inside the enclave (if any), and the information for accessing those services' ports from your local machine
* The [modules][modules] inside the enclave (if any)
* The REPLs that have been attached to the enclave (if any)

### Dump enclave information to disk
You'll likely need to store enclave logs to disk at some point - maybe you want to have a log package if your CI fails, or you want to record historical logs as you work on a module, or you want to send debugging information to a module author. Whatever the case may be, you can run:

```bash
kurtosis enclave dump $THE_ENCLAVE_ID $OUTPUT_DIRECTORY
```

You'll get the container logs & configuration in the output directory for further analysis & sharing.

### Delete an enclave
To delete an enclave and everything inside of it, run:

```bash
kurtosis enclave rm $THE_ENCLAVE_ID
```

Note that this will only delete stopped enclaves. To delete a running enclave, pass in the `-f`/`--force` flag.

### Add a service to an enclave
To add a service to an enclave, run:

```bash
kurtosis service add $THE_ENCLAVE_ID $THE_SERVICE_ID $CONTAINER_IMAGE
```

Much like `docker run`, this command has multiple options available to customize the service that's started:

1. The `--entrypoint` flag can be passed in to override the binary the service runs
1. The `--env` flag can be used to specify a set of environment variables that should be set when running the service
1. The `--ports` flag can be used to set the ports that the service will listen on

To override the service's CMD, add a `--` after the image name and then pass in your CMD args like so:

```bash
kurtosis service add --entrypoint sh my-enclave test-service alpine -- -c "echo 'Hello world'"
```

### View a service's logs
To print the logs for a service, run:

```bash
kurtosis service logs $THE_ENCLAVE_ID $THE_SERVICE_ID
```

The service ID is printed upon inspecting an enclave.

The `-f` flag can also be added to continue following the logs, similar to `tail -f`.


### Run commands inside a service container
You might need to get access to a shell on a given service container. To do so, run:

```bash
kurtosis service shell $THE_ENCLAVE_ID $THE_SERVICE_ID
```

### Delete a service from an enclave
Services can be deleted from an enclave like so:

```bash
kurtosis service rm $THE_ENCLAVE_ID $THE_SERVICE_ID
```

**NOTE:** To avoid destroying debugging information, Kurtosis will leave removed services inside the Docker engine. They will be stopped and won't show up in the list of active services in the enclave, but you'll still be able to access them (e.g. using `service logs`) by their service GUID (available via `enclave inspect`).

### Execute a module
For ease-of-use, the Kurtosis CLI provides a single command to 1) create an enclave 2) load a module inside it and 3) execute the module. This command is:

```bash
kurtosis module exec $THE_MODULE_IMAGE
```

The module's behaviour can be customized with the optional `--load-params` and `--execute-params` flags that are specific to the module. For convenience, we recommend putting the params into a file so you can get syntax highlighting and then using [command substitution](https://www.gnu.org/software/bash/manual/html_node/Command-Substitution.html) to `cat` the file contents.

For example:

Some module params, stored in `/tmp/my-module-params.json` so that I get syntax highlighting:

```javascript
{
    "someProperty": "someValue",
    "someOtherProperty": 4
}
```

The `kurtosis` command to slot those params into the module using command substitution:

```bash
kurtosis module exec $THE_MODULE_IMAGE --execute-params "$(cat /tmp/my-module-params.json)"
```

### Remove old artifacts from Kurtosis
Kurtosis defaults to leaving enclave artifacts (containers, volumes, etc.) around so that you can refer back them for debugging. To clean up artifacts from stopped enclaves, run:

```bash
kurtosis clean
```

To remove artifacts from _all_ enclaves (including running ones), add the `-a`/`--all` flag.

NOTE: This will not stop the Kurtosis engine itself! To do so, see "Stopping the engine" above.

---

[Back to index](https://docs.kurtosistech.com)

<!-- Only links below this point -->
[cli-installation]: ./installation.md
