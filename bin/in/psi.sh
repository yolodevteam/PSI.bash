#!/bin/bash
set -x
## psi module - in/psi.sh
# PSI reading page
psi_url="http://www.haze.gov.sg/haze-updates/psi-readings-over-the-last-24-hours"
# initialising variables
null=
psi00=0

#make function for setting PSI
function getpsi {
	hour=$1
	case $hour in
	[0])
		arrnum=23
		;;
	*)
		arrnum=$[$hour-1]
		;;
	esac
	# put PSI values into array
	psiarray=( $(curl -s $psi_url | w3m -dump -T 'text/html' | grep '3-hr PSI  ' | sed "s|3-hr PSI  ||g" | tr "\n" " " | tr -s " " " " | sed "s|-|0|g") )
	# check if data is for correct day (p.s. fuck you NEA: https://znx.cc/s1411304937.png)
	if [[ $(date +%k) == " 1" ]]; then # if time is 0100 (" 1" because date +%k is space padded)
		psi00=${psiarray[23]} # set psi23 to PSI for 0000
	fi
	# get PSI reading for current hour
	psi=${psiarray[$arrnum]}
}
getpsi $hour
# check if PSI is updated/11pm's psi still not zero
while [[ $psi == 0 ]] || [[ $psi == $null ]] || [[ $psi00 != 0 ]]; do
	sleep 30
	if [[ $(date +%k) != $hour ]]; then # if current hour is different from hour when script was ran
		echo "Timeout while getting PSI"
		exit 100 # then die
	fi
	getpsi $hour # function above
done
echo PSI module finished.

