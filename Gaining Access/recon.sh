#!/bin/bash

IP=$1

nmap -sC -sV -p- --min-rate 5000 -oN scan.nmap $IP

echo "Searching exploits..."

grep open scan.nmap | awk '{print $3}' | xargs searchsploit  
