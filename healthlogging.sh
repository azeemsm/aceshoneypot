#!/bin/bash

date=$(date)

log -k /root/key.json -s https://docs.google.com/spreadsheets/d/1SDQGK6XhUSj0aarQhAubxcvyWOpagN7_Z69Cvo4tpB0/edit#gid=0 -d "$date"

memhost=$(free -h | awk '{if (NR==2) print $0}' | awk '{print $3}')
diskhost=$(df -h --total | tail -n 1 | awk '{print $3}')
cpuhost=$(uptime | awk '{print $11}')

if [ -z $cpuhost ]
then
	cpuhost=0
fi

cpuhost=$(echo $cpuhost | sed 's/\,//g')	

log -k /root/key.json -s https://docs.google.com/spreadsheets/d/1SDQGK6XhUSj0aarQhAubxcvyWOpagN7_Z69Cvo4tpB0/edit#gid=0 -d "HOST,$memhost,$diskhost,$cpuhost,N/A"

for cont in 101 102 201 202
do
	mem=$(echo "free -h" | pct enter $cont | awk '{if (NR==2) print $0}' | awk '{print $3}')
	
	disk=$(echo "df -h --total | tail -n 1" | pct enter $cont | awk '{print $3}')
	
	cpu=$(pct exec $cont uptime | awk '{print $11}')
	
	if [ -z $cpu ]
	then
		cpu=0
	fi
	
	cpu=$(echo $cpu | sed 's/\,//g')
	
	ssh=$(cat /root/log_files/$cont | wc -l)
	>/root/log_files/$cont

	log -k /root/key.json -s https://docs.google.com/spreadsheets/d/1SDQGK6XhUSj0aarQhAubxcvyWOpagN7_Z69Cvo4tpB0/edit#gid=0 -d "CT$cont,$mem,$disk,$cpu,$ssh"

done

