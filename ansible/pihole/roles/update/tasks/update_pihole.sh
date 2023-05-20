#!/bin/bash

PLAYBOOK_DIRECTORY=$1
cd $PLAYBOOK_DIRECTORY


## Update pihole itself
sudo pihole -up

# Add whatever blocklists we want, then update the lists
sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('https://big.oisd.nl', 1, 'oisd');"
sudo pihole updateGravity

## Update cloudflared
sudo systemctl stop cloudflared
sudo ansible-playbook -i inventory main.yml -t cloudflared

