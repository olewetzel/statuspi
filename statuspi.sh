#!/bin/bash

# getting informations about raspberry pis in the network
ip[1]=192.168.178.5  #raspberry
ip[2]=192.168.178.17 #berrycam
ip[3]=192.168.178.28 #plexberry
ip[4]=192.168.178.39 #kitchentable
ip[5]=192.168.178.74 #openhab
ip[6]=192.186.178.80 #pihole
ip[7]=192.168.178.99 #automotiverocketlauncher
user=user #username of all systems
passwd=pass #password for ssh


#!/bin/bash
for adress in ${ip[@]} ; do
    ping -q -c1 ${adress} > /dev/null
    if [ $? -eq 0 ]
    then
        sshpass -p ${passwd} ssh ${user}@${adress} 'bash -s' < remote.sh
        #ssh ${user}@${adress} 'bash -s' < remote.sh
    else
    status="✘";
    workdir=$(pwd);
    workname=${adress};
    worknameshort=$(cut -d'.' -f4<<<$workname)
    # upload $data.js to webspace
    curl -T $worknameshort.js -u user:pass ftp://server.net/
    # clean up the mess
    rm $workdir/$worknameshort.js
    fi
done
