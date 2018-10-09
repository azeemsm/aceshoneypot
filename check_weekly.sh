#!/bin/bash

# checks if it has been a week since the container was recycled

container=$1

regexp="([A-Za-z]+)[[:space:]]*([0-9]+)[[:space:]]*[0-9][0-9]:[0-9][0-9]:[0-9][0-9]"

last=$(pct exec $container last reboot | tail -n1 | grep "^wtmp begins")
curr=$(pct exec $container date)

if [[ $last =~ $regexp ]]
then
	last_month=${BASH_REMATCH[1]}
	last_day=${BASH_REMATCH[2]}

	if [[ $curr =~ $regexp ]]; then
		curr_month=${BASH_REMATCH[1]}
		curr_day=${BASH_REMATCH[2]}

		# find time difference
		
		diff_days=$(($curr_day - $last_day))
		
		if [ $curr_month != $last_month ]; then
			curr_day=$((curr_day + 31))
		fi
		
		last_day=$(($last_day + 7))

		if [ $curr_day -ge $last_day ]; then
			echo "YES"
		else
			echo "NO"
		fi
	else
		echo "ERROR: date command does not match regexp"
		exit 1
	fi
else
	echo "ERROR: last reboot command does not match regexp"
	exit 1
fi

exit 0
