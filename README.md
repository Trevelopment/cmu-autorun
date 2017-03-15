# cmu-autorun
### MZD CMU SDCard apps for recovery and testing
### This script is activated during the boot process.

<http://mazda3revolution.com/forums/1280610-post1532.html>
___

#### IMPORTANT: All changes happen at your own risk! **This tool has no protection.**
##### Anyone who is unsure should leave it alone, ask someone with experience to help or ask in the forum.
##### I am not responsible for damages that may incur from the use.
___

## Instructions

1. Download the `autorun` script. You can modify it or re-write one yourself.
2. Install by USB installer.
3. Copy the example script from `sdcard/dryrun/` directory onto your SD card.
4. Insert SD into vehicle, script will run automatically on the next CMU boot.
5. Some scripts produce logs or images, after the script is completed remove SD card and review files on another device.
6. Allow each script to finish completely.  Scripts that are cut short may cause the CMU to freeze, this can be fixed with a hard reset.  
 - Hard Reset - Hold: BACK + NAV + VOL/MUTE for 20 seconds.

# autorun

```bash
#!/bin/sh
# cmu-autorun - executed during the boot process
# /data_persist/dev/bin/autorun
echo 1 > /sys/class/gpio/Watchdog\ Disable/value
sleep 40
if [ -e /mnt/sd_nav/run.sh ]
then
  sh /mnt/sd_nav/run.sh
fi
```


Test : Copy the file `sdcard/dryrun/run.sh` onto the root of your SDCard. Reboot the CMU and a display will show "AUTORUN ACTIVATED!"

## Current Scripts:

### [dryrun](sdcard/dryrun) - For Initial test

### [hedunit](sdcard/headunit)

### [memory-log](sdcard/memory-log)

### [screenshots](sdcard/screenshots)

### [temporary-ssh-access](sdcard/temporary-ssh-access)

### [WifiAP-Toggle](sdcard/WifiAP-Toggle)
