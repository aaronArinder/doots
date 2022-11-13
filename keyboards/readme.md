### basic setup
- clone `qmk/qmk_firmware`
- use the `shell.nix` from that repo
- go make a sandwich or something because the above might take a super long time
- `qmk setup -H external-code/qmk_firmware` if you (me) still use `external-code` for this stuff; otherwise, use `-H <wherver-qmk_firmware-is>`
- test build env: `qmk compile -kb <keyboard|keebio/nyquist/rev3> -km default`

### creating a keymap
- [VIA](usevia.app) is great; same for [qmk configurator](https://config.qmk.fm/#/keebio/nyquist/rev3/LAYOUT)
- make updates
- download json
- `qmk json2c <blah.json> > keymap.c`
- create a new directory in the qmk_firmware nyquist directory under `keymaps` called whatever you like, e.g., `harry`
- cp the `default` directory
- replace the `keymap.c` from the default directory with your `keymap.c`
- `make keebio/nyquist/rev3:harry` to test compilation

### flashing board
- WIP
- if using VIA, ezpz


resources:
- [build env for qmk](https://docs.qmk.fm/#/getting_started_build_tools)
- [custom keymaps](https://docs.qmk.fm/#/newbs_building_firmware)
- [flashing: putting into bootloader mode](https://docs.qmk.fm/#/newbs_flashing)
- [makefile options](https://docs.qmk.fm/#/getting_started_make_guide)
