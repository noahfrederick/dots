#include "my.h"

// Redefine process_record_keymap() in keymap definitions.
__attribute__ ((weak))
bool process_record_keymap(uint16_t keycode, keyrecord_t *record) {
  return true;
}

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
  if (!process_record_keymap(keycode, record)) {
    return false;
  }

  switch (keycode) {
    case SEND_VERSION:
      if (record->event.pressed) {
        SEND_STRING(QMK_KEYBOARD "/" QMK_KEYMAP "@" QMK_VERSION " (" QMK_BUILDDATE ")");
      }
      return false;
    case SEND_MAKE:
      if (record->event.pressed) {
        SEND_STRING("make " QMK_KEYBOARD ":" QMK_KEYMAP
#if (defined(BOOTLOADER_DFU) || defined(BOOTLOADER_LUFA_DFU) || defined(BOOTLOADER_QMK_DFU))
            ":dfu"
#elif defined(BOOTLOADER_HALFKAY)
            ":teensy"
#elif defined(BOOTLOADER_CATERINA)
            ":avrdude"
#endif
            SS_TAP(X_ENTER));
      }
      return false;
  }

  return true;
}

#ifdef COMBO_ENABLE
enum combo_events {
  MY_COMBO_AND,
  MY_COMBO_MAK,
  MY_COMBO_THE,
  MY_COMBO_TIO,
  MY_COMBO_WHI,
  MY_COMBO_WOU,
  MY_COMBO_YOU,
};

const uint16_t PROGMEM combo_and[] = { KC_A, KC_N, COMBO_END };
const uint16_t PROGMEM combo_mak[] = { KC_M, KC_K, COMBO_END };
const uint16_t PROGMEM combo_the[] = { KC_T, KC_H, COMBO_END };
const uint16_t PROGMEM combo_tio[] = { KC_I, KC_O, COMBO_END };
const uint16_t PROGMEM combo_whi[] = { KC_W, KC_C, COMBO_END };
const uint16_t PROGMEM combo_wou[] = { KC_L, KC_D, COMBO_END };
const uint16_t PROGMEM combo_you[] = { KC_Y, KC_U, COMBO_END };

combo_t key_combos[COMBO_COUNT] = {
  [MY_COMBO_AND] = COMBO_ACTION(combo_and),
  [MY_COMBO_MAK] = COMBO_ACTION(combo_mak),
  [MY_COMBO_THE] = COMBO_ACTION(combo_the),
  [MY_COMBO_TIO] = COMBO_ACTION(combo_tio),
  [MY_COMBO_WHI] = COMBO_ACTION(combo_whi),
  [MY_COMBO_WOU] = COMBO_ACTION(combo_wou),
  [MY_COMBO_YOU] = COMBO_ACTION(combo_you),
};

void process_combo_event(uint8_t combo_index, bool pressed) {
  switch(combo_index) {
    case MY_COMBO_AND:
      if (pressed) {
        SEND_STRING("and ");
      }
      break;
    case MY_COMBO_MAK:
      if (pressed) {
        SEND_STRING("make ");
      }
      break;
    case MY_COMBO_THE:
      if (pressed) {
        SEND_STRING("the ");
      }
      break;
    case MY_COMBO_TIO:
      if (pressed) {
        SEND_STRING("tion ");
      }
      break;
    case MY_COMBO_WHI:
      if (pressed) {
        SEND_STRING("which ");
      }
      break;
    case MY_COMBO_WOU:
      if (pressed) {
        SEND_STRING("would ");
      }
      break;
    case MY_COMBO_YOU:
      if (pressed) {
        SEND_STRING("you ");
      }
      break;
  }
}
#endif
