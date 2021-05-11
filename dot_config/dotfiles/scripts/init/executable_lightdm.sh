#!/bin/bash


## https://wiki.archlinux.org/title/LightDM

WEBKIT2_GREETER=lightdm-webkit2-greeter
LIGHTDM_CONF=/etc/lightdm/lightdm.conf
#TEST="test.lightdm-webkit2"

setup_lightdm_gtk() {
    echo "
    [greeter]
    theme-name = Flat-Remix-GTK-Red-Darker
    icon-theme-name = Flat-Remix-Red-Dark
    font-name = Sans 13
    background = /usr/share/pixmaps/Firewatch.jpg
    clock-format = %a - %m/%d/%y - %H:%M - %I:%M%p
    xft.dpi = 220
    xft-antialias = true
    xft-dpi = 150
    xft-rgba = rgb
    xft-hintstyle = hintfull

    " | sudo tee /etc/lightdm/lightdm-gtk-greeter.conf
}

setup_lightdm_webkit2() {
    sed -i 's,greeter-session.*,greeter-session='"$GREETER"',' "$LIGHTDM_CONF"  # Change login greeter to webkit2
    sed -i -e '/^\[VNCServer\]/,+7 d' "$LIGHTDM_CONF"                           # Delete some lines
    echo '
    [VNCServer]
    enabled=false
    command=Xvnc
    port=5900
    #listen-address=
    width=1920
    height=1080
    depth=8
    ' | sudo tee -a $LIGHTDM_CONF > /dev/null # Apply VNC settings
}

show_usage() {
    echo "Usage: lightdm.sh [greeter]"
    echo "  --gtk,          Add customizations to lightdm-gtk-greeter"
    echo "  --webkit2,      Add customizations to lightdm-webkit2-greeter"
    echo ""
}

if [[ -z $1 ]]; then
  show_usage
elif [[ $1 == "--gtk" ]]; then
    setup_lightdm_gtk
elif [[ $! == "--webkit2" ]]; then
    setup_lightdm_webkit2
else 
    show_usage
fi
