Debugging Failed Tests
======================
Tests will of course fail over the course of your development. Here you'll find instructions for attaching a debugger to your testsuite, as well as some common error scenarios that you might encounter. If you still can't find the answer to your question, you can ask in the [Kurtosis Discord](https://discord.gg/6Jjp9c89z9).

Attaching a debugger to your testsuite
-------------------------------------
To attach a debugger to your testsuite, you'll need update the command in your testsuite's `Dockerfile` and tell your debugger to listen on the port specified by the magic `DEBUGGER_PORT` environment variable, which will be supplied to your testsuite container by Kurtosis. When you run your testsuite, each testsuite's debugger port will get bound to an IP:port combo on your local machine (which will be printed in the logs).

Commmon failure scenarios
-------------------------
### Mount denied due to paths not being shared from OS X
**High-level:** If you're using MacOS, make sure that your Docker engine's `Resources > File Sharing` preferences are set to allow `/var/folders`
**Details:** The Kurtosis controller is a Docker image that needs to access the Docker engine it's running in to create other Docker images. This is done via creating "sibling" containers, as detailed in the "Solution" section at the bottom of [this blog post](https://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/). However, this requires your Docker engine's communication socket to be bind-mounted inside the controller container. Kurtosis will do this for you, but you'll need to give Docker permission for the Docker socket (which lives at `/var/run/docker.sock`) to be bind-mounted inside the controller container.

### Tests failed but no testsuite logs were printed
If your tests are failing but you're not getting any testsuite logs whatsoever, you either have a failure in launching the testsuite container or in the machinery for reporting a testsuite container's logs back to Kurtosis

One common failure scenario we've seen with MacOS users is the `/var/folders` not being permitted in the Docker engine preferences. If you're a Mac user, double-check that your Docker engine's `Resources > File Sharing` section permits access to `/var/folders`.

If this still doesn't resolve the issue, you'll want to investigate the logs of your testsuite continaer, which you can do [using these instructions](https://docs.docker.com/config/containers/logging/); this should give you more information about why your container is failing.

### Test setup & run timeouts
Each test has timeouts in which its `Test.setup` and `Test.run` functions must complete. One of these timeouts being hit means that the logic is not completing within the allowed deadline; the fix is to discover why the test is hitting the timeout (it may be a useful indicator of a problem) and, if no problems are found, increase the execution timeout in the `Test.configure` method.

---

[Back to index](https://docs.kurtosistech.com)
