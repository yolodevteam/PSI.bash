#!/bin/bash
#for when you fuck up
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
}
curl -s http://app2.nea.gov.sg/anti-pollution-radiation-protection/air-pollution/psi/psi-readings-over-the-last-24-hours | w3m -dump -T 'text/html' | grep -E "North  |South  |East  |West  |Central  |Overall  " > /tmp/swag
getinfo
psia=( $(curl -s http://app2.nea.gov.sg/anti-pollution-radiation-protection/air-pollution/psi/psi-readings-over-the-last-24-hours | w3m -dump -T 'text/html' | grep '3-hr PSI  ' | sed "s|3-hr PSI  ||g" | tr "\n" " " | tr -s " " " " | sed "s|-|0|g") )
for i in {20..21}; do
areapm25=(${northPMa[$i]} ${southPMa[$i]} ${eastPMa[$i]} ${westPMa[$i]} ${centralPMa[$i]})
pmmax=${areapm25[0]}
pmmin=${areapm25[0]}
for ii in "${areapm25[@]}"; do
    if [[ "$ii" -gt "$pmmax" ]]; then
        pmmax="$ii"
    fi
    if [[ "$ii" -lt "$pmmin" ]]; then
        pmmin="$ii"
    fi
done
areapsi=(${northPSIa[$i]} ${southPSIa[$i]} ${eastPSIa[$i]} ${westPSIa[$i]} ${centralPSIa[$i]})
psimax=${areapsi[0]}
psimin=${areapsi[0]}
for ii in "${areapsi[@]}"; do
    if [[ "$ii" -gt "$psimax" ]]; then
        psimax="$ii"
    fi
    if [[ "$ii" -lt "$psimin" ]]; then
        psimin="$ii"
    fi
done
#	echo -e "\t\"26:06:$i\": { \"psi\": { \"3hr\":${psia[$i]}, \"min\":$psimin, \"max\":$psimax, \"north\":${northPSIa[$i]}, \"south\":${southPSIa[$i]}, \"east\":${eastPSIa[$i]}, \"west\":${westPSIa[$i]}, \"central\":${centralPSIa[$i]} }, \"pm25\": { \"min\":$pmmin, \"max\":$pmmax, \"north\":${northPMa[$i]}, \"south\":${southPMa[$i]}, \"east\":${eastPMa[$i]}, \"west\":${westPMa[$i]}, \"central\":${centralPMa[$i]} } },"
echo -e "${northPSIa[$i]}\t${northPMa[$i]}\t${southPSIa[$i]}\t${southPMa[$i]}\t${eastPSIa[$i]}\t${eastPMa[$i]}\t${westPSIa[$i]}\t${westPMa[$i]}\t${centralPSIa[$i]}\t${centralPMa[$i]}"
done
