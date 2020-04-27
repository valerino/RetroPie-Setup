#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-mess-ti99"
rp_module_name="TI-99/4A Home Computer"
rp_module_ext=".rpk"
rp_module_desc="MESS emulator ($rp_module_name) - MESS Port for libretro"
rp_module_help="ROM Extensions: $rp_module_ext\n\n
Put games in:\n
  $romdir/ti99\n\n
Put BIOS file in $biosdir:\n
  ti99_4a.zip (US/EU)\n
  ti99_evpc.zip (EVPC)\n
  ti99_speech.zip (Speech Module)\n\n
For the TI-99/4A, MESS requires .rpk files, which are renamed ZIP files. They contain cartridge memory dumps and a layout.xml file, which informs the MESS which file belongs to which part of memory."

rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/mame/master/LICENSE.md"
rp_module_section="exp"
rp_module_flags=""

function depends_lr-mess-ti99() {
	local _mess=$(dirname "$md_inst")/lr-mess/mess_libretro.so
	if [[ ! -f "$_mess" ]]; then
		printMsgs dialog "cannot find '$_mess' !\n\nplease install 'lr-mess' package."
		exit 1
	fi
}

function sources_lr-mess-ti99() {
	true
}

function build_lr-mess-ti99() {
	true
}

function install_lr-mess-ti99() {
	true
}

function configure_lr-mess-ti99() {
	local _mess=$(dirname "$md_inst")/lr-mess/mess_libretro.so
	local _retroarch_bin="$rootdir/emulators/retroarch/bin/retroarch"
	local _system="ti99"
	local region
	local regions=(_4a _4ae _4ev)
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
	for region in "${regions[@]}"; do
		addEmulator 1 "$md_id${region}" "$_system" "$_script $_retroarch_bin $_mess $_config ti99$region $biosdir -ioport peb -ioport:peb:slot3 speech -nat -joy -cart1 %ROM%"
	done

	# add system to es_systems.cfg as normal
	addSystem "$_system" "$md_name" "$md_ext"
}
