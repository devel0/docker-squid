#!/bin/bash

squid -z
squid

logfile=/var/log/squid/access.log

while true; do
	if [ ! -e $logfile ]; then sleep 1; fi
done

tail -f $logfile
