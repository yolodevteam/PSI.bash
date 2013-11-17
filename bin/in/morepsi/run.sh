while true; do
output=$(phantomjs fetch.js)
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

