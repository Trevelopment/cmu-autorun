#!/bin/sh
MYDIR=$(dirname "$(readlink -f "$0")")
CONFIGFILE="${MYDIR}/screenshots.conf"
SDDIR="/tmp/mnt/sd_nav/"
SSGAP=30
NUMSCRNSHOTS=10
DONE_MESSAGE=0
. ${CONFIGFILE}
# echo "=${NUMSCRNSHOTS}= =${SSGAP}= =${DONE_MESSAGE}=" >> ${MYDIR}/sstest.log
sleep 60
if [ ! -e ${SDDIR}/screenshots ]
then
	mkdir -p ${SDDIR}/screenshots
fi
for i in $(seq 1 $NUMSCRNSHOTS)
do
	/usr/bin/screenshot
	sleep ${SSGAP}
	cp /wayland-screenshot.png ${SDDIR}/screenshots/screenshot${i}.png
	sleep ${SSGAP}
done
if [ ${DONE_MESSAGE} = 1 ]
then
	killall jci-dialog
	/jci/tools/jci-dialog --info --title="AIO-SCREENSHOTS" --text="${NUMSCRNSHOTS} SCREENSHOTS TAKEN" --no-cancel &
	sleep 3
	killall jci-dialog
fi
exit
