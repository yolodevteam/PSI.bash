#!/bin/bash
## other PSI stuff: other pollutants, PSI per area etc. - in/morepsi.sh ##
$morepsi="phantomjs morepsi/fetch.js"
cat << EOF > /var/www/psi/all.json
{
$(cat /var/www/psi/all.json | tail -n 24 | sed '$ d'),
	$morepsi
}
EOF
fi
echo morepsi module finished.
