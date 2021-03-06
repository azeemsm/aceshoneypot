#!/bin/bash

# checks if it has been a week since each container was created
# if so, destroys and recreates container

date
 
force=0
while [ -n "$1" ]; do # while loop starts
 
    case "$1" in
 
    -f) force=1 ;; # -f option
 
    *) echo "Option $1 not recognized" ;; # In case you typed a different option other than f
 
    esac
 
    shift
 
done

for cont in 101 102 201 202; do
	reset="YES"
	echo "RESET CONTAINER "$cont": "$reset
	
	if [ $reset = "YES" ] || [ $force = 1 ]; then
		echo "RECYCLING CONTAINER $cont"

		pct stop $cont
		killsinglemitm.sh $cont
		umount /dev/mapper/pve-vm--$cont--disk--1
		pct destroy $cont
		# create.sh $cont
		# singlemitm.sh $cont
	fi
done

echo " "
