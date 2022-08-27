# Recover

## Reparing Grub Boot Loader / Repairing Linux EFI Partitions

To repair grub, we more or less go through the entire process of installing grub
to the boot partition again.

### Requirements

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

#### Generating Custom Grub Fonts

To generate custom grub fonts (and grub fonts of bigger sizes) for your grub config, you can run:

``` bash

sudo grub-mkfont /usr/share/fonts/TTF/DejaVuSansMono.ttf \
            -s 20 -o /boot/grub/fonts/DejaVuSansMono20.pf2
```

#### Custom boot menu entries

To add custom boot menu entries, you can put your files in `/etc/grub.d/40_custom` or in
`/boot/grub/custom.cfg`.

#### Building the Grub Config

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
