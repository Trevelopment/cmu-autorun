#!/bin/sh

# disable watchdog and allow write access
echo 1 > /sys/class/gpio/Watchdog\ Disable/value
mount -o rw,remount /

MYDIR=$(dirname "$(readlink -f "$0")")

if [ -e /data_persist/dev/bin/autorun ]; then
 echo "
  /jci/tools/jci-dialog --title="Ready" --text="AUTORUN exist..Abort" --ok-label='OK' --no-cancel
else
 cp -a ${MYDIR}/autorun /data_persist/dev/bin/autorun
 chmod +x /data_persist/dev/bin/autorun
 chown user:user /data_persist/dev/bin/autorun
 /jci/tools/jci-dialog --title="Ready" --text="Activate autorun completed" --ok-label='OK' --no-cancel
fi

mount -o ro,remount /

