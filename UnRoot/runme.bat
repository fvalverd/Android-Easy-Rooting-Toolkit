@echo ---------------------------------------------------------------
@echo	              Easy rooting toolkit (v4.0)
@echo                    created by DooMLoRD
@echo         using exploit zergRush (Revolutionary Team)
@echo    Credits go to all those involved in making this possible!
@echo ---------------------------------------------------------------
@echo  [*] This script will:
@echo      (1) root ur device using latest zergRush exploit (21 Nov)
@echo      (2) install Busybox (1.18.4)
@echo      (3) install SU files (binary: 3.0.3 and apk: 3.0.6)
@echo      (4) some checks for free space, tmp directory 
@echo          (will remove Google Maps if required)
@echo  [*] Before u begin:   
@echo      (1) make sure u have installed adb drivers for ur device
@echo      (2) enable "USB DEBUGGING" 
@echo            from (Menu\Settings\Applications\Development)
@echo      (3) enable "UNKNOWN SOURCES"
@echo            from (Menu\Settings\Applications)
@echo      (4) [OPTIONAL] increase screen timeout to 10 minutes
@echo      (5) connect USB cable to PHONE and then connect to PC
@echo      (6) skip "PC Companion Software" prompt on device
@echo ---------------------------------------------------------------
@echo  CONFIRM ALL THE ABOVE THEN 
@pause
@echo --- STARTING ----
@echo --- WAITING FOR DEVICE
@files\adb wait-for-device
@echo --- creating temporary directory
@files\adb shell "cd /data/local && mkdir tmp"
@echo --- cleaning
@files\adb shell "cd /data/local/tmp/ && rm *"
@echo --- pushing zergRush
@files\adb push files\zergRush /data/local/tmp/.
@echo --- correcting permissions
@files\adb shell "chmod 777 /data/local/tmp/zergRush"
@echo --- executing zergRush
@files\adb shell "./data/local/tmp/zergRush"
@echo --- WAITING FOR DEVICE TO RECONNECT
@echo if it gets stuck over here for a long time then try:
@echo    disconnect usb cable and reconnect it
@echo    toggle "USB DEBUGGING" (first disable it then enable it)
@files\adb wait-for-device
@echo --- DEVICE FOUND
@echo --- pushing busybox
@files\adb push files\busybox /data/local/tmp/.
@echo --- correcting permissions
@files\adb shell "chmod 755 /data/local/tmp/busybox"
@echo --- remounting /system
@files\adb shell "/data/local/tmp/busybox mount -o remount,rw /system"
@echo --- checking free space on /system
@files\adb push files\makespace /data/local/tmp/.
@files\adb shell "chmod 777 /data/local/tmp/makespace"
@files\adb shell "./data/local/tmp/makespace"
@echo --- copying busybox to /system/xbin/
@files\adb shell "dd if=/data/local/tmp/busybox of=/system/xbin/busybox"
@echo --- correcting ownership
@files\adb shell "chown root.shell /system/xbin/busybox"
@echo --- correcting permissions
@files\adb shell "chmod 04755 /system/xbin/busybox"
@echo --- installing busybox
@files\adb shell "/system/xbin/busybox --install -s /system/xbin"
@files\adb shell "rm -r /data/local/tmp/busybox"
@echo --- pushing SU binary
@files\adb push files\su /system/bin/su
@echo --- correcting ownership
@files\adb shell "chown root.shell /system/bin/su"
@echo --- correcting permissions
@files\adb shell "chmod 06755 /system/bin/su"
@echo --- correcting symlinks
@files\adb shell "rm /system/xbin/su"
@files\adb shell "ln -s /system/bin/su /system/xbin/su"

@echo --- pushing Superuser app
@files\adb push files\Superuser.apk /system/app/.
@echo --- cleaning
@files\adb shell "cd /data/local/tmp/; rm *"
@echo --- rebooting
@files\adb reboot
@echo ALL DONE!!!
@pause