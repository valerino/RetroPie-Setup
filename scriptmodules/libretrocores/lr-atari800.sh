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
rp_module_help="ROM Extensions: .a52 .bas .bin .car .xex .atr .xfd .dcm .atr.gz .xfd.gz\n\nCopy your Atari800,5200,XEGS games to $romdir/atari800, $romdir/atari5200, $romdir/atarixegs\n\n\You need to copy the Atari 800/5200 BIOS files (5200.ROM, ATARIBAS.ROM, ATARIOSB.ROM and ATARIXL.ROM) to the folder $biosdir"
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

## @fn add_atari_custom_system()
## @param system 'atari5200' or 'atarixegs'
## @param atarisystem '5200' or 'xegs'
## @brief sets private lr-atari800 configuration for atari 5200 or XEGS
function add_atari_custom_system() {
    local _system="$1"
    local _atarisystem="$2"

    # atari 5200 via custom core options
    mkRomDir "$_system"
    ensureSystemretroconfig "$_system"
	local _add_config="$configdir/$_system/retroarch.cfg.add"
	local _custom_coreconfig="$configdir/$_system/retroarch-core-options.cfg"
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
		echo "atari800_system = \""$_atarisystem"\""
    } >> "$_custom_coreconfig"
 	chown $user:$user "$_custom_coreconfig" 
 	chown $user:$user "$_add_config" 
    addEmulator 0 "lr-atari800" "$_system" "$md_inst/atari800_libretro.so --appendconfig $_add_config"
    addSystem "$_system" "Atari XEGS" ".a52 .bas .bin .car .xex .atr .xfd .dcm .atr.gz .xfd.gz"
}

function configure_lr-atari800() {

    # atari 800 is the default
    mkRomDir "atari800"
    ensureSystemretroconfig "atari800"
    mkUserDir "$md_conf_root/atari800"
    moveConfigFile "$home/.lr-atari800.cfg" "$md_conf_root/atari800/lr-atari800.cfg"
    addEmulator 1 "lr-atari800" "atari800" "$md_inst/atari800_libretro.so"
    addSystem "atari800"

    # atari 5200 via custom core options
    add_atari_custom_system "atari5200" "5200"

    # atari XE/GS via custom core options
    add_atari_custom_system "atarixegs" "130XE (128K)"
}

