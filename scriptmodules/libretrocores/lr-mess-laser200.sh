#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-mess-laser200"
rp_module_name="VTech Laser 200"
rp_module_ext=".vz"
rp_module_desc="MESS emulator ($rp_module_name) - MESS Port for libretro"
rp_module_help="ROM Extensions: $rp_module_ext\n\n
Put games in:\n
$romdir/laser200\n\n
Put BIOS files in $biosdir:\n
laser200.zip\n\n
How to load games:\n
http://www.progettoemma.net/mess/system.php?machine=laser200500"

rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/mame/master/LICENSE.md"
rp_module_section="exp"
rp_module_flags=""

function depends_lr-mess-laser200() {
	local _mess=$(dirname "$md_inst")/lr-mess/mess_libretro.so
	if [[ ! -f "$_mess" ]]; then
		printMsgs dialog "cannot find '$_mess' !\n\nplease install 'lr-mess' package."
		exit 1
	fi
}

function sources_lr-mess-laser200() {
	true
}

function build_lr-mess-laser200() {
	true
}

function install_lr-mess-laser200()  {
	true
}

function configure_lr-mess-laser200() {
	local _mess=$(dirname "$md_inst")/lr-mess/mess_libretro.so
	local _retroarch_bin="$rootdir/emulators/retroarch/bin/retroarch"
	local _system="laser200"
	local _config="$configdir/$_system/retroarch.cfg"
	local _add_config="$_config.add"
	local _custom_coreconfig="$configdir/$_system/custom-core-options.cfg"
	local _script="$scriptdir/scriptmodules/run_mess.sh"

	# create retroarch configuration
	ensureSystemretroconfig "$_system"

	# ensure it works without softlists, using a custom per-fake-core config
    iniConfig " = " "\"" "$_custom_coreconfig"
    iniSet "mame_softlists_enable" "disabled"
	iniSet "mame_softlists_auto_media" "disabled"
	iniSet "mame_boot_from_cli" "disabled"

	# this will get loaded too via --append_config
	iniConfig " = " "\"" "$_add_config"
	iniSet "core_options_path" "$_custom_coreconfig"
	#iniSet "save_on_exit" "false"

	# set permissions for configurations
 	chown $user:$user "$_custom_coreconfig" 
 	chown $user:$user "$_add_config" 

	# setup rom folder
	mkRomDir "$_system"

	# ensure run_mess.sh script is executable
	chmod 755 "$_script"

	# add the emulators.cfg as normal, pointing to the above script
	addEmulator 0 "$md_id-snapshot" "$_system" "$_script $_retroarch_bin $_mess $_config laser210 $biosdir -dump %ROM%"
	addEmulator 0 "$md_id-cass" "$_system" "$_script $_retroarch_bin $_mess $_config laser210 $biosdir -cass %ROM%"

	# add system to es_systems.cfg as normal
	addSystem "$_system" "$md_name" "$md_ext"
}
