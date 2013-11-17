#!/bin/bash
## psi script by zhongfu
set -x
## init
# load config
. etc/config/config.sh
# load modules
for inmod in $config_main_inmod; do
	. bin/in/$inmod.sh
done
for outmod in $config_main_outmod; do
	. bin/out/$outmod.sh
done
