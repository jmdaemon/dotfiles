#!/bin/bash

VMS=$HOME/workspace/qemu_vms/ 
BUSTER=2019-07-10-raspbian-buster
JESSIE=2017-04-10-raspbian-jessie
BUSTER_KERNEL=kernel-qemu-4.19.50-buster
JESSIE_KERNEL=kernel-qemu-4.4.34-jessie

start_buster_vm() {
qemu-system-aarch64 \ 
    -kernel "$VMS/qemu-rpi-kernel/$BUSTER_KERNEL" \
    -cpu arm1176 \
    -m 256 \
    -M versatilepb \
    -serial stdio \
    -append "root=/dev/sda2 rootfstype=ext4 rw" \
    -hda "$VMS/images/$BUSTER.img" \
    -dtb $HOME/qemu_vms/qemu-rpi-kernel/versatile-pb.dtb \
    -net user,hostfwd=tcp::5022-:22 \
    -no-reboot
}

start_jessie_vm() { 
    #qemu-system-arm \ 
        #-kernel "$VMS/qemu-rpi-kernel/$JESSIE_KERNEL" \ 
        #-cpu arm1176 \ 
        #-m 256 \ 
        #-M versatilepb \ 
        #-serial stdio \ 
        #-append "root=/dev/sda2 rootfstype=ext4 rw" \ 
        #-hda "$VMS/images/$JESSIE.img" \ 
        #-nic user,hostfwd=tcp::5022-:22 \ 
        #-no-reboot
sudo qemu-system-arm \
    -kernel $DIR/qemu-rpi-kernel/$JESSIE_KERNEL \
    -cpu arm1176 \
    -m 256 \
    -M versatilepb \
    -serial stdio \
    -append "root=/dev/sda2 rootfstype=ext4 rw" \
    -hda $DIR/images/raspbian.img \
    -nic user,hostfwd=tcp::5022-:22
}

show_usage() {
    echo "Usage: rpi-vm [code_name]"
    echo "      -j, --jessie     Launch raspbian jessie virtual machine"
    echo "      -b, --buster     Launch raspbian buster virtual machine"
    echo ""
}

if [[ -z $1 ]];then 
    show_usage
elif [[ $1 == "-j" || $1 == "--jessie" ]]; then
    start_jessie_vm
elif [[ $1 == "-b" || $1 == "--buster" ]]; then
    start_buster_vm
else
    show_usage
fi
