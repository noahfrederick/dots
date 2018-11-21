#include "my.h"
#include "my_leader.h"
#include "dynamic_macro.h"
#include "private.h"

#ifdef AUDIO_ENABLE
float plover_song[][2]    = SONG(PLOVER_SOUND);
float plover_gb_song[][2] = SONG(PLOVER_GOODBYE_SOUND);
#endif

void matrix_init_user() {
#ifdef STENO_ENABLE
  steno_set_mode(STENO_MODE_GEMINI);
#endif
}

uint32_t layer_state_set_user(uint32_t state) {
  return update_tri_layer_state(state, LOWER_LAYER, RAISE_LAYER, ADJUST_LAYER);
}

// Redefine process_record_keymap() in keymap definitions.
__attribute__ ((weak))
bool process_record_keymap(uint16_t keycode, keyrecord_t *record) {
  return true;
}

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
  if (!process_record_dynamic_macro(keycode, record)) {
    return false;
  }

  if (!process_record_keymap(keycode, record)) {
    return false;
  }

  switch (keycode) {
    case QWERTY:
      if (record->event.pressed) {
        set_single_persistent_default_layer(QWERTY_LAYER);
      }
      return false;
    case COLEMAK:
      if (record->event.pressed) {
        set_single_persistent_default_layer(COLEMAK_LAYER);
      }
      return false;
    case STENO:
      if (record->event.pressed) {
#ifdef AUDIO_ENABLE
        stop_all_notes();
        PLAY_SONG(plover_song);
#endif
        layer_off(RAISE_LAYER);
        layer_off(LOWER_LAYER);
        layer_off(ADJUST_LAYER);
        layer_on(STENO_LAYER);
      }
      return false;
    case STN_EXIT:
      if (record->event.pressed) {
#ifdef AUDIO_ENABLE
        PLAY_SONG(plover_gb_song);
#endif
        layer_off(STENO_LAYER);
      }
      return false;
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

  if (!process_leader(keycode, record)) {
    return false;
  }

  return true;
}

LEADER_DICT {
  LEADER(KC_H, KC_A) {
    SEND_STRING("&amp;");
    return leader_terminate();
  }

  LEADER(KC_H, KC_E) {
    SEND_STRING("&hellip;");
    return leader_terminate();
  }

  LEADER(KC_H, KC_Q) {
    SEND_STRING("&quot;");
    return leader_terminate();
  }

  LEADER(KC_H, KC_SPC) {
    SEND_STRING("&nbsp;");
    return leader_terminate();
  }

  LEADER(KC_H, KC_R) {
    SEND_STRING("&reg;");
    return leader_terminate();
  }

  LEADER(KC_H, KC_T) {
    SEND_STRING("&trade;");
    return leader_terminate();
  }

  LEADER(KC_H, KC_C) {
    SEND_STRING("&copy;");
    return leader_terminate();
  }

  LEADER(KC_H, KC_COMM) {
    SEND_STRING("&lt;");
    return leader_terminate();
  }

  LEADER(KC_H, KC_DOT) {
    SEND_STRING("&gt;");
    return leader_terminate();
  }

  LEADER(KC_H, KC_X) {
    SEND_STRING("&times;");
    return leader_terminate();
  }

#ifdef PRIVATE_MACROS
  LEADER(KC_D, KC_E) {
    SEND_STRING(PRIVATE_DOMAIN_EMAIL);
    return leader_terminate();
  }

  LEADER(KC_D, KC_G) {
    SEND_STRING(PRIVATE_DOMAIN_GENERIC);
    return leader_terminate();
  }

  LEADER(KC_D, KC_P) {
    SEND_STRING(PRIVATE_DOMAIN_PERSONAL);
    return leader_terminate();
  }

  LEADER(KC_D, KC_W) {
    SEND_STRING(PRIVATE_DOMAIN_WORK);
    return leader_terminate();
  }

  LEADER(KC_M, KC_P) {
    SEND_STRING(PRIVATE_EMAIL_PERSONAL);
    return leader_terminate();
  }

  LEADER(KC_M, KC_S) {
    SEND_STRING(PRIVATE_EMAIL_SUPPORT);
    return leader_terminate();
  }

  LEADER(KC_M, KC_W) {
    SEND_STRING(PRIVATE_EMAIL_WORK);
    return leader_terminate();
  }

  LEADER(KC_F, KC_P) {
    SEND_STRING(PRIVATE_FINGERPRINT_PERSONAL);
    return leader_terminate();
  }

  LEADER(KC_F, KC_W) {
    SEND_STRING(PRIVATE_FINGERPRINT_WORK);
    return leader_terminate();
  }

  LEADER(KC_K, KC_P) {
    SEND_STRING(PRIVATE_KEYID_PERSONAL);
    return leader_terminate();
  }

  LEADER(KC_K, KC_W) {
    SEND_STRING(PRIVATE_KEYID_WORK);
    return leader_terminate();
  }

  LEADER(KC_L, KC_B) {
    SEND_STRING(PRIVATE_LINK_BLOG);
    return leader_terminate();
  }

  LEADER(KC_L, KC_D) {
    SEND_STRING(PRIVATE_LINK_DOCS);
    return leader_terminate();
  }

  LEADER(KC_L, KC_K) {
    SEND_STRING(PRIVATE_LINK_KEYMAP);
    return leader_terminate();
  }

  LEADER(KC_L, KC_Q) {
    SEND_STRING(PRIVATE_LINK_QMK);
    return leader_terminate();
  }

  LEADER(KC_P, KC_P) {
    SEND_STRING(PRIVATE_PHONE_PERSONAL);
    return leader_terminate();
  }

  LEADER(KC_P, KC_W) {
    SEND_STRING(PRIVATE_PHONE_WORK);
    return leader_terminate();
  }

  LEADER(KC_U, KC_P) {
    SEND_STRING(PRIVATE_USERNAME_PERSONAL);
    return leader_terminate();
  }

  LEADER(KC_U, KC_W) {
    SEND_STRING(PRIVATE_USERNAME_WORK);
    return leader_terminate();
  }
#endif

  return false;
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
