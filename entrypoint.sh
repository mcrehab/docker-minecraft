#!/bin/sh

su minecraft -c "sh vncserver-ctl &"

/usr/sbin/xrdp-sesman --nodaemon &
/usr/sbin/xrdp --nodaemon &
/home/minecraft/novnc/noVNC-1.2.0/utils/launch.sh --vnc localhost:5901 > /var/log/nonvc.log

sleep 3

tail -f /var/log/*.log
