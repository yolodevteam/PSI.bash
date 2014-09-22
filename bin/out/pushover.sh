#!/bin/bash
## pushover module - out/pushover.sh
# load config
. etc/config/pushover.sh
# pushover
for user in ${config_pushover_userkey[@]}; do
	curl -s --data "token=$config_pushover_apikey&user=$user&message=PSI is now $psi" https://api.pushover.net/1/messages.json
done
echo Pushover module finished.

