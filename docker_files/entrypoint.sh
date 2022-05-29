#!/bin/bash
cd /
./get_repos.py
if [ $UPDATE_ON_START != 0 ]; then
	./mirror_repos.sh
fi
cron

cd /repos
cd `find -iname HEAD | head -n 1 | sed -e 's/HEAD//'`

tail -f /var/log/cron.log

