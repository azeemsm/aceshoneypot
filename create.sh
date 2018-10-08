#!/bin/bash

# container 101, 102: 2GB of RAM
# container 201, 202: 6GB of RAM

cont=$1

ip addr add 128.8.37.104 dev enp4s1
ip addr add 128.8.238.66 dev enp4s1
ip addr add 128.8.238.88 dev enp4s1
ip addr add 128.8.238.110 dev enp4s1

pveam update

# create container 101: has 2GB RAM
if [ $cont -eq 101 ]; then

	pct create 101 /var/lib/vz/template/cache/ubuntu-16.04-standard_16.04-1_amd64.tar.gz --storage local-lvm --net0 name=eth0,ip=172.20.0.5/16,bridge=vmbr0,gw=172.20.0.1 --cores 1 --memory 2048 --swap 0
	
	# FIREWALL RULES: 101
	iptables -t nat -A PREROUTING -d 128.8.37.104 -j DNAT --to-destination 172.20.0.5
	iptables -t nat -A POSTROUTING -s 172.20.0.5 -j SNAT --to-source 128.8.37.104
	# iptables -t nat -I PREROUTING 1 -d 128.8.37.104 -p tcp --dport 22 -j DNAT --to-destination 172.20.0.5:BLAH


	pct start 101
	pct push 101 aceshoneypot/financials.txt ~/financials.txt

# create container 102: has 2GB RAM
elif [ $cont -eq 102 ]; then

	pct create 102 /var/lib/vz/template/cache/ubuntu-16.04-standard_16.04-1_amd64.tar.gz --storage local-lvm --net0 name=eth0,ip=172.20.0.2/16,bridge=vmbr0,gw=172.20.0.1 --cores 1 --memory 2048 --swap 0
	
	# FIREWALL RULES: 102
	iptables -t nat -A PREROUTING -d 128.8.238.66 -j DNAT --to-destination 172.20.0.2

	iptables -t nat -A POSTROUTING -s 172.20.0.2 -j SNAT --to-source 128.8.238.66
	# iptables -t nat -I PREROUTING 1 -d 128.8.238.66 -p tcp --dport 22 -j DNAT --to-destination 172.20.0.2:BLAH


	pct start 102
	pct push 102 aceshoneypot/financials.txt ~/financials.txt

# create container 201: has 6GB RAM
elif [ $cont -eq 201 ]; then
	pct create 201 /var/lib/vz/template/cache/ubuntu-16.04-standard_16.04-1_amd64.tar.gz --storage local-lvm --net0 name=eth0,ip=172.20.0.3/16,bridge=vmbr0,gw=172.20.0.1 --cores 1 --memory 6144 --swap 0

	# FIREWALL RULES: 201
	iptables -t nat -A PREROUTING -d 128.8.238.88 -j DNAT --to-destination 172.20.0.3
	iptables -t nat -A POSTROUTING -s 172.20.0.3 -j SNAT --to-source 128.8.238.88
	# iptables -t nat -I PREROUTING 1 -d 128.8.238.88 -p tcp --dport 22 -j DNAT --to-destination 172.20.0.3:BLAH


	pct start 201
	pct push 201 aceshoneypot/financials.txt ~/financials.txt

# create container 202: has 6GB RAM
elif [ $cont -eq 202 ]; then
	pct create 202 /var/lib/vz/template/cache/ubuntu-16.04-standard_16.04-1_amd64.tar.gz --storage local-lvm --net0 name=eth0,ip=172.20.0.4/16,bridge=vmbr0,gw=172.20.0.1 --cores 1 --memory 6144 --swap 0

	# FIREWALL RULES: 202
	iptables -t nat -A PREROUTING -d 128.8.238.110 -j DNAT --to-destination 172.20.0.4
	iptables -t nat -A POSTROUTING -s 172.20.0.4 -j SNAT --to-source 128.8.238.110
	# iptables -t nat -I PREROUTING 1 -d 128.8.238.110 -p tcp --dport 22 -j DNAT --to-destination 172.20.0.4:BLAH


	pct start 202
	pct push 202 aceshoneypot/financials.txt ~/financials.txt

else
	echo "ERROR"
fi

iptables-save | uniq | iptables-restore
