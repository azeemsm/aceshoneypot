#!/bin/bash

# Destroys and recreates container for argument passed in 
cont=$1

echo "1" >> /root/log_files/$cont
echo "1" >> /root/counter/$cont

sleep 1h

#scp -i ~/.ssh/id_rsa.pub -rp /media/$cont/media root@10.2.0.2/downloads

#killmitm.sh

echo "RECYCLING CONTAINER $cont"
pct stop $cont
killsinglemitm.sh $cont
pct destroy $cont
create.sh $cont

#mitm.sh
singlemitm.sh $cont


echo " "
