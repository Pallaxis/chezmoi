#!/usr/bin/env bash

if ssh root@192.168.128.27 -o StrictHostKeyChecking=no "cat /var/log/OTAHandler.log" | awk '/Failed to apply update\./' > /dev/null; then
	echo "failed"
else
	echo "still going"
fi
