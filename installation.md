Installing & Upgrading
======================
[Interacting with Kurtosis][using-the-cli] is done via a CLI; the instructions below will walk you through installing it.

**TIP:** The CLI supports tab completion. After you install using one of the methods below, follow [these instructions](./adding-tab-completion.md) to enable tab completion.

Installation
------------
### Homebrew
```
brew install kurtosis-tech/tap/kurtosis-cli
```

NOTE: Homebrew might warn you that your Xcode is outdated, like so:

```
Error: Your Xcode (11.5) is too outdated.
Please update to Xcode 12.5 (or delete it).
```

[This is a Homebrew requirement](https://docs.brew.sh/Installation), and has nothing to do with Kurtosis (which ships as prebuilt binaries). To update your Xcode, run:

```
xcode-select --install
```

### apt
```
echo "deb [trusted=yes] https://apt.fury.io/kurtosis-tech/ /" | sudo tee /etc/apt/sources.list.d/kurtosis.list
sudo apt update
sudo apt install kurtosis-cli
```

### yum
```
echo '[kurtosis]
name=Kurtosis
baseurl=https://yum.fury.io/kurtosis-tech/
enabled=1
gpgcheck=0' | sudo tee /etc/yum.repos.d/kurtosis.repo
sudo yum install kurtosis-cli
```

### deb, rpm, and apk
Download the appropriate artifact from [the release artifacts page][release-artifacts].

Once the CLI is installed, [the quickstart is a great place to get started][quickstart].

Metrics Election
----------------
The first time you run the Kurtosis CLI, you'll be asked to make an election about whether you'd like to send anonymized product analytics metrics. Our reasons for doing this, and how we strive to do this ethically, can be found [here](./metrics-philosophy.md).

If you're running the CLI in a CI environment, see [these instructions](./running-in-ci.md) to see how to make the metrics election non-interactively.

Upgrading
---------
You can check the version of the CLI you're running with `kurtosis version`. To upgrade to latest, check [the changelog to see if there are any breaking changes][changelog] and follow the steps below. 

NOTE: if you're upgrading the CLI's minor version (the `Y` in a `X.Y.Z` version), you may need to restart your Kurtosis engine after the upgrade. If this is needed, the Kurtosis CLI will prompt you with an error like so:
```
The engine server API version that the CLI expects, 1.7.4, doesn't match the running engine server API version, 1.6.8; this would cause broken functionality so you'll need to restart the engine to get the correct version by running 'kurtosis engine restart'
```
The fix is to restart the engine like so:
```
kurtosis engine restart
```

### Homebrew
```
brew upgrade kurtosis-tech/tap/kurtosis-cli
```

### apt
```
apt install --only-upgrade kurtosis-cli
```

### yum
```
yum upgrade kurtosis-cli
```

### deb, rpm, and apk
Download the appropriate artifact from [the release artifacts page][release-artifacts].

---

[Back to index](https://docs.kurtosistech.com)

[using-the-cli]: ./using-the-cli.md
[lib-documentation]: ./kurtosis-client/lib-documentation
[quickstart]: https://github.com/kurtosis-tech/kurtosis-onboarding-experience/tree/master#kurtosis-ethereum-quickstart
[release-artifacts]: https://github.com/kurtosis-tech/kurtosis-cli-release-artifacts/releases
[changelog]: ./kurtosis/changelog
