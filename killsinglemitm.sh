#!/bin/bash

cont=$1

if [ $cont -eq 101 ]; then
	kill `cat /root/nohupOutputs/101pid.txt`
	cp /root/nohupOutputs/101 /root/nohupOutputs/archive/101-`date -Ins`
elif [ $cont -eq 102 ]; then
	kill `cat /root/nohupOutputs/102pid.txt`
	cp /root/nohupOutputs/102 /root/nohupOutputs/archive/102-`date -Ins`
elif [ $cont -eq 201 ]; then
	kill `cat /root/nohupOutputs/201pid.txt`
	cp /root/nohupOutputs/201 /root/nohupOutputs/archive/201-`date -Ins`
elif [ $cont -eq 202 ]; then
	kill `cat /root/nohupOutputs/202pid.txt`
	cp /root/nohupOutputs/202 /root/nohupOutputs/archive/202-`date -Ins`
else
        echo "Invalid Container ID"
fi


#nohup node /root/MITM/mitm/index.js HACS200_1G 10001 172.20.0.5 101 > /root/nohupOutputs/101 &
#echo $! > /root/nohupOutputs/101pid.txt
#nohup node /root/MITM/mitm/index.js HACS200_1G 10002 172.20.0.2 102 > /root/nohupOutputs/102 &
#echo $! > /root/nohupOutputs/102pid.txt
#nohup node /root/MITM/mitm/index.js HACS200_1G 10003 172.20.0.3 201 > /root/nohupOutputs/201 &
#echo $! > /root/nohupOutputs/201pid.txt
#nohup node /root/MITM/mitm/index.js HACS200_1G 10004 172.20.0.4 202 > /root/nohupOutputs/202 &
#echo $! > /root/nohupOutputs/202pid.txt

