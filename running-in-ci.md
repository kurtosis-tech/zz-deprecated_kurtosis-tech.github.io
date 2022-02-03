Running in CI
=============
Running Kurtosis on your local machine is nice, but executing it as part of CI is even better. This guide will walk you through modifying your CI config file to use Kurtosis in your CI environment:

Step One: Installing The CLI
----------------------------
You'll need the Kurtosis CLI inside your CI environment. This can be accomplished by following [the installation instructions][installation] for whichever package manager your CI container uses. E.g. if you're using Github Actions with an Ubuntu executor, you'd add the instructions for installing the Kurtosis CLI via the `apt` package manager to your CI config file.

Step Two: Initialize the configuration
--------------------------------------
When the Kurtosis CLI is executed for the first time on a machine, we ask you to make a choice about whether you'd like to send anonymized usage metrics to help us make the product better (explanation of why we do this, and how we strive to do this ethically, [here](./metrics-philosophy.md)). CI environments are non-interactive, so this prompt would cause the CLI running in CI to hang until the CI job times out.

To solve this problem, the Kurtosis CLI includes the `config init` subcommand to non-interactively initialize the CLI's configuration. This one-time call will save your election just as if you'd answered the prompt, so that when the CLI is run the prompt won't be displayed.

You'll therefore want the first call to the `kurtosis` CLI in your CI job to be either:

```
kurtosis config init send-metrics
``` 

if you'd like to help us make the product better for you or 

```
kurtosis config init dont-send-metrics
``` 

if you'd prefer not to send metrics.

Step Three: Starting The Engine
-----------------------------
You'll need the Kurtosis engine to be running to use [the engine API][engine-api-docs] (which you're likely using in your tests that use Kurtosis). Add `kurtosis engine start` in your CI config file after the CLI installation commands so that the engine API commands in your tests work properly.

Step Four: Run Your Custom Logic
---------------------------------
This will be specific to whatever you want to run in CI. E.g. if you have Javascript Mocha tests that use Kurtosis, you'd put that in your CI config file after installing the Kurtosis CLI & starting the engine.

Example
-------
[This is the relevant section of the CircleCI config file used by the testsuite used in the onboarding repo.](https://github.com/kurtosis-tech/onboarding-ethereum-testsuite/blob/master/.circleci/config.yml#L33)

---

[Back to index](https://docs.kurtosistech.com)

[installation]: ./installation.md

[engine-api-docs]: ./kurtosis-engine-server/lib-documentation
