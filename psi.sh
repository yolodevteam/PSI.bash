#!/bin/bash
## psi script by zhongfu
## init
# load config
. etc/config/config.sh
# load modules


## pub json
cat << EOF > /var/www/psi/psi.json
{
	"00":${psia[0]},
	"01":${psia[1]},
	"02":${psia[2]},
	"03":${psia[3]},
	"04":${psia[4]},
	"05":${psia[5]},
	"06":${psia[6]},
	"07":${psia[7]},
	"08":${psia[8]},
	"09":${psia[9]},
	"10":${psia[10]},
	"11":${psia[11]},
	"12":${psia[12]},
	"13":${psia[13]},
	"14":${psia[14]},
	"15":${psia[15]},
	"16":${psia[16]},
	"17":${psia[17]},
	"18":${psia[18]},
	"19":${psia[19]},
	"20":${psia[20]},
	"21":${psia[21]},
	"22":${psia[22]},
	"23":${psia[23]}
}
EOF
echo json done

#### pm2.5 concentration
function getinfo {
	northPSIa=( $(cat /tmp/swag | grep North | head -n 2 | sed -e "s|North||g" -e "s|-|0|g"| tr "\n" " " | tr -s " " " ") )
	northPMa=( $(cat /tmp/swag | grep North | tail -n 2 | sed -e "s|North||g" -e "s|-|0|g"| tr "\n" " " | tr -s " " " ") )
	southPSIa=( $(cat /tmp/swag | grep South | head -n 2 | sed -e "s|South||g" -e "s|-|0|g"| tr "\n" " " | tr -s " " " ") )
	southPMa=( $(cat /tmp/swag | grep South | tail -n 2 | sed -e "s|South||g" -e "s|-|0|g"| tr "\n" " " | tr -s " " " ") )
	eastPSIa=( $(cat /tmp/swag | grep East | head -n 2 | sed -e "s|East||g" -e "s|-|0|g"| tr "\n" " " | tr -s " " " ") )
	eastPMa=( $(cat /tmp/swag | grep East | tail -n 2 | sed -e "s|East||g" -e "s|-|0|g"| tr "\n" " " | tr -s " " " ") )
	westPSIa=( $(cat /tmp/swag | grep West | head -n 2 | sed -e "s|West||g" -e "s|-|0|g"| tr "\n" " " | tr -s " " " ") )
	westPMa=( $(cat /tmp/swag | grep West | tail -n 2 | sed -e "s|West||g" -e "s|-|0|g"| tr "\n" " " | tr -s " " " ") )
	centralPSIa=( $(cat /tmp/swag | grep Central | head -n 2 | sed -e "s|Central||g" -e "s|-|0|g"| tr "\n" " " | tr -s " " " ") )
	centralPMa=( $(cat /tmp/swag | grep Central | tail -n 2 | sed -e "s|Central||g" -e "s|-|0|g"| tr "\n" " " | tr -s " " " ") )

	northPSI=${northPSIa[$(date +%-k)]}
	northPM=${northPMa[$(date +%-k)]}
	southPSI=${southPSIa[$(date +%-k)]}
	southPM=${southPMa[$(date +%-k)]}
	eastPSI=${eastPSIa[$(date +%-k)]}
	eastPM=${eastPMa[$(date +%-k)]}
	westPSI=${westPSIa[$(date +%-k)]}
	westPM=${westPMa[$(date +%-k)]}
	centralPSI=${centralPSIa[$(date +%-k)]}
	centralPM=${centralPMa[$(date +%-k)]}
}
curl -s http://www.haze.gov.sg/haze-update/past-24-hour-psi-reading.aspx | w3m -dump -T 'text/html' | grep -E "North  |South  |East  |West  |Central  |Overall  " > /tmp/swag
getinfo
swag=yes
null=
if [[ $northPSI == 0 ]] || [[ $northPSI == $null ]]; then
	swag=no
fi
if [[ $(date +%-k) == 0 ]] && [[ ${northPSIa[23]} != 0 ]]; then
	swag=no
fi
while [[ $swag == no ]]; do
	sleep 30
	curl -s http://www.haze.gov.sg/haze-update/past-24-hour-psi-reading.aspx | w3m -dump -T 'text/html' | grep -E "North  |South  |East  |West  |Central  |Overall  " > /tmp/swag
	getinfo
	if [[ $northPSI == 0 ]] || [[ $northPSI == $null ]]; then
		swag=no
	else
		swag=yes
	fi
	if [[ $(date +%-k) == 0 ]] && [[ ${northPSIa[23]} != 0 ]]; then
		swag=no
	fi
	if [[ $[ $(date +%-k) + 2 ] != $column1 ]]; then
                echo timeout
                exit 0
        fi
done
rm /tmp/swag
areapm25=($northPM $southPM $eastPM $westPM $centralPM)
pmmax=${areapm25[0]}
pmmin=${areapm25[0]}
for i in "${areapm25[@]}"; do
    if [[ "$i" -gt "$pmmax" ]]; then
        pmmax="$i"
    fi
    if [[ "$i" -lt "$pmmin" ]]; then
        pmmin="$i"
    fi
done
areapsi=($northPSI $southPSI $eastPSI $westPSI $centralPSI)
psimax=${areapsi[0]}
psimin=${areapsi[0]}
for i in "${areapsi[@]}"; do
    if [[ "$i" -gt "$psimax" ]]; then
        psimax="$i"
    fi
    if [[ "$i" -lt "$psimin" ]]; then
        psimin="$i"
    fi
done
if [[ $(grep "$(date +%d:%m:%H)" /var/www/psi/all.json) ]]; then
	exit 0
else
cat << EOF > /var/www/psi/all.json
{
$(cat /var/www/psi/all.json | tail -n 24 | sed '$ d'),
	"$(date +%d:%m:%H)": { "psi": { "3hr":$psi, "min":$psimin, "max":$psimax, "north":$northPSI, "south":$southPSI, "east":$eastPSI, "west":$westPSI, "central":$centralPSI }, "pm25": { "min":$pmmin, "max":$pmmax, "north":$northPM, "south":$southPM, "east":$eastPM, "west":$westPM, "central":$centralPM } }
}
EOF
fi
