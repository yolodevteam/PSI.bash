#!/bin/bash
#### token creation script ####
#### creates google spreadsheet token, used for setting spreadsheet info ####
. ../etc/config.sh
#### start script
curl https://www.google.com/accounts/ClientLogin -d Email="$config_gdocs_email" -d Passwd="$config_gdocs_password" -d accountType=GOOGLE -d source=cURL -d service=wise | grep Auth | cut -d\= -f2 > ../etc/gdocstoken
echo "Token generated."

