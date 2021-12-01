Running in CI
=============
Running Kurtosis on your local machine is nice, but executing it as part of CI is even better. This guide will walk you through modifying your CI config file to use Kurtosis in your CI environment:

Step One: Installing The CLI
----------------------------
You'll need the Kurtosis CLI inside your CI environment. This can be accomplished by following [the installation instructions][installation] for whichever package manager your CI container uses. E.g. if you're using Github Actions with an Ubuntu executor, you'd add the instructions for installing the Kurtosis CLI via the `apt` package manager to your CI config file.

Step Two: Starting The Engine
-------------------
You'll need the Kurtosis engine to be running to use [the engine API][engine-api-docs] (which you're likely using in your tests that use Kurtosis). Add `kurtosis engine start` in your CI config file after the CLI installation commands so that the engine API commands in your tests work properly.

---

[Back to index](https://docs.kurtosistech.com)

[installation]: ./installation.md

[engine-api-docs]: ./kurtosis-engine-server/lib-documentation
