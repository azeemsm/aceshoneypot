#!/bin/bash

nohup node /root/MITM/mitm/index.js HACS200_1G 10001 172.20.0.5 101 > /root/nohupOutputs/101 &
echo $! > /root/nohupOutputs/101pid.txt
nohup node /root/MITM/mitm/index.js HACS200_1G 10002 172.20.0.2 102 > /root/nohupOutputs/102 &
echo $! > /root/nohupOutputs/102pid.txt
nohup node /root/MITM/mitm/index.js HACS200_1G 10003 172.20.0.3 201 > /root/nohupOutputs/201 &
echo $! > /root/nohupOutputs/201pid.txt
nohup node /root/MITM/mitm/index.js HACS200_1G 10004 172.20.0.4 202 > /root/nohupOutputs/202 &
echo $! > /root/nohupOutputs/202pid.txt

