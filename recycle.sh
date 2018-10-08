#!/bin/bash

# checks if it has been an hour since each container was created
# if so, destroys and recreates container

for cont in 101 102 201 202; do
	reset=$(bash /root/check_times.sh $cont)
	
	if [ $reset = "YES" ]; then
		echo "RECYCLING CONTAINER $cont"

		pct stop $cont
		pct destroy $cont
		bash /root/create.sh $cont
	elif [ $reset = "ERROR" ]; then
		echo "ERROR: check_times.sh returned an error in $cont"
	fi
done
