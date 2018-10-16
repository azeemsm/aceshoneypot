#!/bin/bash

#kill `cat /root/nohupOutputs/101pid.txt`
#kill `cat /root/nohupOutputs/102pid.txt`
#kill `cat /root/nohupOutputs/201pid.txt`
#kill `cat /root/nohupOutputs/202pid.txt`
cont=$1
if [ $cont -eq 101 ]; then
	nohup node /root/MITM/mitm/index.js HACS200_1G 10001 172.20.0.5 101 > /root/nohupOutputs/101 &
	echo $! > /root/nohupOutputs/101pid.txt
elif [ $cont -eq 102 ]; then
	nohup node /root/MITM/mitm/index.js HACS200_1G 10002 172.20.0.2 102 > /root/nohupOutputs/102 &
	echo $! > /root/nohupOutputs/102pid.txt
elif [ $cont -eq 201 ]; then
	nohup node /root/MITM/mitm/index.js HACS200_1G 10003 172.20.0.3 201 > /root/nohupOutputs/201 &
	echo $! > /root/nohupOutputs/201pid.txt
elif [ $cont -eq 202 ]; then
	nohup node /root/MITM/mitm/index.js HACS200_1G 10004 172.20.0.4 202 > /root/nohupOutputs/202 &
	echo $! > /root/nohupOutputs/202pid.txt
else
	echo "Invalid Container ID"
fi

