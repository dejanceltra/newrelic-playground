#!/bin/bash
set -eu -o pipefail

killall /usr/local/bin/newrelic-daemon || true

# NewRelic doesn't build on GCC 11 (default on Jammy)
# https://github.com/newrelic/newrelic-php-agent/issues/456
export CC=/usr/bin/gcc-10 
export CPP="/usr/bin/gcc-10 -E"

cd /app/newrelic-php-agent
make all -j 8

# Copy daemon
sudo cp /app/newrelic-php-agent/bin/daemon /usr/local/bin/newrelic-daemon
# Copy php extension into php extentions dir
sudo cp /app/newrelic-php-agent/agent/.libs/newrelic.so $(php -i | grep extension_dir  | cut -d " " -f 5)/newrelic.so
# Setup newrelic.ini
echo "extension = $(php -i | grep extension_dir  | cut -d ' ' -f 5)/newrelic.so" | sudo tee /etc/php/8.1/mods-available/newrelic.ini
echo 'newrelic.daemon.location = "/usr/local/bin/newrelic-daemon"' | sudo tee -a /etc/php/8.1/mods-available/newrelic.ini
echo 'newrelic.enabled = 1'  | sudo tee -a /etc/php/8.1/mods-available/newrelic.ini
echo "newrelic.license=${NEW_RELIC_LICENSE_KEY}" | sudo tee -a /etc/php/8.1/mods-available/newrelic.ini
sudo phpenmod newrelic

sudo mkdir -p /var/log/newrelic
sudo chmod 777 /var/log/newrelic
