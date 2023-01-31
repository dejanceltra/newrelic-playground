NewRelic PHP extension playground
===

Simple VSCode devcontainer for developing/testing/debugging NewRelic PHP extension.

Steps
-----

1. Clone repo.
2. Create `.env` and put:
```
NEW_RELIC_LICENSE_KEY=<actual NR license key>
```
3. Open in VSCode in a devcontainer.

Build
-----

```bash
git clone https://github.com/newrelic/newrelic-php-agent
./build.sh
```
