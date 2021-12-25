#!/bin/bash
#This script configures network connection in RHEL-based systems
if [ "$#" -ne 4 ]; then
    echo "Usage: rh-setup-network.sh IP_ADDRESS/PREFIX GATEWAY COMMA_SEPARATED_DNS_LIST HOSTNAME_FQDN"
	exit 1
fi
hostnamectl set-hostname $4
INTERFACE=$(nmcli conn show | awk -F ' ' 'FNR == 2 {print $4}')
nmcli connection modify $INTERFACE ipv4.method auto ipv4.address "" ipv4.gateway "" ipv4.dns ""
nmcli connection modify $INTERFACE ipv4.method manual ipv4.address $1 ipv4.gateway $2 ipv4.dns $3
nmcli connection show $INTERFACE | grep -i 'ipv4\.address\|ipv4\.gateway\|ipv4\.dns:'
nmcli connection down $INTERFACE
nmcli connection up $INTERFACE