#!/bin/sh
IP=$(curl -s https://api.ipify.org)

# Update the DDNS record
curl -s "https://$USER:$PASS@infomaniak.com/nic/update?hostname=$DOMAIN&myip=$IP"

