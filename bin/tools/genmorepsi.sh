#!/bin/bash
time=$1
array=( $(curl -s http://app2.nea.gov.sg/anti-pollution-radiation-protection/air-pollution-control/psi/pollutant-concentrations/time/${time}00 | grep text_psinormal -A 135 | grep -Ev "tr|td|th" | tr -d " " | tr -s "\r\n" "\n") )

n_so2="${array[0]}"
n_pm10="${array[1]}"
n_no2="${array[2]}"
n_o3="${array[3]}"
n_co="${array[4]}"
n_pm25="${array[5]}"

s_so2="${array[6]}"
s_pm10="${array[7]}"
s_no2="${array[8]}"
s_o3="${array[9]}"
s_co="${array[10]}"
s_pm25="${array[11]}"

e_so2="${array[12]}"
e_pm10="${array[13]}"
e_no2="${array[14]}"
e_o3="${array[15]}"
e_co="${array[16]}"
e_pm25="${array[17]}"

w_so2="${array[18]}"
w_pm10="${array[19]}"
w_no2="${array[20]}"
w_o3="${array[21]}"
w_co="${array[22]}"
w_pm25="${array[23]}"

c_so2="${array[24]}"
c_pm10="${array[25]}"
c_no2="${array[26]}"
c_o3="${array[27]}"
c_co="${array[28]}"
c_pm25="${array[29]}"

cat << EOF
"21:09:$time":[{"Region":"North","SO2":"$n_so2","PM10":"$n_pm10","NO2":"$n_no2","O3":"$n_o3","CO":"$n_co","PM2.5":"$n_pm25"},{"Region":"South","SO2":"$s_so2","PM10":"$s_pm10","NO2":"$s_no2","O3":"$s_o3","CO":"$s_co","PM2.5":"$s_pm25"},{"Region":"East","SO2":"$e_so2","PM10":"$e_pm10","NO2":"$e_no2","O3":"$e_o3","CO":"$e_co","PM2.5":"$e_pm25"},{"Region":"West","SO2":"$w_so2","PM10":"$w_pm10","NO2":"$w_no2","O3":"$w_o3","CO":"$w_co","PM2.5":"$w_pm25"},{"Region":"Central","SO2":"$c_so2","PM10":"$c_pm10","NO2":"$c_no2","O3":"$c_o3","CO":"$c_co","PM2.5":"$c_pm25"}]
EOF
