#include "keymap_common.h"
#include "keymap_plover.h"
#include "action_tapping.h"

// Keymap layers
#define BASE_QWERTY_LAYER 0
#define BASE_COLEMAK_LAYER 1
#define BASE_STENO_LAYER 2
#define LOWER_LAYER 3
#define RAISE_LAYER 4
#define NAVIGATION_LAYER 5
#define GUI_LAYER 6
#define KEYBOARD_LAYER 7

// Modifier-delimiter hold-tap macros
#define LALT_BRACE 0
#define RALT_BRACE 1

// Key aliases
#define _______ KC_TRNS
#define ___x___ KC_NO

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
    {KC_TAB,  KC_Q,           KC_W,  KC_E,    KC_R, KC_T,   KC_Y,   KC_U, KC_I,    KC_O,   KC_P,           F(6)},
    {F(10),   KC_A,           KC_S,  KC_D,    KC_F, KC_G,   KC_H,   KC_J, KC_K,    KC_L,   F(2),           F(11)},
    {KC_LSPO, KC_Z,           KC_X,  KC_C,    KC_V, KC_B,   KC_N,   KC_M, KC_COMM, KC_DOT, KC_SLSH,        KC_RSPC},
    {F(4),    ALL_T(KC_LBRC), F(12), KC_LGUI, F(0), KC_SPC, KC_SPC, F(1), KC_RGUI, F(13),  ALL_T(KC_RBRC), F(5)}
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
    {_______, KC_Q,    KC_W,    KC_F,    KC_P,    KC_G,    KC_J,    KC_L,    KC_U,    KC_Y,    KC_SCLN, _______},
    {_______, KC_A,    KC_R,    KC_S,    KC_T,    KC_D,    KC_H,    KC_N,    KC_E,    KC_I,    F(3),    _______},
    {_______, KC_Z,    KC_X,    KC_C,    KC_V,    KC_B,    KC_K,    KC_M,    _______, _______, _______, _______},
    {_______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______}
  },

  /* Base layer (Qwerty-Steno)
   *                ,-----------------------------------------------------------------------.
   *                |     |  #  |  #  |  #  |  #  |  #  |  #  |  #  |  #  |  #  |  #  |     |
   *                |-----------------------------------------------------------------------|
   *                |     |     |  T  |  P  |  H  |           |  F  |  P  |  L  |  T  |  D  |
   *                |-----|  S  |-----+-----+-----|     *     |-----+-----+-----+-----+-----|
   *                |     |     |  K  |  W  |  R  |           |  R  |  B  |  G  |  S  |  Z  |
   *                |-----------------------------------------------------------------------|
   *                |     |     |     |  A  |  O  |           |  E  |  U  |     |     |     |
   *                `-----------------------------------------------------------------------'
   */
  [BASE_STENO_LAYER] = {
    {___x___, PV_NUM,  PV_NUM,  PV_NUM, PV_NUM, PV_NUM,  PV_NUM,  PV_NUM, PV_NUM, PV_NUM,  PV_NUM,  _______},
    {___x___, PV_LS,   PV_LT,   PV_LP,  PV_LH,  PV_STAR, PV_STAR, PV_RF,  PV_RP,  PV_RL,   PV_RT,   PV_RD},
    {___x___, PV_LS,   PV_LK,   PV_LW,  PV_LR,  PV_STAR, PV_STAR, PV_RR,  PV_RB,  PV_RG,   PV_RS,   PV_RZ},
    {___x___, ___x___, ___x___, PV_A,   PV_O,   _______, _______, PV_E,   PV_U,   ___x___, ___x___, ___x___}
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
    {LGUI(KC_GRV), KC_F1,          KC_F2,  KC_F3,   KC_F4,   KC_F5,   KC_F6,   KC_F7, KC_F8,   KC_F9, KC_F10,         _______},
    {F(10),        KC_1,           KC_2,   KC_3,    KC_4,    KC_5,    KC_6,    KC_7,  KC_8,    KC_9,  KC_0,           F(11)},
    {KC_LSPO,      KC_MINS,        KC_EQL, KC_GRV,  KC_BSLS, KC_A,    KC_B,    KC_C,  KC_D,    KC_E,  KC_F,           KC_RSPC},
    {F(4),         ALL_T(KC_LBRC), F(12),  KC_LGUI, F(0),    KC_BSPC, KC_BSPC, F(1),  KC_RGUI, F(13), ALL_T(KC_RBRC), F(5)}
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
    {_______, KC_F11,  KC_F12,  KC_F13,  KC_F14,  KC_F15,  KC_F16,        KC_F17,           KC_F18,  KC_F19,  KC_F20,     _______},
    {_______, S(KC_1), S(KC_2), S(KC_3), S(KC_4), S(KC_5), S(KC_6),       S(KC_7),          S(KC_8), KC_QUOT, S(KC_QUOT), _______},
    {_______, KC_UNDS, KC_PLUS, KC_TILD, KC_PIPE, ___x___, LALT(KC_MINS), S(LALT(KC_MINS)), ___x___, ___x___, ___x___,    _______},
    {_______, _______, _______, _______, _______, KC_DEL,  KC_DEL,        _______,          _______, _______, _______,    _______}
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
    {___x___, ___x___, ___x___, ___x___, ___x___, ___x___, ___x___, ___x___, ___x___, ___x___, ___x___, ___x___},
    {_______, ___x___, KC_HOME, KC_PGUP, KC_PGDN, KC_END,  KC_LEFT, KC_DOWN, KC_UP,   KC_RGHT, F(2),    _______},
    {_______, ___x___, ___x___, ___x___, ___x___, ___x___, ___x___, ___x___, ___x___, ___x___, ___x___, _______},
    {_______, _______, _______, _______, ___x___, ___x___, ___x___, ___x___, _______, _______, _______, _______}
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
    {_______, KC_BTN2, KC_MS_U, KC_BTN1, KC_WH_D, ___x___, ___x___, LCTL(LALT(LGUI(KC_LEFT))), LCTL(LGUI(KC_LEFT)),    LALT(LGUI(KC_UP)),   LCTL(LGUI(KC_RGHT)),    _______},
    {_______, KC_MS_L, KC_MS_D, KC_MS_R, KC_WH_U, ___x___, ___x___, LALT(LGUI(KC_F)),          LALT(LGUI(KC_LEFT)),    LALT(LGUI(KC_C)),    LALT(LGUI(KC_RGHT)),    _______},
    {_______, KC_WH_L, KC_BTN3, KC_WH_R, ___x___, ___x___, ___x___, LCTL(LALT(LGUI(KC_RGHT))), S(LCTL(LGUI(KC_LEFT))), LALT(LGUI(KC_DOWN)), S(LCTL(LGUI(KC_RGHT))), _______},
    {_______, KC_MPRV, KC_MPLY, KC_MNXT, KC_SLCK, KC_SLEP, KC_SLEP, KC_PAUS,                   KC_MUTE,                KC_VOLD,             KC_VOLU,                _______}
  },

  /* Keyboard layer
   *                ,-----------------------------------------------------------------------.
   *    Firmware -- |     |Reset|Debug|     |     |     |     |     |     |     |     |     |
   *                |-----------------------------------------------------------------------|
   * Set default -- |     |Qwert|Colem|Steno| ... |     |     |     |     |     |     |     |
   *       layer    |-----------------------------------------------------------------------|
   *                |     |     |     |     |     |     |     |     |     |     |     |     |
   *                |-----------------------------------------------------------------------|
   *                |     |     |     |     |LED- |  Toggle   |LED+ |     |     |     |     |
   *                `-----------------------------------------------------------------------'
   *                                          \___ LED controls __/
   */
  [KEYBOARD_LAYER] = {
    {___x___, RESET,   DEBUG,   ___x___, ___x___, ___x___, ___x___, ___x___, ___x___, ___x___, ___x___, _______},
    {___x___, F(7),    F(8),    F(9),    ___x___, ___x___, ___x___, ___x___, ___x___, ___x___, ___x___, ___x___},
    {___x___, ___x___, ___x___, ___x___, ___x___, ___x___, ___x___, ___x___, ___x___, ___x___, ___x___, ___x___},
    {___x___, ___x___, ___x___, ___x___, BL_DEC,  BL_TOGG, BL_TOGG, BL_INC,  ___x___, ___x___, ___x___, ___x___}
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
  [9] = ACTION_DEFAULT_LAYER_SET(BASE_STENO_LAYER),

  // Modifiers
  [10] = ACTION_MODS_TAP_KEY(MOD_LCTL, KC_ESC),
  [11] = ACTION_MODS_TAP_KEY(MOD_RCTL, KC_ENT),

  [12] = ACTION_MACRO_TAP(LALT_BRACE),
  [13] = ACTION_MACRO_TAP(RALT_BRACE),
};

const macro_t *action_get_macro(keyrecord_t *record, uint8_t id, uint8_t opt)
{
  switch(id) {
    case LALT_BRACE:
      if (record->event.pressed) {
        register_mods(MOD_LALT);
        record->tap.interrupted = 0;
      } else {
        unregister_mods(MOD_LALT);

        if (record->tap.count && !record->tap.interrupted) {
          add_weak_mods(MOD_LSFT);
          register_code(KC_LBRACKET);
          unregister_code(KC_LBRACKET);
          del_weak_mods(MOD_LSFT);
        }

        record->tap.count = 0;
      }
      break;
    case RALT_BRACE:
      if (record->event.pressed) {
        register_mods(MOD_RALT);
        record->tap.interrupted = 0;
      } else {
        unregister_mods(MOD_RALT);

        if (record->tap.count && !record->tap.interrupted) {
          add_weak_mods(MOD_LSFT);
          register_code(KC_RBRACKET);
          unregister_code(KC_RBRACKET);
          del_weak_mods(MOD_LSFT);
        }

        record->tap.count = 0;
      }
      break;
  }
  return MACRO_NONE;
}
