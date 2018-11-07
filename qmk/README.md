# QMK Firmware

The [QMK firmware][qmk] powers my keyboards.
This is the source code for my keyboard layouts.

    .
    ├── README.md
    ├── Rakefile       # Tasks for managing QMK source
    ├── planck         # Keyboard/keymap-specific files
    │   ├── README.md
    │   ├── keymap.c   # Keymap implementation
    │   └── rules.mk   # Keymap make rules
    ├── ...
    └── user           # Keyboard/keymap-agnostic files
        ├── README.md
        ├── config.h   # Configuration applied across all keymaps
        ├── my.c       # Global implementation file
        ├── my.h       # Global header file
        └── rules.mk   # Global make rules

[qmk]: https://github.com/qmk/qmk_firmware

## Building

The `Rakefile` assumes the QMK source is located at `$CODE/qmk_firmware`.

    rake clean      # Remove build artifacts
    rake install    # Symlink keymap files into QMK source tree
    rake pull       # Update QMK firmware
    rake uninstall  # Remove symlinks from QMK source tree
