#!/bin/bash
## json module - out/json.sh ##
. etc/config/html.sh
cat << EOF > ${config_html_dir}/psi.json
{
$(cat ${config_html_dir}psi.json | tail -n 24 | sed '$ d'),
	"$(date +%d:%m:%H)":${psiarray[$hour]}
}
EOF
cat << EOF > ${config_html_dir}/all.json
{
$(cat ${config_html_dir}/all.json | tail -n 24 | sed '$ d'),
	$morepsi
}
EOF
echo JSON module finished.
