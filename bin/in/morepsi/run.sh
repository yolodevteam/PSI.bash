while true; do
output=$(phantomjs ./bin/in/morepsi/fetch.js)
echo "hello"
if [[ -z "$output" ]]; then
	echo "sleeping"
	sleep 30
else
	echo "$output"
	break
fi
#echo $output
done

