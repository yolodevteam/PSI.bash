#!/bin/bash
## html module - out/html.sh
# load config
. etc/config/html.sh
# write PSI webpage
cat << EOF > ${config_html_dir}/index.html
$(cat common/html/head)
<body>
	<center>
		<p2>PSI for $(date +%d/%m/%Y\ %H00hrs)</p2>
		<h1>$psi</h1>
		<br>
		<a href="/psi/psi.json">JSON</a>
		<a href="/psi/all.json">More JSON</a><br>
		Contact: psi AT zhongfu DOT li<br><br>
		<b>NEW:</b> <a href="https://pushbullet.com/channel?tag=sgpsi">Pushbullet channel!</a>
		<hr>
		<p2>Past readings:</p2>
$(cat etc/pasthtml)
	</center>
	<script>
		(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
		ga('create', '$config_html_ganalytics_tid', '$config_html_ganalytics_domain');
        	ga('send', 'pageview');
	</script>
</body>
</html>
EOF

## make past psi record for html
currentdate=$(date +%d/%m/%Y\ %H:00)
if [[ $(grep "$currentdate" etc/pasthtml) == $null ]]; then
	cat << EOF > etc/pasthtml
		<p><h2>$psi</h2>at $currentdate</p><br>
$(head -n 23 etc/pasthtml)
EOF
fi

echo HTML module finished.
