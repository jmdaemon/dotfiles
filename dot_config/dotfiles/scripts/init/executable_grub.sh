#!/bin/bash

## https://wiki.archlinux.org/index.php/GRUB
WALLPAPER=$HOME/backgrounds/mbjtwkC.png
FONT=/boot/grub/fonts/DejaVuSansMono36.pf2
DEFAULT_GRUB=/etc/default/grub

make_bigger_font() {
    sudo grub2-mkfont -s 36 -o $FONT /usr/share/fonts/dejavu/DejaVuSansMono.ttf
}

customize_default_grub() {
    sed -i 's,GRUB_BACKGROUND.*,GRUB_BACKGROUND='"$WALLPAPER"',' "$DEFAULT_GRUB"    # Change bootloader background
    if [[ ! -z $FONT ]]; then make_bigger_font; else :; fi                          # Make font if not generated
    sed -i 's,GRUB_FONT.*,GRUB_FONT='"$FONT"',' "$DEFAULT_GRUB"                     # Change bootloader font
}

create_custom_grub_cfg() {
    echo "
    menuentry \"System Shutdown\" {
      echo "System shutting down..."
      halt
    }

    menuentry \"System Restart\" {
      echo "System rebooting..."
      reboot
    }

    if [ ${grub_platform} == \"efi\" ]; then
      menuentry \"Firmware Setup\" {
        fwsetup
      }
    fi
    " | sudo tee /boot/grub/custom.cfg
} 

customize_default_grub
create_custom_grub_cfg
