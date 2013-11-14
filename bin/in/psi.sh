#!/bin/bash
## psi module - in/psi.sh
# PSI reading page
psi_url="http://www.haze.gov.sg/haze-update/past-24-hour-psi-reading.aspx"
# get current hour -- for checking if the script will timeout
hour=$(date +%k)
# initialising variables
null=
psi23=0

#make function for setting PSI
function getpsi {
	# put PSI values into array
	psiarray=( $(curl -s $psi_url | w3m -dump -T 'text/html' | grep '3-hr PSI  ' | sed "s|3-hr PSI  ||g" | tr "\n" " " | tr -s " " " " | sed "s|-|0|g") )
	# check if data is for correct day
	if [[ $(date +%k) == " 0" ]]; then # if time is midnight (" 0" because date +%k is space padded)
		psi23=${psiarray[23]} # set psi23 to PSI for 2300
	fi
	# get PSI reading for current hour
	psi=${psiarray[$(date +%k)]}
}

# check if PSI is updated/11pm's psi still not zero
while [[ $psi == 0 ]] || [[ $psi == $null ]] || [[ $psi23 != 0 ]]; do
	sleep 30
	if [[ $(date +%k) != $hour ]]; then # if current hour is different from hour when script was ran
		echo "Timeout while getting PSI"
		exit 100 # then die
	fi
	getpsi # function above
done
