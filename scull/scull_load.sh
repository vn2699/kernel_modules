#!/bin/bash

module="scull"
device="scull"
mode="644"

/sbin/insmod ./$module.ko $* || exit 1

rm -f /dev/${device}[0-3]

major=$(awk "\$2==\"$module\" {print \$1}" /proc/devices)
echo $major

mknod /dev/${device}0 c $major 0
mknod /dev/${device}1 c $major 1
mknod /dev/${device}2 c $major 2
mknod /dev/${device}3 c $major 3

group="staff"
grep -q "^staff:" /etc/group || group="wheel"

chgrp $group /dev/${device}[0-3]
chmod $mode /dev/${device}[0-3]

rm -f /dev/${device}pipe[0-3]
mknod /dev/${device}pipe0 c $major 4
mknod /dev/${device}pipe1 c $major 5
mknod /dev/${device}pipe2 c $major 6
mknod /dev/${device}pipe3 c $major 7
#ln -sf ${device}pipe0 /dev/${device}pipe
chgrp $group /dev/${device}pipe[0-3] 
chmod $mode  /dev/${device}pipe[0-3]
 
rm -f /dev/${device}single
mknod /dev/${device}single  c $major 8
chgrp $group /dev/${device}single
chmod $mode  /dev/${device}single
 
rm -f /dev/${device}uid
mknod /dev/${device}uid   c $major 9
chgrp $group /dev/${device}uid
chmod $mode  /dev/${device}uid
 
rm -f /dev/${device}wuid
mknod /dev/${device}wuid  c $major 10
chgrp $group /dev/${device}wuid
chmod $mode  /dev/${device}wuid
 
rm -f /dev/${device}priv
mknod /dev/${device}priv  c $major 11
chgrp $group /dev/${device}priv
chmod $mode  /dev/${device}priv
