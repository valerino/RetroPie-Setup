#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-atari800"
rp_module_desc="Atari 8-bit/800/5200 emulator - Atari800 port for libretro"
rp_module_help="ROM Extensions: .a52 .bas .bin .car .xex .atr .xfd .dcm .atr.gz .xfd.gz\n\nCopy your Atari800 games to $romdir/atari800\n\nCopy your Atari 5200 roms to $romdir/atari5200 You need to copy the Atari 800/5200 BIOS files (5200.ROM, ATARIBAS.ROM, ATARIOSB.ROM and ATARIXL.ROM) to the folder $biosdir"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/libretro-atari800/master/atari800/COPYING"
rp_module_section="main"

function sources_lr-atari800() {
    gitPullOrClone "$md_build" https://github.com/libretro/libretro-atari800.git
}

function build_lr-atari800() {
    make clean
    CFLAGS+=" -DDEFAULT_CFG_NAME=\\\".lr-atari800.cfg\\\"" make
    md_ret_require="$md_build/atari800_libretro.so"
}

function install_lr-atari800() {
    md_ret_files=(
        'atari800_libretro.so'
        'atari800/COPYING'
    )
}

function configure_lr-atari800() {
    mkRomDir "atari800"
    mkRomDir "atari5200"

    ensureSystemretroconfig "atari800"
    ensureSystemretroconfig "atari5200"

    mkUserDir "$md_conf_root/atari800"
    moveConfigFile "$home/.lr-atari800.cfg" "$md_conf_root/atari800/lr-atari800.cfg"

    # 800 is the default, handle 5200 separately with a custom core-options
	_add_config="$configdir/atari5200/retroarch.cfg.add"
	_custom_coreconfig="$configdir/atari5200/retroarch-core-options.cfg"
	rm "$_add_config"
	rm "$_custom_coreconfig"
	iniConfig " = " "\"" "$_add_config"
	iniSet "core_options_path" "$_custom_coreconfig"
    {
		echo 'atari800_artifacting = "enabled"'
		echo 'atari800_cassboot = "disabled"'
		echo 'atari800_internalbasic = "disabled"'
		echo 'atari800_keyboard = "poll"'
		echo 'atari800_ntscpal = "NTSC"'
		echo 'atari800_opt1 = "disabled"'
		echo 'atari800_opt2 = "disabled"'
		echo 'atari800_resolution = "336x240"'
		echo 'atari800_sioaccel = "enabled"'
		echo 'atari800_system = "5200"'
    } >> "$_custom_coreconfig"

    addEmulator 1 "lr-atari800" "atari800" "$md_inst/atari800_libretro.so"
    addEmulator 0 "lr-atari800" "atari5200" "$md_inst/atari800_libretro.so --appendconfig $_add_config"
    addSystem "atari800"
    addSystem "atari5200"
}

