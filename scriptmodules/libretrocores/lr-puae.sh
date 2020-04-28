#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-puae"
rp_module_desc="P-UAE Amiga emulator port for libretro"
rp_module_help="ROM Extensions: .adf .uae .lha .adz\n\nCopy your roms to $romdir/amiga, $romdir/amigacd32, $romdir/cdtv"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/PUAE/master/COPYING"
rp_module_section="exp"

function sources_lr-puae() {
    gitPullOrClone "$md_build" https://github.com/libretro/libretro-uae.git
}

function build_lr-puae() {
    make
    md_ret_require="$md_build/puae_libretro.so"
}

function install_lr-puae() {
    md_ret_files=(
        'puae_libretro.so'
        'README'
    )
}

## @fn add_amiga_custom_system()
## @param system 'amigacd32' or 'cdtv'
## @param atarisystem 'CD32FR' or 'CDTV'
## @param name system name for es_systems.cfg
## @param ext supported extensions
## @brief sets private lr-puae configuration for amiga cd32 and cdtv
function add_amiga_custom_system() {
    local _system="$1"
    local _amigasystem="$2"
    local _name="$3"
    local _ext="$4"

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
		echo 'puae_model = "CD32FR"'
        if [ "$_amigasystem" = "CD32FR" ]; then
    		echo 'puae_cd32_options = "enabled"'
        fi
    } >> "$_custom_coreconfig"
 	chown $user:$user "$_custom_coreconfig" 
 	chown $user:$user "$_add_config" 
    addEmulator 0 "lr-puae" "$_system" "$md_inst/puae_libretro.so --appendconfig $_add_config"
    addSystem "$_system" "$_name" "$_ext"
}

function configure_lr-puae() {
    mkRomDir "amiga"
    ensureSystemretroconfig "amiga"
    addEmulator 1 "$md_id" "amiga" "$md_inst/puae_libretro.so"
    addSystem "amiga"

    # amiga cd32 via custom core options
    add_amiga_custom_system "amigacd32" "CD32FR" "Amiga CD32" ".adf .lha .adz .cue .zip"

    # amiga cdtv via custom core options
    add_amiga_custom_system "cdtv" "CDTV" "Amiga CDTV" ".adf .lha .adz .cue .zip"
}
