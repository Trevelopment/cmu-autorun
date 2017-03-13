#!/bin/sh
# Screneenshots. By: Trezdog44
# Takes X screenshots over Y Seconds (set in screenshots.conf)
show_message()
{
	sleep 5
	killall jci-dialog
	/jci/tools/jci-dialog --info --title="SCREENSHOTS BRO" --text="$*" --no-cancel &
}
MYDIR=$(dirname "$(readlink -f "$0")")
CONFIGFILE="${MYDIR}/screenshots.conf"
SSGAP=30
NUMSCRNSHOTS=10
DONE_MESSAGE=1
MAX=0
. ${CONFIGFILE}
# echo "=${NUMSCRNSHOTS}= =${SSGAP}= =${DONE_MESSAGE}=" >> ${MYDIR}/sstest.log
sleep 60
if [ "${DONE_MESSAGE}" = "1" ]
then
	show_message "${NUMSCRNSHOTS} SCREENSHOTS"
	sleep 5
	killall jci-dialog
fi
if [ ! -e ${MYDIR}/screenshots ]
then
	mkdir -p ${MYDIR}/screenshots
fi
for i in $(seq 1 $NUMSCRNSHOTS)
do
	/usr/bin/screenshot
	sleep ${SSGAP}
	cp /wayland-screenshot.png ${MYDIR}/screenshots/screenshot${i}.png
	#echo "${MYDIR}/screenshots/screenshot$((i+MAX)).png" >> ${MYDIR}/ss.log
	sleep ${SSGAP}
done
if [ "${DONE_MESSAGE}" = "1" ]
then
	show_message "${NUMSCRNSHOTS} SCREENSHOTS TAKEN"
	sleep 15
	killall jci-dialog
fi

