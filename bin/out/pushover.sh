#!/bin/bash
## pushover module - out/pushover.sh
# load config
. etc/config/pushover.sh
# pushover
for user in ${config_pushover_keys[@]}; do
	curl --silent --form token="$config_pushover_apikey" --form user="$user" --form message="PSI is now $psi" https://api.pushover.net/1/messages.json > /dev/null
done
echo Pushover module finished.

