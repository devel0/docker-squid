#!/bin/bash

if [ ! -e /var/spool/squid/00 ]; then squid -z; fi

squid

logfile=/var/log/squid/access.log

while true; do
	if [ ! -e $logfile ]; then sleep 1; else break; fi
done

tail -f $logfile
