http://mazda3revolution.com/forums/2014-2016-mazda-3-skyactiv-audio-electronics/57714-infotainment-project-584.html

autorun

#!/bin/sh
# Disable watchdog
echo 1 > /sys/class/gpio/Watchdog\ Disable/value
# Set environment
DIR=$(dirname $(readlink -f $0))
PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin
/jci/scripts/jci-fw.sh stop
/usr/sbin/sshd -D -p 7777 -o "AuthorizedKeysFile /tmp/data_persist/mazda-ssh.pub" -o "StrictModes no" 

# อธิบาย
เฟิร์มแวร์ 56.00.513 เปลี่ยนแปลงการล๊อคอิน ทำให้วิธีที่เคยทำได้กับ 56.00.100/230/240 ใช้ไม่ได้ใน 513 สรุปที่เปลี่ยนไปมีดังนี้
* ใช้ SSH ผ่าน WiFi ไม่ได้
* เปลี่ยน username, password ของ root ทำให้ล๊อคอิน ผ่านทาง USB-to-Ethernet / Serial-to-USB ไม่ได้ 

สรุปคือ ถ้าเป็นเฟิร์มแวร์ 56.00.513 จะล๊อคอินเข้าเครื่อง cmu ไม่ได้ ดังนั้นถ้า CMU ยังทำงานได้แนะนำให้ติดตั้ง SSH_bringback เพื่อเปิดพอร์ท TCP:22 และเพิ่มให้ root ใช้งานได้เหมือนเวอร์ชั่นก่อน   

แต่ถ้ายังไม่ติดตั้ง SSH_bringback แล้วเครื่องหน้าจอค้าง และ USB ใช้งานไม่ได้

สรุปปัญหา

* uninstall ผ่าน USB ไม่ได้ 
* remote ด้วย SSH ไม่ได้
* ใช้ usb-to-ethernet ไม่ได้ 

เหลือทางเลือกเดียว เชื่อมด้วย USB-to-Serial (TTL 3.3V) เชื่อว่าถึงขั้นนี้ท่านน่าจะมี ชื่อผู้ใช้/รหัสผ่าน สำหรับล๊อคอิน CMU เฟิร์มแวร์ 56.00.513 แต่จะพบปัญหาที่ชื่อผู้ใช้ที่มีนั้นไม่ใช่สิทธิ์ root ทำให้ใช้คำสั่ง `mount -o rw,remount /` ไม่ได้ 

