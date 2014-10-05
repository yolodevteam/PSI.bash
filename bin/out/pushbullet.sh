#!/bin/bash
## pushbullet module - out/pushbullet.sh
# load config
. etc/config/pushbullet.sh
# pushbullet
curl -s -u ${config_pushbullet_accesstoken}: -X POST https://api.pushbullet.com/v2/pushes --header 'Content-Type: application/json' --data-binary "{\"type\": \"note\", \"channel_tag\": \"${config_pushbullet_channel}\", \"title\": \"PSI at $(date +"%d-%m-%Y %H:00")\", \"body\": \"PSI for $(date +%H:00) is ${psi}\"}"
echo Pushbullet module finished.
