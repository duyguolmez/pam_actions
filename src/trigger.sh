#!/bin/bash
id=$(/usr/bin/cat /proc/self/sessionid)
#echo "$date [$1] $PAM_USER $PAM_TYPE $id" >> /var/log/test.log
name=$(/usr/bin/loginctl show-session $id | /usr/bin/grep Name= | /usr/bin/cut -d = -f 2)
if [ "$PAM_TYPE" == "account" ] && [[ -v id ]] && [ "$name" == "$PAM_USER" ];then
	echo "$date $PAM_USER unlocked" >> /var/log/actions.log
#	echo "$(/usr/bin/loginctl show-session $id)" >> /var/log/details.log
elif  [ "$PAM_TYPE" == "open_session" ];then
	echo "$date $PAM_USER logged in" >> /var/log/actions.log
elif  [ "$PAM_TYPE" == "close_session" ];then
	echo "$date $PAM_USER logged out" >> /var/log/actions.log
fi
