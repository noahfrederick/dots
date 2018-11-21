#pragma once

// This is a hack to allow dynamic macros in user space. QMK's implementation
// is in the header file, so it can't be included more than once, even though
// both this file and the keymap file need to include it. The keymap only needs
// these constants.
enum dynamic_macro_keycodes_keymap {
  DYN_REC_START1 = DYNAMIC_MACRO_RANGE,
  DYN_REC_START2,
  DYN_REC_STOP,
  DYN_MACRO_PLAY1,
  DYN_MACRO_PLAY2,
};

