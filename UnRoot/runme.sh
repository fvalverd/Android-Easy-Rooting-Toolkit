ADB_CMD=/home/fvalverd/Android/android-sdk-linux_x86/platform-tools/adb

echo "---------------------------------------------------------------"
echo "                Easy rooting toolkit (v4.0)"
echo "                   created by DooMLoRD"
echo "        using exploit zergRush (Revolutionary Team)"
echo "   Credits go to all those involved in making this possible!"
echo "---------------------------------------------------------------"
echo " [*] This script will:"
echo "     (1) root ur device using latest zergRush exploit (21 Nov)"
echo "     (2) install Busybox (1.18.4)"
echo "     (3) install SU files (binary: 3.0.3 and apk: 3.0.6)"
echo "     (4) some checks for free space, tmp directory"
echo "         (will remove Google Maps if required)"
echo " [*] Before u begin:"
echo "     (1) make sure u have installed adb drivers for ur device"
echo "     (2) enable \"USB DEBUGGING\""
echo "           from (Menu/Settings/Applications/Development)"
echo "     (3) enable \"UNKNOWN SOURCES\""
echo "           from (Menu/Settings/Applications)"
echo "     (4) [OPTIONAL] increase screen timeout to 10 minutes"
echo "     (5) connect USB cable to PHONE and then connect to PC"
echo "     (6) skip \"PC Companion Software\" prompt on device"
echo "---------------------------------------------------------------"

echo ""
read -p "Press [Enter] AFTER TO CONFIRM ALL THE ABOVE..."
echo ""

echo "--- STARTING ----"
echo "--- WAITING FOR DEVICE"
$ADB_CMD wait-for-device

# temporary directory
echo ""
echo "--- creating temporary directory"
$ADB_CMD shell "cd /data/local && mkdir tmp"
echo "--- cleaning /data/local/tmp/"
$ADB_CMD shell "cd /data/local/tmp/ && rm *"


# zergRush
echo ""
echo "--- pushing zergRush"
$ADB_CMD push ./files/zergRush "/data/local/tmp/."
echo "  --- correcting permissions"
$ADB_CMD shell "chmod 777 /data/local/tmp/zergRush"
echo "  --- executing zergRush"
$ADB_CMD shell "./data/local/tmp/zergRush"
echo "  --- WAITING FOR DEVICE TO RECONNECT"
echo "if it gets stuck over here for a long time then try:"
echo "disconnect usb cable and reconnect it"
echo "toggle \"USB DEBUGGING\" (first disable it then enable it)"
$ADB_CMD wait-for-device
echo "  --- DEVICE FOUND"

# busybox
echo ""
echo "--- pushing busybox"
$ADB_CMD push ./files/busybox "/data/local/tmp/."
echo "  --- correcting permissions"
$ADB_CMD shell "chmod 755 /data/local/tmp/busybox"
echo "  --- remounting /system"
$ADB_CMD shell "/data/local/tmp/busybox mount -o remount,rw /system"
echo "  --- checking free space on /system"
echo "    --- pushing makespace"
$ADB_CMD push ./files/makespace /data/local/tmp/.
echo "    --- correcting permissions"
$ADB_CMD shell "chmod 777 /data/local/tmp/makespace"
echo "    --- executing makespace"
$ADB_CMD shell "/data/local/tmp/makespace"
echo "  --- copying busybox to /system/xbin/"
$ADB_CMD shell "dd if=/data/local/tmp/busybox of=/system/xbin/busybox"
echo "  --- correcting ownership of /system/xbin/busybox"
$ADB_CMD shell "chown root.shell /system/xbin/busybox"
echo "  --- correcting permissions of /system/xbin/busybox"
$ADB_CMD shell "chmod 04755 /system/xbin/busybox"
echo "  --- installing busybox"
$ADB_CMD shell "/system/xbin/busybox --install -s /system/xbin"
$ADB_CMD shell "rm -r /data/local/tmp/busybox"

# su
echo ""
echo "--- pushing SU binary"
$ADB_CMD push ./files/su /system/bin/su
echo "  --- correcting ownership"
$ADB_CMD shell "chown root.shell /system/bin/su"
echo "  --- correcting permissions"
$ADB_CMD shell "chmod 06755 /system/bin/su"
echo "  --- correcting symlinks"
$ADB_CMD shell "rm /system/xbin/su"
$ADB_CMD shell "ln -s /system/bin/su /system/xbin/su"

# Superuser app
echo ""
echo "--- pushing Superuser app"
$ADB_CMD push ./files/Superuser.apk "/system/app/."

echo ""
echo "--- cleaning /data/local/tmp/"
$ADB_CMD shell "cd /data/local/tmp/; rm *"
echo "--- rebooting"
$ADB_CMD reboot
echo "ALL DONE!!!"