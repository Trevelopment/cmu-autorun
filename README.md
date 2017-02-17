http://mazda3revolution.com/forums/1280610-post1532.html

#### IMPORTANT: All changes happen at your own risk!
##### This tools have no protection. Anyone who is unsure should leave it alone, ask someone with experience to help or ask in the forum.
##### I am not responsible for damages that may incur from the use.

# cmu-autorun
MZD CMU SDCard apps for recovery
This apps activate only boot process. 

## Instruction

1. Activate `autorun` by USB installer or write from yourself.
2. copy example script from `sdcard` directory. 

* autorun

```bash
#!/bin/sh
# /data_persist/dev/bin/autorun
echo 1 > /sys/class/gpio/Watchdog\ Disable/value
sleep 40
if [ -e /mnt/sd_nav/run.sh ]
then
  sh /mnt/sd_nav/run.sh
fi
```


Example : Select file from `dryrun`. Copy `run.sh` to SDCard. After reboot cmu display will show "AUTORUN Activated"
