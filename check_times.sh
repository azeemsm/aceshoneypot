#!/bin/bash

container=$1

regexp="([0-9][0-9]):([0-9][0-9]):[0-9][0-9]"

last=$(pct exec $container last reboot | tail -n1 | grep "wtmp begins")
curr=$(pct exec $container date)

if [[ $last =~ $regexp ]]; then
	last_hour=${BASH_REMATCH[1]}
	last_mins=${BASH_REMATCH[2]}

	
	if [[ $curr =~ $regexp ]]; then
		curr_hour=${BASH_REMATCH[1]}
		curr_mins=${BASH_REMATCH[2]}

		# find time difference

		mins_diff=$(($curr_mins - $last_mins))
		
		if [ $curr_hour -lt $last_hour ]; then
			curr_hour=$((curr_hour + 24))
		fi
			
		if [ $mins_diff -lt 0 ]; then
			last_hour=$((last_hour + 1))
		fi
		
		if [ $curr_hour -gt $last_hour ]; then
			echo "YES"
		else
			echo "NO"
		fi
	else
		echo "ERROR: Date command format is malfunctioning"
		exit 0
	fi
else
	echo "ERROR: wtmp begins does not appear in last reboot command"
	exit 0
fi

exit 1
