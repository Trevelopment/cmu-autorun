#!/bin/sh

# disable watchdog and allow write access
echo 1 > /sys/class/gpio/Watchdog\ Disable/value
mount -o rw,remount /

MYDIR=$(dirname "$(readlink -f "$0")")
CONF_FILE="/data_persist/dev/bin/autorun"
NAME="autorun"

. ${MYDIR}/utils.sh

CMU_SW_VER=$(get_cmu_sw_version)
rm -f "${MYDIR}/AIO_log.txt"

/jci/tools/jci-dialog --3-button-dialog --title="Tweaks Selection for AUTORUN" --text="Choosing Method" --ok-label="Install" --cancel-label="Uninstall" --button3-label="Skip"
choice=$?

if [ "$choice" = '0' ]; then
 msg="Install.."

 if [ -e ${CONF_FILE} ]; then
  # delete empty lines
  sed -i '/^$/ d' ${CONF_FILE}
  sed -i '/#!/ a' ${CONF_FILE}
  if grep -Fq "### ${NAME}" ${CONF_FILE}
   then
    echo "exist"
   else
    cat ${NAME}.temp >> ${CONF_FILE}
  fi
 else
  echo "#!/bin/sh" > ${CONF_FILE}
  cat ${NAME}.temp >> ${CONF_FILE}
 fi
elif [ "$choice" = '1' ]; then
 msg="Uninstall.."
 if [ -e ${CONF_FILE} ]; then
 # delete empty lines
 sed -i '/^$/ d' ${CONF_FILE}
 sed -i '/#!/ a' ${CONF_FILE}
 if grep -Fq "### ${NAME}" ${CONF_FILE}
  then
   t=`cat ${CONF_FILE}.temp`
   sed -i "/### ${NAME}/,/fi/d" ${CONF_FILE}
  else
   echo "Clean"
 fi
 else
  echo "No autorun"
 fi
 
 chmod 755 ${CONF_FILE}
 
 killall jci-dialog
 reboot
else
 msg="Abort.."
 show_message "INSTALLATION ABORTED PLEASE UNPLUG USB DRIVE"
fi

