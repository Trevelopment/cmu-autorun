#!/bin/sh

MYDIR="/tmp/mnt/sd_nav"

export LD_LIBRARY_PATH="${MYDIR}/headunit_libs:/jci/lib:/jci/opera/3rdpartylibs/freetype:/usr/lib/imx-mm/audio-codec:/usr/lib/imx-mm/parser:/data_persist/dev/lib:"
#override some GST plugins with these
export GST_PLUGIN_PATH="${MYDIR}/headunit_libs"

log_message()
{
        echo "$*" 1>2
        echo "$*" >> "${MYDIR}/AIO_log.txt"
        /bin/fsync "${MYDIR}/AIO_log.txt"
}

show_message()
{
        sleep 5
        killall jci-dialog
        /jci/tools/jci-dialog --info --title="MESSAGE" --text="$*" --no-cancel &
}

taskset 0xFFFFFFFF "${MYDIR}/headunit" "$@" 2>&1 | tee ${MYDIR}/log/headunit.log 2>&1 >/dev/null &
sleep 3

check_headunit=`pidof headunit`
if [ -z "${check_headunit}" ]
then
   show_message "Headunit failed. Check the log."
   sleep 5
   killall jci-dialog
   exit
else
 if ! [ -e ${MYDIR}/log/first_run ]
 then
   show_message "Android Auto Started"
   killall jci-dialog
   show_message "This message display only first time"
   touch ${MYDIR}/log/first_run
   ${MYDIR}/headunit --version >> "${MYDIR}/AIO_log.txt"
 fi
fi

sleep 5  
killall jci-dialog
