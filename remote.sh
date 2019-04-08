#!/bin/bash

# if remote is used ping was successful
status="✓"
# check hostname, kernel, release and processor
host=$(uname -a)
kernelname="$(cut -d' ' -f1 <<<$host)"
release="$(cut -d' ' -f3 <<<$host)"
machine="$(cut -d' ' -f11 <<<$host)"
host="$(cut -d' ' -f2 <<<$host)"
# check cpu temperature
temp=$(cat /sys/class/thermal/thermal_zone0/temp)
temp="$(($temp/1000))°C"
# check uptime and calculate a better layout
uptime=$(cat /proc/uptime)
uptime=${uptime%%.*};
secs=$((${uptime}%60))
mins=$((${uptime}/60%60))
hours=$((${uptime}/3600%24))
days=$((${uptime}/86400))
if [ "${days}" -eq "0" ]
    then
    uptime="${hours}h${mins}m${secs}s"
else
    uptime="${days}d${hours}h${mins}m${secs}s"
fi

# save data in *.js
workdir=$(pwd);
workname=$(hostname -I)
worknameshort=$(cut -d'.' -f4 <<<$workname)
worknameshort=`echo "$worknameshort" | sed "s/ //g"`
echo $host > $workdir/$worknameshort.js
echo $status >> $workdir/$worknameshort.js
echo $kernelname >> $workdir/$worknameshort.js
echo $release >> $workdir/$worknameshort.js
echo $machine >> $workdir/$worknameshort.js
echo $temp >> $workdir/$worknameshort.js
echo $uptime >> $workdir/$worknameshort.js
# upload $data.js to webspace
curl -T $worknameshort.js -u user:pass ftp://server.net/
# clean up the mess
rm $workdir/$worknameshort.js
