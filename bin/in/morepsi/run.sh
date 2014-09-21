while true; do
output=$(phantomjs ./bin/in/morepsi/fetch.js | sed -e "s|{||" -e "s|}]}|}]|")
if [[ -z "$output" ]]; then
	echo "sleeping"
	sleep 30
else
	echo "$output" | sed -e "s|24-h Sulphur dioxide (�g/m3)|SO2|g" -e "s|24-h PM10 (�g/m3)|PM10|g" -e "s|1-h Nitrogen dioxide (�g/m3)a|NO2|g" -e "s|8-h Ozone (�g/m3)|O3|g" -e "s|8-h Carbon monoxide (mg/m3)|CO|g" -e "s|24-h PM2.5 (�g/m3)b|PM2.5|g"
	break
fi
#echo $output
done

