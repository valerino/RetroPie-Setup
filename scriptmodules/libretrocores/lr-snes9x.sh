#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-snes9x"
rp_module_desc="Super Nintendo emu - Snes9x (current) port for libretro"
rp_module_help="ROM Extensions: .bin .smc .sfc .fig .swc .mgd .zip\n\nCopy your SNES roms to $romdir/snes, $romdir/sufami, $romdir/satellaview, $romdir/snesmsu1, $romdir/sfc"
rp_module_licence="NONCOM https://raw.githubusercontent.com/libretro/snes9x/master/LICENSE"
rp_module_section="opt armv8=main x86=main"

function sources_lr-snes9x() {
    gitPullOrClone "$md_build" https://github.com/libretro/snes9x.git
}

function build_lr-snes9x() {
    local params=()
    isPlatform "arm" && params+=(platform="armv")

    cd libretro
    make "${params[@]}" clean
    # temporarily disable distcc due to segfaults with cross compiler and lto
    DISTCC_HOSTS="" make "${params[@]}"
    md_ret_require="$md_build/libretro/snes9x_libretro.so"
}

function install_lr-snes9x() {
    md_ret_files=(
        'libretro/snes9x_libretro.so'
        'docs'
    )
}

function configure_lr-snes9x() {
    mkRomDir "snes"
    ensureSystemretroconfig "snes"

    mkRomDir "sufami"
    ensureSystemretroconfig "sufami"

    mkRomDir "satellaview"
    ensureSystemretroconfig "satellaview"

    mkRomDir "sfc"
    ensureSystemretroconfig "sfc"

    mkRomDir "snesmsu1"
    ensureSystemretroconfig "snesmsu1"

    local def=0
    ! isPlatform "armv6" && ! isPlatform "armv7" && def=1
    addEmulator $def "$md_id" "snes" "$md_inst/snes9x_libretro.so"
    addSystem "snes"

    addEmulator 1 "$md_id" "sufami" "$md_inst/snes9x_libretro.so"
    addSystem "sufami" "SuFami Turbo" ".smc .sfc .zip"

    addEmulator 1 "$md_id" "satellaview" "$md_inst/snes9x_libretro.so"
    addSystem "satellaview" "SatellaView" ".smc .sfc .zip"

    addEmulator 1 "$md_id" "snesmsu1" "$md_inst/snes9x_libretro.so"
    addSystem "snesmsu1" "SNES MSU-1" ".smc .sfc .zip"

    addEmulator 1 "$md_id" "sfc" "$md_inst/snes9x_libretro.so"
    addSystem "sfc" "Super Famicom" ".smc .sfc .zip"
}
