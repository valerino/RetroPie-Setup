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
        6 "Merge configurations: HDMI -> CRT"
        7 "Merge configurations: CRT -> HDMI"
        8 "Copy configurations: HDMI -> CRT"
        9 "Copy configurations: CRT -> HDMI"
    )
    choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    if [[ -n "$choice" ]]; then
        case "$choice" in
            1)
                cp "$scriptdir/scriptmodules/supplementary/config.crt.ntsc" /boot/config.txt
                rm -f "$configdir"
                ln -s "$configdir.crt" "$configdir"
		chown $user:$user "$configdir"
                dialog --defaultno --yesno "Set to NTSC 4:3P 60hz. Reboot ?" 22 76 2>&1 >/dev/tty
                reboot_func "$?"
                ;;
            2)
                cp "$scriptdir/scriptmodules/supplementary/config.crt.ntsc.scale_overscan" /boot/config.txt
                rm -f "$configdir"
                ln -s "$configdir.crt" "$configdir"
		chown $user:$user "$configdir"
                dialog --defaultno --yesno "Set to NTSC 4:3P 60hz (Overscan scaled). Reboot ?" 22 76 2>&1 >/dev/tty
                reboot_func "$?"
                ;;
            3)
                cp "$scriptdir/scriptmodules/supplementary/config.crt.pal" /boot/config.txt
                rm -f "$configdir"
                ln -s "$configdir.crt" "$configdir"
		chown $user:$user "$configdir"
                dialog --defaultno --yesno "Set to PAL 4:3P 50hz. Reboot ?" 22 76 2>&1 >/dev/tty
                reboot_func "$?"
                ;;
            4)
                cp "$scriptdir/scriptmodules/supplementary/config.crt.pal.scale_overscan" /boot/config.txt
                rm -f "$configdir"
                ln -s "$configdir.crt" "$configdir"
		chown $user:$user "$configdir"
                dialog --defaultno --yesno "Set to PAL 4:3P 50hz (Overscan scaled). Reboot ?" 22 76 2>&1 >/dev/tty
                reboot_func "$?"
                ;;
            5)
                cp "$scriptdir/scriptmodules/supplementary/config.hdmi" /boot/config.txt
                rm -f "$configdir"
                ln -s "$configdir.hdmi" "$configdir"
		chown $user:$user "$configdir"
                dialog --defaultno --yesno "Set to HDMI 1080p (no CRT). Reboot ?" 22 76 2>&1 >/dev/tty
                reboot_func "$?"
                ;;
            6)
                dialog --defaultno --yesno "Warning: all existing CRT configurations will be MERGED (overwrites existing + adds missing) with HDMI configurations. Continue ?" 22 76 2>&1 >/dev/tty
                if [[ "$?" = "0" ]]; then
                    cp -RL "$configdir.hdmi/*" "$configdir.crt"
                fi
                ;;
            7)
                cp -RL "$configdir.crt/*" "$configdir.hdmi"
                dialog --defaultno --yesno "Warning: all existing HDMI configurations will be MERGED (overwrites existing + adds missing) with CRT configurations. Continue ?" 22 76 2>&1 >/dev/tty
                if [[ "$?" = "0" ]]; then
                    cp -RL "$configdir.crt/*" "$configdir.hdmi"
                fi
                ;;
            8)
                dialog --defaultno --yesno "Warning: all existing CRT configurations will be REPLACED (delete existing first) with HDMI configurations. Continue ?" 22 76 2>&1 >/dev/tty
                if [[ "$?" = "0" ]]; then
                    rm -rf "$configdir.crt"
                    cp -RL "$configdir.hdmi" "$configdir.crt"
                fi
                ;;
            9)
                dialog --defaultno --yesno "Warning: all existing HDMI configurations will be REPLACED (delete existing first) with CRT configurations. Continue ?" 22 76 2>&1 >/dev/tty
                if [[ "$?" = "0" ]]; then
                    rm -rf "$configdir.hdmi"
                    cp -RL "$configdir.crt" "$configdir.hdmi"
                fi
                ;;

        esac
    fi
}

