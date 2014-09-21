while true; do
output=$(phantomjs bin/in/morepsi/fetch.js | sed -e "s|{||" -e "s|}]}|}]|")
if [[ -z "$output" ]]; then
	echo "sleeping"
	sleep 30
	if [[ $(date +%k) != $hour ]]; then # if current hour is different from hour when script was ran
		echo "Timeout while getting morepsi"
		exit 100 # then die
	fi
else
	echo "$output" | sed -e "s|24-hr Sulphur dioxide(µg/m3)|SO2|g" -e "s|24-hr PM10(µg/m3)|PM10|g" -e "s|1-hr Nitrogen dioxide(µg/m3)a|NO2|g" -e "s|8-hr Ozone(µg/m3)|O3|g" -e "s|8-hr Carbon monoxide(mg/m3)|CO|g" -e "s|24-hr PM2.5(µg/m3)|PM2.5|g" 
	break
fi
#echo $output
done

