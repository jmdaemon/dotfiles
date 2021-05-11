#!/bin/bash

# qemu-raspbian.sh - Download and create raspbian virtual machines

URL="https://downloads.raspberrypi.org/raspbian/images/"
JIMG=2017-04-10-raspbian-jessie
BIMG=2019-07-10-raspbian-buster
JURL=$URL/raspbian-2017-04-10/$JIMG.zip
BURL=$URL/raspbian-2019-07-12/$BIMG.zip
DIR=$HOME/workspace/qemu_vms
IMG_DIR=$DIR/images
MP=/mnt/raspbian

mkdir -p $DIR && cd $DIR
wget -N - $JURL $BURL 
unzip -u $JIMG.zip $BIMG.zip

git clone https://github.com/dhruvvyas90/qemu-rpi-kernel $DIR/qemu_vms 2> /dev/null || git -C $DIR/qemu-rpi-kernel pull 
jstart=$(sudo fdisk -l $IMG_DIR/$JIMG.img | tail -n -1 | tr -s ' ' | cut -d ' ' -f 2) # Offset: 47185920 (92160 * 512)
bstart=$(sudo fdisk -l $IMG_DIR/$BIMG.img | tail -n -1 | tr -s ' ' | cut -d ' ' -f 2) # Offset: 276824064 (540672 * 512)

sudo mkdir -p {$MP/jessie,$MP/buster}
sudo mount -v -o offset=47185920  -t ext4 $IMG_DIR/$JIMG.img $MP/jessie 
sudo mount -v -o offset=276824064 -t ext4 $IMG_DIR/$BIMG.img $MP/buster 
sudo sed -i -e 's/^/#/' $MP/jessie/etc/ld.so.preload $MP/buster/etc/ld.so.preload

sudo cat $MP/jessie/etc/fstab $MP/buster/etc/fstab  # Check fstab for errors
sudo umount -R $MP
