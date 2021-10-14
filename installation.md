Installation
============
Interacting with Kurtosis is done via a CLI. The following methods are currently supported:

### Homebrew
```
brew install kurtosis-tech/tap/kurtosis-cli
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

---

[Back to index](https://docs.kurtosistech.com)

[lib-documentation]: ./kurtosis-client/lib-documentation
[quickstart]: https://github.com/kurtosis-tech/kurtosis-onboarding-experience/tree/master#kurtosis-ethereum-quickstart
[release-artifacts]: https://github.com/kurtosis-tech/kurtosis-cli-release-artifacts/releases
