#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-theodore"
rp_module_desc="Thomson MO/TO system emulator"
rp_module_help="ROM Extensions: *.fd, *.sap, *.k7, *.m5, *.m7, *.rom\n\nAdd your game files in $romdir/moto"
rp_module_licence="GPL3 https://raw.githubusercontent.com/libretro/theodore/master/LICENSE"
rp_module_section="exp"
rp_module_flags=""

function sources_lr-theodore() {
    gitPullOrClone "$md_build" https://github.com/Zlika/theodore
}

function build_lr-theodore() {
    make clean
    make
    md_ret_require="theodore_libretro.so"
}

function install_lr-theodore() {
    md_ret_files=(
        'theodore_libretro.so'
        'README.md'
        'README-FR.md'
        'LICENSE'
    )
}

function configure_lr-theodore() {
    mkRomDir "moto"
	mkRomDir "mo5"
	mkRomDir "to8"
    ensureSystemretroconfig "moto"
	ensureSystemretroconfig "mo5"
	ensureSystemretroconfig "to8"

    addEmulator 0 "$md_id" "moto" "$md_inst/theodore_libretro.so"
    addSystem "moto"


    addEmulator 0 "$md_id-mo5" "mo5" "$md_inst/theodore_libretro.so"
    addSystem "mo5"


    addEmulator 0 "$md_id-to8" "to8" "$md_inst/theodore_libretro.so"
    addSystem "to8"
}
