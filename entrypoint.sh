#!/bin/sh

/usr/sbin/xrdp-sesman --nodaemon &
/usr/sbin/xrdp --nodaemon &

sleep 3

tail -f /var/log/*.log
