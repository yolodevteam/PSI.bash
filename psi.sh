#!/bin/bash
###### psi script by zhongfu ######
set -x
#### load config
. etc/config.sh

#### get PSI readings for the day into an array
psia=( $(curl -s http://app2.nea.gov.sg/anti-pollution-radiation-protection/air-pollution/psi/psi-readings-over-the-last-24-hours | w3m -dump -T 'text/html' | grep '3-hr PSI  ' | sed "s|3-hr PSI  ||g" | tr "\n" " " | tr -s " " " " | sed "s|-|0|g") )

#### get PSI for hour
psi=${psia[$(date +%k)]}

## set token var
token=$(cat etc/gdocstoken)

## get row and column for first req
## you might want to fix this for your spreadsheet
row1=$[ ( $(date +%s) - $(date -d "06/15/2013" +%s) ) / 86400 ]
column1=$[ $(date +%k) + 2 ]
## get row for second req
row2=$[ ( $(date +%s) - $(date -d "06/17/2013" +%s) ) / 3600 + 2 ]

## wait for psi to update
null=
## if time is midnight, check if 11pm's data still exists; if yes, it's probably yesterday's data
psi23=0
if [[ $(date +%k) == " 0" ]]; then
	psi23=${psia[23]}
fi
## check if PSI is updated/11pm's psi still not zero
while [[ $psi == 0 ]] || [[ $psi == $null ]] || [[ $psi23 != 0 ]]; do
	sleep 30
	psia=( $(curl -s http://app2.nea.gov.sg/anti-pollution-radiation-protection/air-pollution/psi/psi-readings-over-the-last-24-hours | w3m -dump -T 'text/html' | grep '3-hr PSI  ' | sed "s|3-hr PSI  ||g" | tr "\n" " " | tr -s " " " " | sed "s|-|0|g") )
	if [[ $(date +%k) == " 0" ]]; then
		psi23=${psia[23]}
	fi
	psi=${psia[$(date +%k)]}
	if [[ $[ $(date +%k) + 2 ] != $column1 ]]; then
		echo timeout
		exit 0
	fi
done

## create 1st request xml for gdocs spreadsheet
cat << EOF > /tmp/req1.xml
<entry xmlns="http://www.w3.org/2005/Atom"
    xmlns:gs="http://schemas.google.com/spreadsheets/2006">
  <id>https://spreadsheets.google.com/feeds/cells/0AivhrAwkYK9VdFhZZ041YlNBaWI5aEpxOWgzWFdhQ3c/od6/private/full/R${row1}C${column1}</id>
  <link rel="edit" type="application/atom+xml"
    href="https://spreadsheets.google.com/feeds/cells/0AivhrAwkYK9VdFhZZ041YlNBaWI5aEpxOWgzWFdhQ3c/od6/private/full/R${row1}C${column1}"/>
  <gs:cell row="$row1" col="$column1" inputValue="$psi"/>
</entry>
EOF
## create 2nd request xml for gdocs spreadsheet
cat << EOF > /tmp/req2.xml
<entry xmlns="http://www.w3.org/2005/Atom"
    xmlns:gs="http://schemas.google.com/spreadsheets/2006">
  <id>https://spreadsheets.google.com/feeds/cells/0AivhrAwkYK9VdFhZZ041YlNBaWI5aEpxOWgzWFdhQ3c/oda/private/full/R${row2}C2</id>
  <link rel="edit" type="application/atom+xml"
    href="https://spreadsheets.google.com/feeds/cells/0AivhrAwkYK9VdFhZZ041YlNBaWI5aEpxOWgzWFdhQ3c/oda/private/full/R${row2}C$2"/>
  <gs:cell row="$row2" col="2" inputValue="$psi"/>
</entry>
EOF
## send xml
curl -L --silent --request PUT --header "Authorization: GoogleLogin auth=${token}" "https://spreadsheets.google.com/feeds/cells/0AivhrAwkYK9VdFhZZ041YlNBaWI5aEpxOWgzWFdhQ3c/od6/private/full/R${row1}C${column1}?v=3.0" --header "Content-Type: application/atom+xml" --header "If-Match: *" --data-binary "@/tmp/req1.xml" > /dev/null
echo gdocs 1 done
curl -L --silent --request PUT --header "Authorization: GoogleLogin auth=${token}" "https://spreadsheets.google.com/feeds/cells/0AivhrAwkYK9VdFhZZ041YlNBaWI5aEpxOWgzWFdhQ3c/oda/private/full/R${row2}C2?v=3.0" --header "Content-Type: application/atom+xml" --header "If-Match: *" --data-binary "@/tmp/req2.xml" > /dev/null
echo gdocs 2 done
rm /tmp/req1.xml /tmp/req2.xml
#### pushover
for user in ${config_pushover_keys[@]}; do
	curl --silent --form token="$config_pushover_apikey" --form user="$user" --form message="PSI is now $psi" https://api.pushover.net/1/messages.json > /dev/null
	echo pushover user $user done
done
#### write PSI webpage
cat << EOF > /var/www/psi/index.html
<!DOCTYPE html>
<html lang="en">
<head>
	<meta content="text/html;charset=UTF-8" http-equiv="Content-Type">
	<meta charset="utf-8">
	<title>SG PSI</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="apple-mobile-web-app-capable" content="yes">
        <link rel="apple-touch-icon" sizes="144x144" href="/assets/img/psi/apple-touch-icon-144.png">
        <link rel="apple-touch-icon" sizes="114x114" href="/assets/img/psi/apple-touch-icon-114.png">
        <link rel="apple-touch-icon" sizes="72x72" href="/assets/img/psi/apple-touch-icon-72.png">
        <link rel="apple-touch-icon" href="/assets/img/psi/apple-touch-icon-57.png">
	<link rel="shortcut icon" href="/assets/img/psi/favicon.ico" type="image/x-icon">
	<link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Ubuntu:regular,bold&subset=Latin">
        <style>
        h1 {
                font-family: Ubuntu, sans-serif;
                font-size: 160px;
                line-height: 1;
        }
        h2 {
                font-family: Ubuntu, sans-serif;
                font-size: 96px;
                line-height: 1;
                margin: 0;
        }
        body,
        p {
                font-family: Ubuntu, sans-serif;
                font-size: 18px;
        }
        p2 {
                font-family: Ubuntu, sans-serif;
                font-size: 24px;
        }
        a {
                font-family: Ubuntu, sans-serif;
                color: #0088cc;
                text-decoration: none;
        }
        a:hover,
        a:focus {
                font-family: Ubuntu, sans-serif;
                color: #005580;
                text-decoration: underline;
        }
        hr {
                margin: 20px 0;
                border: 0;
                border-top: 1px solid #eeeeee;
                border-bottom: 1px solid #ffffff;
        }
        </style>
</head>
<body>
	<center>
		<p2>PSI for $(date +%d/%m/%Y\ %H00hrs)</p2>
		<h1>$psi</h1>
		<a href="/psi/graphs">Graphs</a>
		<a href="/psi/data">Data</a>
		<a href="/psi/all">Graphs + Data</a>
		<br>
		<a href="https://docs.google.com/a/znx.cc/spreadsheet/ccc?key=0AivhrAwkYK9VdFhZZ041YlNBaWI5aEpxOWgzWFdhQ3c">Spreadsheet here</a>
		<br>
		<a href="/psi/psi.json">JSON</a>
		<a href="/psi/all.json">More JSON</a>
		<br>
		<a href="mailto:me@znx.cc">Contact</a>
		<hr>
		<p2>Past readings:</p2>
$(cat etc/pasthtml)
	</center>
	<script>
		(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
		ga('create', '$config_ganalytics_tid', '$config_ganalytics_domain');
        	ga('send', 'pageview');
	</script>
</body>
</html>
EOF
echo html done
## make pasthtml
currentdate=$(date +%d/%m/%Y\ %H:00)
if [[ $(grep "$currentdate" etc/pasthtml) == $null ]]; then
	cat << EOF > etc/pasthtml
		<p><h2>$psi</h2>at $currentdate</p><br>
$(head -n 9 etc/pasthtml)
EOF
	echo pasthtml done
fi
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
	northPSI=( $(cat /tmp/swag | grep North | head -n 2 | sed -e "s|North||g" -e "s|-|0|g"| tr "\n" " " | tr -s " " " ") )
	northPM=( $(cat /tmp/swag | grep North | tail -n 2 | sed -e "s|North||g" -e "s|-|0|g"| tr "\n" " " | tr -s " " " ") )

	southPSI=( $(cat /tmp/swag | grep South | head -n 2 | sed -e "s|South||g" -e "s|-|0|g"| tr "\n" " " | tr -s " " " ") )
	southPM=( $(cat /tmp/swag | grep South | tail -n 2 | sed -e "s|South||g" -e "s|-|0|g"| tr "\n" " " | tr -s " " " ") )

	eastPSI=( $(cat /tmp/swag | grep East | head -n 2 | sed -e "s|East||g" -e "s|-|0|g"| tr "\n" " " | tr -s " " " ") )
	eastPM=( $(cat /tmp/swag | grep East | tail -n 2 | sed -e "s|East||g" -e "s|-|0|g"| tr "\n" " " | tr -s " " " ") )

	westPSI=( $(cat /tmp/swag | grep West | head -n 2 | sed -e "s|West||g" -e "s|-|0|g"| tr "\n" " " | tr -s " " " ") )
	westPM=( $(cat /tmp/swag | grep West | tail -n 2 | sed -e "s|West||g" -e "s|-|0|g"| tr "\n" " " | tr -s " " " ") )

	centralPSI=( $(cat /tmp/swag | grep Central | head -n 2 | sed -e "s|Central||g" -e "s|-|0|g"| tr "\n" " " | tr -s " " " ") )
	centralPM=( $(cat /tmp/swag | grep Central | tail -n 2 | sed -e "s|Central||g" -e "s|-|0|g"| tr "\n" " " | tr -s " " " ") )
}
curl -s http://app2.nea.gov.sg/anti-pollution-radiation-protection/air-pollution/psi/psi-readings-over-the-last-24-hours | w3m -dump -T 'text/html' | grep -E "North  |South  |East  |West  |Central  |Overall  " > /tmp/swag
getinfo
if [[ ${northPSI[$(date +%-k)]} == 0 ]]; then
	swag=no
else
	swag=yes
fi
if [[ $(date +%-k) == 0 ]] && [[ ${northPSI[23]} != 0 ]]; then
	swag=no
else
	swag=yes
fi
while [[ $swag == no ]]; do
	sleep 30
	curl -s http://app2.nea.gov.sg/anti-pollution-radiation-protection/air-pollution/psi/psi-readings-over-the-last-24-hours | w3m -dump -T 'text/html' | grep -E "North  |South  |East  |West  |Central  |Overall  " > /tmp/swag
	getinfo
	if [[ ${northPSI[$(date +%-k)]} != 0 ]]; then
		getinfo
		swag=yes
	fi
	if [[ $[ $(date +%k) + 2 ] != $column1 ]]; then
                echo timeout
                exit 0
        fi
done
rm /tmp/swag
# upload gdocs
. bin/xml.sh
echo gdocs pm25 done
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
cat << EOF > /var/www/psi/all.json
{
$(cat /var/www/psi/all.json | tail -n 24 | sed '$ d'),
	"$(date +%d:%m:%H)": { "psi": { "3hr":$psi, "min":$psimin, "max":$psimax, "north":$northPSI, "south":$southPSI, "east":$eastPSI, "west":$westPSI, "central":$centralPSI }, "pm25": { "min":$pmmin, "max":$pmmax, "north":$northPM, "south":$southPM, "east":$eastPM, "west":$westPM, "central":$centralPM } }
}
EOF
else
	exit 0
fi
