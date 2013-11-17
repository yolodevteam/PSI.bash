#!/bin/bash
## json module - out/json.sh ##
cat << EOF > /var/www/psi/psi.json
{
$(cat /var/www/psi/psi.json | tail -n 24 | sed '$ d'),
	"$(date +%d:%m:%H)":${psiarray[$hour]}
}
EOF
cat << EOF > /var/www/psi/all.json
{
$(cat /var/www/psi/all.json | tail -n 24 | sed '$ d'),
	$morepsi
}
EOF
echo JSON module finished.
