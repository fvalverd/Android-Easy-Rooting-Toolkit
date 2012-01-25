@echo ---------------------------------------------------------------
@echo	              Easy rooting toolkit (v1.0)
@echo	                  UNROOTING SCRIPT
@echo                  created by DooMLoRD
@echo   based heavily on FlashTool scripts (by Bin4ry and Androxyde)
@echo    Credits go to all those involved in making this possible!
@echo ---------------------------------------------------------------
@echo  [*] This script will:
@echo      (1) unroot ur device using special script
@echo      (2) remove Busybox and assocaited symlinks
@echo      (3) remove SU files and assocaiated data
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
@echo ---------------------------------------------------------------
@echo  MAKE SURE THAT THE SCREEN IS UNLOCKED 
@echo  and if you get Superuser prompts ACCEPT/ALLOW THEM 
@echo  ELSE THIS WILL NOT WORK
@echo ---------------------------------------------------------------
@pause
@echo --- STARTING ----
@echo --- WAITING FOR DEVICE
@files\adb wait-for-device
@echo --- TESTING FOR SU PERMISSIONS
@echo  MAKE SURE THAT THE SCREEN IS UNLOCKED 
@echo  and if you get Superuser prompts ACCEPT/ALLOW THEM 
@echo  ELSE THIS WILL NOT WORK
@files\adb shell "su -c 'echo --- Superuser check successful'"
@echo --- cleaning
@files\adb shell "cd /data/local/tmp/; rm *"
@echo --- pushing busybox
@files\adb push files\busybox /data/local/tmp/.
@echo --- correcting permissions
@files\adb shell "chmod 755 /data/local/tmp/busybox"
@echo --- remounting /system
@echo  MAKE SURE THAT THE SCREEN IS UNLOCKED 
@echo  and if you get Superuser prompts ACCEPT/ALLOW THEM 
@echo  ELSE THIS WILL NOT WORK
@files\adb shell "su -c '/data/local/tmp/busybox mount -o remount,rw /system'"
@echo --- pushing unroot script
@files\adb push files\unroot /data/local/tmp/.
@echo --- correcting permissions
@files\adb shell "chmod 777 /data/local/tmp/unroot"
@echo --- executing unroot
@echo  MAKE SURE THAT THE SCREEN IS UNLOCKED 
@echo  and if you get Superuser prompts ACCEPT/ALLOW THEM 
@echo  ELSE THIS WILL NOT WORK
@files\adb shell "su -c '/data/local/tmp/unroot'"
@echo --- cleaning
@files\adb shell "cd /data/local/tmp/; rm *"
@echo --- rebooting
@files\adb reboot
@echo ALL DONE!!!
@pause