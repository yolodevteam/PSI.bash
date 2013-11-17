#!/bin/bash
## json module - out/json.sh ##
cat << EOF > /var/www/psi/psi.json
{
	"00":${psiarray[0]},
	"01":${psiarray[1]},
	"02":${psiarray[2]},
	"03":${psiarray[3]},
	"04":${psiarray[4]},
	"05":${psiarray[5]},
	"06":${psiarray[6]},
	"07":${psiarray[7]},
	"08":${psiarray[8]},
	"09":${psiarray[9]},
	"10":${psiarray[10]},
	"11":${psiarray[11]},
	"12":${psiarray[12]},
	"13":${psiarray[13]},
	"14":${psiarray[14]},
	"15":${psiarray[15]},
	"16":${psiarray[16]},
	"17":${psiarray[17]},
	"18":${psiarray[18]},
	"19":${psiarray[19]},
	"20":${psiarray[20]},
	"21":${psiarray[21]},
	"22":${psiarray[22]},
	"23":${psiarray[23]}
}
EOF
echo JSON module finished.
