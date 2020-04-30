#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-dosbox-svn"
rp_module_desc="DOS emulator (SVN)"
rp_module_help="ROM Extensions: .bat .com .exe .sh\n\nCopy your DOS games to $ROMDIR/pc"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/dosbox-svn/master/COPYING"
rp_module_section="exp"
rp_module_flags=""

function depends_lr-dosbox-svn() {
    getDepends libsdl1.2-dev libsdl-net1.2-dev
}


function sources_lr-dosbox-svn() {
    gitPullOrClone "$md_build" https://github.com/libretro/dosbox-svn.git libretro
}

function build_lr-dosbox-svn() {
    local params=()
    if isPlatform "arm"; then
        if isPlatform "armv6"; then
            params+="WITH_DYNAREC=oldarm"
        else
            params+="WITH_DYNAREC=arm"
        fi
    fi
    cd libretro
    make clean
    make "${params[@]}"
    md_ret_require="$md_build/libretro/dosbox_svn_libretro.so"
    
}

function install_lr-dosbox-svn() {
    md_ret_files=(
        'COPYING'
        'libretro/dosbox_svn_libretro.so'
        'README'
    )
}

function configure_lr-dosbox-svn() {
    mkRomDir "pc"
    ensureSystemretroconfig "pc"

    addEmulator 1 "$md_id" "pc" "$md_inst/dosbox_svn_libretro.so"
    addSystem "pc"
}
