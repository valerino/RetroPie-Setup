#!/usr/bin/env bash
# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="sdl2trs"
rp_module_desc="Radio Shack TRS-80 Model I/III/4/4P emulator"
rp_module_help="ROM Extension: .dsk\n\nCopy your TRS-80 games to $romdir/trs-80\n\nCopy the required BIOS file level2.rom, model3.rom, model4.rom or model4p.rom to $biosdir/trs-80\n\nOptionally, you may copy DOS disks to $biosdir/trs-80 as well to autload DOS when using -dosload versions of the emulator: newdos.dsk for model 1, and lddos.dsk for model3/4/4p."
rp_module_section="exp"
rp_module_flags="dispmanx !mali"

function depends_sdl2trs() {
    getDepends libreadline-dev libsdl2-dev
}

function sources_sdl2trs() {
    gitPullOrClone "$md_build" https://gitlab.com/jengun/sdltrs sdl2
}

function build_sdl2trs() {
    cd src
    make clean
    make sdl2
    md_ret_require="$md_build/src/sdl2trs"
}

function install_sdl2trs() {
    md_ret_files=(
        'src/sdl2trs'
    )
}

function configure_sdl2trs() {
    mkRomDir "trs-80"

    addEmulator 1 "$md_id-model1" "trs-80" "$md_inst/sdl2trs -scanlines -model 1 -romfile $biosdir/trs-80/level2.rom -diskdir $romdir/trs-80 -disk0 %ROM%"
    addEmulator 0 "$md_id-model3" "trs-80" "$md_inst/sdl2trs -scanlines -model 3 -romfile3 $biosdir/trs-80/model3.rom -diskdir $romdir/trs-80 -disk0 %ROM%"
    addEmulator 0 "$md_id-model4" "trs-80" "$md_inst/sdl2trs -scanlines -model 4 -romfile3 $biosdir/trs-80/model4.rom -diskdir $romdir/trs-80 -disk0 %ROM%"
    addEmulator 0 "$md_id-model4p" "trs-80" "$md_inst/sdl2trs -scanlines -model 4p -romfile4p $biosdir/trs-80/model4p.rom -diskdir $romdir/trs-80 -disk0 %ROM%"
    addEmulator 0 "$md_id-model1-dosload" "trs-80" "$md_inst/sdl2trs -scanlines -model 1 -romfile $biosdir/trs-80/level2.rom -diskdir $romdir/trs-80 -disk0 $biosdir/trs-80/newdos.dsk -disk1 %ROM%"
    addEmulator 0 "$md_id-model3-dosload" "trs-80" "$md_inst/sdl2trs -scanlines -model 3 -romfile3 $biosdir/trs-80/model3.rom -diskdir $romdir/trs-80 -disk0 $biosdir/trs-80/lddos.dsk -disk1 %ROM%"
    addEmulator 0 "$md_id-model4-dosload" "trs-80" "$md_inst/sdl2trs -scanlines -model 4 -romfile3 $biosdir/trs-80/model4.rom -diskdir $romdir/trs-80 -disk0 $biosdir/trs-80/lddos.dsk -disk1 %ROM%"
    addEmulator 0 "$md_id-model4p-dosload" "trs-80" "$md_inst/sdl2trs -scanlines -model 4p -romfile4p $biosdir/trs-80/model4p.rom -diskdir $romdir/trs-80 -disk0 $biosdir/trs-80/lddos.dsk -disk1 %ROM%"
    addSystem "trs-80"

    [[ "$md_mode" == "remove" ]] && return

}
