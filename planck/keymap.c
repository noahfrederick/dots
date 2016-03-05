#include "keymap_common.h"
#include "action_tapping.h"
#include "timer.h"

// Keymap layers
#define BASE_QWERTY_LAYER 0
#define BASE_COLEMAK_LAYER 1
#define LOWER_LAYER 2
#define RAISE_LAYER 3
#define NAVIGATION_LAYER 4
#define GUI_LAYER 5
#define KEYBOARD_LAYER 6

// Modifier-delimiter hold-tap macros
#define LSFT_PAREN 0
#define RSFT_PAREN 1
#define LHYP_ANGLE 2
#define RHYP_ANGLE 3
#define LALT_BRACE 4
#define RALT_BRACE 5

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
  /* Base layer (Qwerty)
   *                ,-----------------------------------------------------------------------.
   *                | Tab | Q   | W   | E   | R   | T   | Y   | U   | I   | O   | P   | Fn5 | -- Tap for '
   *                |-----------------------------------------------------------------------|
   * Tap for Esc -- |Ctrl | A   | S   | D   | F   | G   | H   | J   | K   | L   |; Fn4|Ctrl | -- Tap for Enter
   *                |-----------------------------------------------------------------------|
   *   Tap for ( -- |Shift| Z   | X   | C   | V   | B   | N   | M   | ,   | .   | /   |Shift| -- Tap for )
   *                |-----------------------------------------------------------------------|
   *   Tap for [ -- | Fn3 |Hyper| Alt |Super| Fn1 |   Space   | Fn2 |Super| Alt |Hyper| Fn3 | -- Tap for ]
   *                `-----------------------------------------------------------------------'
   *                        /     /                                         /     /
   *   Tap for < > --------'---- / --------------------------------------- / ----'
   *     Tap for { } -----------'-----------------------------------------'
   */
  [BASE_QWERTY_LAYER] = {
    {KC_TAB,        KC_Q,          KC_W,          KC_E,    KC_R, KC_T,   KC_Y,   KC_U, KC_I,    KC_O,          KC_P,          F(6)},
    {F(10),         KC_A,          KC_S,          KC_D,    KC_F, KC_G,   KC_H,   KC_J, KC_K,    KC_L,          F(2),          F(11)},
    {M(LSFT_PAREN), KC_Z,          KC_X,          KC_C,    KC_V, KC_B,   KC_N,   KC_M, KC_COMM, KC_DOT,        KC_SLSH,       M(RSFT_PAREN)},
    {F(4),          M(LHYP_ANGLE), M(LALT_BRACE), KC_LGUI, F(0), KC_SPC, KC_SPC, F(1), KC_RGUI, M(RALT_BRACE), M(RHYP_ANGLE), F(5)}
  },
  /* Base layer (Colemak)
   *                ,-----------------------------------------------------------------------.
   *                |     | Q   | W   | F   | P   | G   | J   | L   | U   | Y   | ;   |     |
   *                |-----------------------------------------------------------------------|
   *                |     | A   | R   | S   | T   | D   | H   | N   | E   | I   |O Fn4|     |
   *                |-----------------------------------------------------------------------|
   *                |     | Z   | X   | C   | V   | B   | K   | M   |     |     |     |     |
   *                |-----------------------------------------------------------------------|
   *                |     |     |     |     |     |           |     |     |     |     |     |
   *                `-----------------------------------------------------------------------'
   */
  [BASE_COLEMAK_LAYER] = {
    {KC_TRNS, KC_Q,    KC_W,    KC_F,    KC_P,    KC_G,    KC_J,    KC_L,    KC_U,    KC_Y,    KC_SCLN, KC_TRNS},
    {KC_TRNS, KC_A,    KC_R,    KC_S,    KC_T,    KC_D,    KC_H,    KC_N,    KC_E,    KC_I,    F(3),    KC_TRNS},
    {KC_TRNS, KC_Z,    KC_X,    KC_C,    KC_V,    KC_B,    KC_K,    KC_M,    KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS},
    {KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS}
  },
  /* Numeric layer
   *                ,-----------------------------------------------------------------------.
   * Application -- |D-Grv| F1  | F2  | F3  | F4  | F5  | F6  | F7  | F8  | F9  | F10 |     |
   *      window    |-----------------------------------------------------------------------|
   *    switcher    |     | 1   | 2   | 3   | 4   | 5   | 6   | 7   | 8   | 9   | 0   |     |
   *                |-----------------------------------------------------------------------|
   *                |     | -   | =   | `   | \   | a   | b   | c   | d   | e   | f   |     |
   *                |-----------------------------------------------------------------------|
   *                |     |     |     |     |     | Backspace |     |     |     |     |     |
   *                `-----------------------------------------------------------------------'
   */
  [LOWER_LAYER] = {
    {LGUI(KC_GRV), KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,   KC_F6,   KC_F7,   KC_F8,   KC_F9,   KC_F10,  KC_TRNS},
    {KC_TRNS,      KC_1,    KC_2,    KC_3,    KC_4,    KC_5,    KC_6,    KC_7,    KC_8,    KC_9,    KC_0,    KC_TRNS},
    {KC_TRNS,      KC_MINS, KC_EQL,  KC_GRV,  KC_BSLS, KC_A,    KC_B,    KC_C,    KC_D,    KC_E,    KC_F,    KC_TRNS},
    {KC_TRNS,      KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_BSPC, KC_BSPC, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS}
  },
  /* Symbol layer
   *                ,-----------------------------------------------------------------------.
   *                |     | F11 | F12 | F13 | F14 | F15 | F16 | F17 | F18 | F19 | F20 |     |
   *                |-----------------------------------------------------------------------|
   *                |     | !   | @   | #   | $   | %   | ^   | &   | *   | '   | "   |     | \
   *                |-----------------------------------------------------------------------|  |-- Mostly shifted version
   *                |     | _   | +   | ~   | |   |     |ndash|mdash|     |     |     |     | /    of lower layer
   *                |-----------------------------------------------------------------------|
   *                |     |     |     |     |     |  Delete   |     |     |     |     |     |
   *                `-----------------------------------------------------------------------'
   */
  [RAISE_LAYER] = {
    {KC_TRNS, KC_F11,  KC_F12,  KC_F13,  KC_F14,  KC_F15,  KC_F16,        KC_F17,           KC_F18,  KC_F19,  KC_F20,     KC_TRNS},
    {KC_TRNS, S(KC_1), S(KC_2), S(KC_3), S(KC_4), S(KC_5), S(KC_6),       S(KC_7),          S(KC_8), KC_QUOT, S(KC_QUOT), KC_TRNS},
    {KC_TRNS, KC_UNDS, KC_PLUS, KC_TILD, KC_PIPE, KC_NO,   LALT(KC_MINS), S(LALT(KC_MINS)), KC_NO,   KC_NO,   KC_NO,      KC_TRNS},
    {KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_DEL,  KC_DEL,        KC_TRNS,          KC_TRNS, KC_TRNS, KC_TRNS,    KC_TRNS}
  },
  /* Directional navigation layer
   *
   *         Large movements -----/```````````````````\   /```````````````````\----- Vim-style arrow keys
   *                ,-----------------------------------------------------------------------.
   *                |     |     |     |     |     |     |     |     |     |     |     |     |
   *                |-----------------------------------------------------------------------|
   *                |     |     |Home |PgUp |PgDn | End |Left |Down | Up  |Right|     |     |
   *                |-----------------------------------------------------------------------|
   *                |     |     |     |     |     |     |     |     |     |     |     |     |
   *                |-----------------------------------------------------------------------|
   *                |     |     |     |     |     |           |     |     |     |     |     |
   *                `-----------------------------------------------------------------------'
   */
  [NAVIGATION_LAYER] = {
    {KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,  KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO},
    {KC_TRNS, KC_NO,   KC_HOME, KC_PGUP, KC_PGDN, KC_END, KC_LEFT, KC_DOWN, KC_UP,   KC_RGHT, F(2),    KC_TRNS},
    {KC_TRNS, KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,  KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_TRNS},
    {KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_NO,   KC_NO,  KC_NO,   KC_NO,   KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS}
  },
  /* GUI (window management/mouse/media controls) layer
   *
   *        Mouse keys -----/```````````````````\               /```````````````````\----- Window manager
   *                ,-----------------------------------------------------------------------.
   *                |     |Ms B2|Ms Up|Ms B1|Ms WD|     |     |Prev | TL  | Top | TR  |     |
   *                |-----------------------------------------------------------------------|
   *                |     |Ms L |Ms Dn|Ms R |Ms WU|     |     |Full |Left |Centr|Right|     |
   *                |-----------------------------------------------------------------------|
   *                |     |Ms WL|Ms B3|Ms WR|     |     |     |Next | BL  | Bot | BR  |     |
   *                |-----------------------------------------------------------------------|
   *                |     |Prev |Play |Next |Brig-|   Sleep   |Brig+|Mute |Vol- |Vol+ |     |
   *                `-----------------------------------------------------------------------'
   *                        \___ Media ___/   \___ Screen/sleep __/   \___ Volume __/
   */
  [GUI_LAYER] = {
    {KC_TRNS, KC_BTN2, KC_MS_U, KC_BTN1, KC_WH_D, KC_NO,   KC_NO,   LCTL(LALT(LGUI(KC_LEFT))), LCTL(LGUI(KC_LEFT)),    LALT(LGUI(KC_UP)),   LCTL(LGUI(KC_RGHT)),    KC_TRNS},
    {KC_TRNS, KC_MS_L, KC_MS_D, KC_MS_R, KC_WH_U, KC_NO,   KC_NO,   LALT(LGUI(KC_F)),          LALT(LGUI(KC_LEFT)),    LALT(LGUI(KC_C)),    LALT(LGUI(KC_RGHT)),    KC_TRNS},
    {KC_TRNS, KC_WH_L, KC_BTN3, KC_WH_R, KC_NO,   KC_NO,   KC_NO,   LCTL(LALT(LGUI(KC_RGHT))), S(LCTL(LGUI(KC_LEFT))), LALT(LGUI(KC_DOWN)), S(LCTL(LGUI(KC_RGHT))), KC_TRNS},
    {KC_TRNS, KC_MPRV, KC_MPLY, KC_MNXT, KC_SLCK, KC_SLEP, KC_SLEP, KC_PAUS,                   KC_MUTE,                KC_VOLD,             KC_VOLU,                KC_TRNS}
  },
  /* Keyboard layer
   *                ,-----------------------------------------------------------------------.
   *    Firmware -- |     |Reset|Debug|     |     |     |     |     |     |     |     |     |
   *                |-----------------------------------------------------------------------|
   * Set default -- |     |Qwert|Colem| ... |     |     |     |     |     |     |     |     |
   *       layer    |-----------------------------------------------------------------------|
   *                |     |     |     |     |     |     |     |     |     |     |     |     |
   *                |-----------------------------------------------------------------------|
   *                |     |     |     |     |LED- |  Toggle   |LED+ |     |     |     |     |
   *                `-----------------------------------------------------------------------'
   *                                          \___ LED controls __/
   */
  [KEYBOARD_LAYER] = {
    {KC_NO, RESET, DEBUG, KC_NO, KC_NO,  KC_NO,   KC_NO,   KC_NO,  KC_NO, KC_NO, KC_NO, KC_TRNS},
    {KC_NO, F(7),  F(8),  KC_NO, KC_NO,  KC_NO,   KC_NO,   KC_NO,  KC_NO, KC_NO, KC_NO, KC_NO},
    {KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,   KC_NO,   KC_NO,  KC_NO, KC_NO, KC_NO, KC_NO},
    {KC_NO, KC_NO, KC_NO, KC_NO, BL_DEC, BL_TOGG, BL_TOGG, BL_INC, KC_NO, KC_NO, KC_NO, KC_NO}
  }
};

const uint16_t PROGMEM fn_actions[] = {
  // Layer switching
  [0] = ACTION_LAYER_TAP_TOGGLE(LOWER_LAYER),
  [1] = ACTION_LAYER_TAP_TOGGLE(RAISE_LAYER),
  [2] = ACTION_LAYER_TAP_KEY(NAVIGATION_LAYER, KC_SCOLON),
  [3] = ACTION_LAYER_TAP_KEY(NAVIGATION_LAYER, KC_O),
  [4] = ACTION_LAYER_TAP_KEY(GUI_LAYER, KC_LBRACKET),
  [5] = ACTION_LAYER_TAP_KEY(GUI_LAYER, KC_RBRACKET),
  [6] = ACTION_LAYER_TAP_KEY(KEYBOARD_LAYER, KC_QUOT),
  [7] = ACTION_DEFAULT_LAYER_SET(BASE_QWERTY_LAYER),
  [8] = ACTION_DEFAULT_LAYER_SET(BASE_COLEMAK_LAYER),
  [9] = 0, // Reserved

  // Modifiers
  [10] = ACTION_MODS_TAP_KEY(MOD_LCTL, KC_ESC),
  [11] = ACTION_MODS_TAP_KEY(MOD_RCTL, KC_ENT)
};

static uint16_t start[6];

const macro_t *action_get_macro(keyrecord_t *record, uint8_t id, uint8_t opt)
{
  switch(id) {
    // Note: You must change the "magic" key combo in config.h to avoid issues
    // with shift tap keys, which is LSFT + RSFT by default.
    case LSFT_PAREN:
      if (record->event.pressed) {
        start[LSFT_PAREN] = timer_read();
        return MACRO(D(LSFT), END);
      } else {
        if (timer_elapsed(start[LSFT_PAREN]) > TAPPING_TERM) {
          return MACRO(U(LSFT), END);
        } else {
          return MACRO(D(LSFT), T(9), U(LSFT), END);
        }
      }
      break;
    case RSFT_PAREN:
      if (record->event.pressed) {
        start[RSFT_PAREN] = timer_read();
        return MACRO(D(RSFT), END);
      } else {
        if (timer_elapsed(start[RSFT_PAREN]) > TAPPING_TERM) {
          return MACRO(U(RSFT), END);
        } else {
          return MACRO(D(RSFT), T(0), U(RSFT), END);
        }
      }
      break;
    case LHYP_ANGLE:
      if (record->event.pressed) {
        start[LHYP_ANGLE] = timer_read();
        return MACRO(D(LSFT), D(LCTL), D(LALT), D(LGUI), END);
      } else {
        if (timer_elapsed(start[LHYP_ANGLE]) > TAPPING_TERM) {
          return MACRO(U(LSFT), U(LCTL), U(LALT), U(LGUI), END);
        } else {
          return MACRO(U(LCTL), U(LALT), U(LGUI), D(LSFT), T(COMM), U(LSFT), END);
        }
      }
      break;
    case RHYP_ANGLE:
      if (record->event.pressed) {
        start[RHYP_ANGLE] = timer_read();
        return MACRO(D(RSFT), D(RCTL), D(RALT), D(RGUI), END);
      } else {
        if (timer_elapsed(start[RHYP_ANGLE]) > TAPPING_TERM) {
          return MACRO(U(RSFT), U(RCTL), U(RALT), U(RGUI), END);
        } else {
          return MACRO(U(RCTL), U(RALT), U(RGUI), D(RSFT), T(DOT), U(RSFT), END);
        }
      }
      break;
    case LALT_BRACE:
      if (record->event.pressed) {
        start[LALT_BRACE] = timer_read();
        return MACRO(D(LALT), END);
      } else {
        if (timer_elapsed(start[LALT_BRACE]) > TAPPING_TERM) {
          return MACRO(U(LALT), END);
        } else {
          return MACRO(U(LALT), D(LSFT), T(LBRACKET), U(LSFT), END);
        }
      }
      break;
    case RALT_BRACE:
      if (record->event.pressed) {
        start[RALT_BRACE] = timer_read();
        return MACRO(D(RALT), END);
      } else {
        if (timer_elapsed(start[RALT_BRACE]) > TAPPING_TERM) {
          return MACRO(U(RALT), END);
        } else {
          return MACRO(U(RALT), D(LSFT), T(RBRACKET), U(LSFT), END);
        }
      }
      break;
  }
}
