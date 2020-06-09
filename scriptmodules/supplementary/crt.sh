#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="crt"
rp_module_desc="Configure CRT options"
rp_module_section="config"
#rp_module_flags="!x86 !mali"

function depends_crt() {
    true
}

function reboot_func() {
    if [[ "$1" = "0" ]]; then
        clear
        reboot
    fi
}

function gui_crt() {
    local cmd=(dialog --backtitle "$__backtitle" --menu "Set CRT mode (needs reboot)" 22 86 16)
    local options=(
        1 "NTSC 4:3P"
        2 "NTSC 4:3P - Overscan scaled"
        3 "PAL 4:3P"
        4 "PAL 4:3P - Overscan scaled"
        5 "HDMI 240p 60hz (no CRT)"
    )
    choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    if [[ -n "$choice" ]]; then
        case "$choice" in
            1)
                cp "$scriptdir/scriptmodules/supplementary/config.crt.ntsc" /boot/config.txt
				rm /home/pi/retrovpie/opt/retropie/configs
				rm /home/pi/retrovpie/retroarch/config
				ln -s /home/pi/retrovpie/opt/retropie/configs.crt /home/pi/retrovpie/opt/retropie/configs
				ln -s /home/pi/retrovpie/retroarch/config.hdmi /home/pi/retrovpie/retroarch/config
                dialog --defaultno --yesno "Set to NTSC 4:3P 60hz. Reboot ?" 22 76 2>&1 >/dev/tty
                reboot_func "$?"
                ;;
            2)
                cp "$scriptdir/scriptmodules/supplementary/config.crt.ntsc.scale_overscan" /boot/config.txt
				rm /home/pi/retrovpie/opt/retropie/configs
				rm /home/pi/retrovpie/retroarch/config
				ln -s /home/pi/retrovpie/opt/retropie/configs.crt /home/pi/retrovpie/opt/retropie/configs
				ln -s /home/pi/retrovpie/retroarch/config.crt /home/pi/retrovpie/retroarch/config
                dialog --defaultno --yesno "Set to NTSC 4:3P 60hz (Overscan scaled). Reboot ?" 22 76 2>&1 >/dev/tty
                reboot_func "$?"
                ;;
            3)
                cp "$scriptdir/scriptmodules/supplementary/config.crt.pal" /boot/config.txt
				rm /home/pi/retrovpie/opt/retropie/configs
				rm /home/pi/retrovpie/retroarch/config
				ln -s /home/pi/retrovpie/opt/retropie/configs.crt /home/pi/retrovpie/opt/retropie/configs
				ln -s /home/pi/retrovpie/retroarch/config.crt /home/pi/retrovpie/retroarch/config
                dialog --defaultno --yesno "Set to PAL 4:3P 50hz. Reboot ?" 22 76 2>&1 >/dev/tty
                reboot_func "$?"
                ;;
            4)
                cp "$scriptdir/scriptmodules/supplementary/config.crt.pal.scale_overscan" /boot/config.txt
				rm /home/pi/retrovpie/opt/retropie/configs
				rm /home/pi/retrovpie/retroarch/config
				ln -s /home/pi/retrovpie/opt/retropie/configs.crt /home/pi/retrovpie/opt/retropie/configs
				ln -s /home/pi/retrovpie/retroarch/config.crt /home/pi/retrovpie/retroarch/config
                dialog --defaultno --yesno "Set to PAL 4:3P 50hz (Overscan scaled). Reboot ?" 22 76 2>&1 >/dev/tty
                reboot_func "$?"
                ;;
            5)
                cp "$scriptdir/scriptmodules/supplementary/config.hdmi" /boot/config.txt
				rm /home/pi/retrovpie/opt/retropie/configs
				rm /home/pi/retrovpie/retroarch/config
				ln -s /home/pi/retrovpie/opt/retropie/configs.hdmi /home/pi/retrovpie/opt/retropie/configs
				ln -s /home/pi/retrovpie/retroarch/config.hdmi /home/pi/retrovpie/retroarch/config
                dialog --defaultno --yesno "Set to HDMI 1080p (no CRT). Reboot ?" 22 76 2>&1 >/dev/tty
                reboot_func "$?"
                ;;
        esac
    fi
}

