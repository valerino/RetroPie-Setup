# Improvements over upstream

These are the improvements to the original upstream repo (which i try to keep this fork in sync with) you can find in this fork:

## CONFIGURATION MENU

* CRT/HDMI: provides autoconfiguration of HDMI or CRT/PAL/NTSC outputs, needs reboot. this currently needs my [retrovpie configuration](https://github.com/valerino/retrovpie) to work correctly.
  
## STANDALONE EMULATORS

* beebem: BBC Micro, no fullscreen and no sound
* gsplus: Apple II/GS
* sdl2trs: TRS-80, provided by the author Jens Guenther

## LIBRETROCORES (ADDED)

* lr-vice-x128:Commodore 128
* lr-vice-xpet: Commodore PET
* lr-vice-xplus4: Commodore Plus4
* lr-vice-xvic: Commodore Vic20

## LIBRETROCORES (ADDED/IMPROVED/FIXED)

* lr-atari800: added Atari XEGS (atarixegs) as separate system.
* lr-beetle-supergrafx: changed id/folder to 'sgfx' to correctly match most themes.
* lr-bluemsx: added MSX-2 (msx2), MSX-2+ (msx2plus), MSX-TurboR (msxturbo) as separate systems. For msxturbo the corresponding option in the retroarch's quick-menu must be set.
* lr-dosbox-svn: MS/DOS, more onpar with upstream dosbox.
* lr-mgba: added Super Gameboy (sgb) as separate system.
* lr-neocd: changed id/folder to 'neocdz' to correctly match most themes.
* lr-ppsspp: Sony PSP, added Minis (pspminis) as separate systems.
* lr-puae: Commodore Amiga, added CD32 (amigacd32), CDTV (cdtv) as separate systems.
* lr-snes9x: Nintendo SNES, added Sufami Turbo (sufami), Satellaview (satellaview), MSU-1 (snesmsu1), Super Famicom (sfc) as separate systems.
* lr-theodore: uses mo5, to8 directories to differentiate different systems.

## MESS SYSTEMS

the following are all dependent on installing lr-mess first, as described here: https://retropie.org.uk/forum/post/217275

__NOTE__: the following scripts allows utilizing the specified systems through MESS allowing to load games directly from the frontend. Inner working of the emulator cores and emulation details are MESS related and not depending on these scripts themself (i.e. if some core do not work correctly, try to upgrade lr-mess first).

* lr-mess-adam: Coleco Adam
* lr-mess-advision: Entex AdventureVision
* lr-mess-apfm1000: APF M1000 The Imagination Machine
* lr-mess-apple: Apple I
* lr-mess-apple2: Apple II/E
* lr-mess-apple2gs: Apple II GS
* lr-mess-arcadia: Emerson Arcadia 2001
* lr-archimedes: Acorn Archimedes (partially working)
* lr-mess-astrocade: Bally Astrocade
* lr-mess-bbcmicro: BBC Model B (overrides runcommand.sh, read https://retropie.org.uk/forum/post/217553)
* lr-mess-cdi: Philips CD-i
* lr-mess-coco: Tandy Color Computer
* lr-mess-crvision: VTech Creativision
* lr-mess-dragon32: Dragon 32
* lr-mess-electron: Acorn Electron (overrides runcommand.sh, read https://retropie.org.uk/forum/post/217553)
* lr-mess-fm7: Fujitsu FM7
* lr-mess-gamepock: Epoch Gamepocket Computer
* lr-mess-gx4000: Amstrad GX-4000
* lr-mess-m5: Sord M5
* lr-mess-mo5: Thomson MO5
* lr-mess-megaduck: Mega Duck
* lr-mess-multivision: Othello Multivision
* lr-mess-mz700: Sharp MZ700
* lr-mess-oric: Oric Atmos (contributed by @roslof)
* lr-mess-pv1000: Casio PV-1000
* lr-mess-pv2000: Casio PV-2000
* lr-mess-samcoupe: MGT Sam Coupé
* lr-mess-sc3000: Sega SC-3000
* lr-mess-scv: Epoch Super Cassette Vision (just needs to map joypad correctly)
* lr-mess-svi318: Spectravideo 318/328
* lr-mess-supervision: Watara Supervision
* lr-mess-ti99: Texas Instrument TI/994A (contributed by @roslof)
* lr-mess-to8: Thomson TO8 (no sound)
* lr-mess-trs-80: Tandy TRS-80 Model 3
* lr-mess-vectrex: GCE Vectrex (contributed by @roslof)
* lr-mess-vc4000: Interton VC4000 (partially working)
* lr-mess-vg5000: Philips VG-5000
