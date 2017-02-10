#!/bin/sh

# Disable watchdog
echo 1 > /sys/class/gpio/Watchdog\ Disable/value

# Set environment
DIR=$(dirname $(readlink -f $0))
PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin

# Log all stdout/stderr to file
exec > $DIR/installer.log 2>&1

# Stop firewall
/jci/scripts/jci-fw.sh stop

# Start WiFiAP
killall wpa_supplicant
/jci/scripts/jci-fw.sh stop
/jci/scripts/jci-wifiap.sh start

iptables -A INPUT -p tcp --dport 7777 -j ACCEPT

# Start sshd on port 7777 using our public key
/usr/sbin/sshd -D -p 7777 -o "AuthorizedKeysFile ${DIR}/mazda-ssh.pub" -o "StrictModes no" &

