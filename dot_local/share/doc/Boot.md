# Boot

A handy document reference for Boot recovery.
Included are instructions for repairing the Grub boot loader,
booting from the Grub shell, using custom Grub fonts in your configuration,
and repairing the Windows Bootloader.

## Booting From Grub Shell

Requirements:
- The EFI system partition must not be corrupted.
- The EFI boot files themselves must be available and in good working condition.

### Windows

```grub
insmod part_gpt
insmod chain
set root=(hd0,gpt1)
chainloader /EFI/Microsoft/Boot/bootmgfw.efi
boot
```

- Replace `(hd0,gpt1)` with whatever equivalent `(drive,partition)` your Windows
installation is on.

### Linux

Booting a Linux distribution from the grub shell is more or less similar:

```grub
insmod part_gpt
insmod linux
insmod normal
set root=(hd0,gpt1)
normal
```

- Replace `(hd0,gpt1)` with whatever equivalent `(drive,partition)` your Linux
distribution is on.

In more advanced cases you may have to load the Linux kernel:

```grub
set root=(hd0,gpt1)
linux /boot/vmlinuz-$VERSION$-generic root=/dev/sda1
initrd /boot/initrd.img-$VERSION$-generic
boot
```

- Replace `$VERSION$` with the versions you have available in `/boot`
- `/dev/sda1` Corresponds to your root file system. You can find this by using `ls`
    and remembering the mapping:
    - `(hd0,1)`: `/dev/sda1`
    - `(hd1,1)`: `/dev/sdb1`

### Grub Shell Notes

- Grub Shell supports `ls`, use this to double check which drive you're booting from.
- Grub shell also supports tab completion.
- You can omit the `gpt1`, `msdos1` labels and directly use them: `1` instead of `gpt1`.

## Repairing Grub Boot Loader / Repairing Linux EFI Partitions

To repair grub, we more or less go through the entire process of installing grub
to the boot partition again.

Requirements:

- GParted Live USB or any other Live USB equivalent.

To repair, boot up GParted, open up the terminal and run:

``` bash
# Mount system partitions
sudo mount /dev/[your root partition] /mnt
sudo mount /dev/[your home partition] /mnt/home
sudo mount /dev/[your boot partition] /mnt/boot
# Bind necessary live usb partitions required for grub
sudo mount --bind /dev /mnt/dev &&
sudo mount --bind /dev/pts /mnt/dev/pts &&
sudo mount --bind /proc /mnt/proc &&
sudo mount --bind /sys /mnt/sys
# [Required for UEFI partitions] Mount efivarfs
sudo mount -t efivarfs efivarfs /mnt/sys/firmware/efi/efivars
sudo chroot /mnt
```

Once you're chrooted into the system, if you're on arch linux then you need to run:

``` bash
sudo pacman -S linux
```

To install linux to the boot partition.

Then install grub bootloader to the boot partition:

``` bash
sudo grub-install --target=x86_64-efi \
                  --efi-directory=/boot \
                  --bootloader-id=arch \
                  --recheck
```

### Generating Custom Grub Fonts

To generate custom grub fonts (and grub fonts of bigger sizes) for your grub config, you can run:

``` bash

sudo grub-mkfont /usr/share/fonts/TTF/DejaVuSansMono.ttf \
            -s 20 -o /boot/grub/fonts/DejaVuSansMono20.pf2
```

### Custom boot menu entries

To add custom boot menu entries, you can put your files in `/etc/grub.d/40_custom` or in
`/boot/grub/custom.cfg`.

### Building the Grub Config

Now you can build the grub config files with:

``` bash
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

Now you can boot up to your favorite distribution.

## Repairing Windows Boot Partition

### Requirements

- Windows Live USB

Boot up into your Windows Live USB, open up the Command Prompt and run:

``` ps
bootrec.exe /FixBoot
bootrec.exe /RebuildBcd
```
