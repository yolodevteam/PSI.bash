#!/bin/bash
## psi script by zhongfu
exec 2>&1
set -x
## init
# load config
. etc/config/config.sh
hour=$(date +%k)
# load modules
for inmod in $config_main_inmod; do
	. bin/in/$inmod.sh
done
for outmod in $config_main_outmod; do
	. bin/out/$outmod.sh
done
