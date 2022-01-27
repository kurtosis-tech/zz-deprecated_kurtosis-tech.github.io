Running in CI
=============
Running Kurtosis on your local machine is nice, but executing it as part of CI is even better. This guide will walk you through modifying your CI config file to use Kurtosis in your CI environment:

Step One: Installing The CLI
----------------------------
You'll need the Kurtosis CLI inside your CI environment. This can be accomplished by following [the installation instructions][installation] for whichever package manager your CI container uses. E.g. if you're using Github Actions with an Ubuntu executor, you'd add the instructions for installing the Kurtosis CLI via the `apt` package manager to your CI config file.

Step Two: Initialize the configuration
--------------------------------------
When the command to start the engine with Kurtosis CLI is executed, a prompt is displayed asking users if they consent to send metrics to improve this product.
It is impossible to interact with the prompt in CI executions, if a prompt is displayed during a build executed by the CI, the same process will be hung until time-out is reached.
The Kurtosis CLI includes a command `config init` to initialize the configuration. This preference is saved in the system and next time you execute the command to start the engine, the prompt won't be displayed.
Run `kurtosis config init send-metrics` if you accept sending metrics or `kurtosis config init dont-send-metrics` if you want to reject it.

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
