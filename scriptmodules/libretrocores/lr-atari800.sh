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
## @param name system name for es_systems.cfg
## @param ext supported extensions
## @brief sets private lr-atari800 configuration for atari 5200 or XEGS
function add_atari_custom_system() {
    local _system="$1"
    local _atarisystem="$2"
    local _name="$3"
    local _ext="$4"

    mkRomDir "$_system"
    mkUserDir "$md_conf_root/$_system"
    ensureSystemretroconfig "$_system"
	local _base_config="$configdir/$_system/retroarch.cfg"
	local _custom_coreconfig="$configdir/$_system/retroarch-core-options.cfg"
	rm "$_custom_coreconfig"
	iniConfig " = " "\"" "$_base_config"
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
    addEmulator 0 "lr-atari800" "$_system" "$md_inst/atari800_libretro.so"
    addSystem "$_system" "$_name" "$_ext"
}

function configure_lr-atari800() {

    # atari 800 via custom core options
    add_atari_custom_system "atari800" "800XL (64K)" "Atari 800" ".a52 .bas .bin .car .xex .atr .xfd .dcm .atr.gz .xfd.gz" 

    # atari 5200 via custom core options
    add_atari_custom_system "atari5200" "5200" "Atari 5200" ".a52 .bas .bin .car .xex .atr .xfd .dcm .atr.gz .xfd.gz" 

    # atari XE/GS via custom core options
    add_atari_custom_system "atarixegs" "130XE (128K)" "Atari XEGS" ".a52 .bas .bin .car .xex .atr .xfd .dcm .atr.gz .xfd.gz" 
}

