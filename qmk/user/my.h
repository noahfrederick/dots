#pragma once

#include "quantum.h"
#include "version.h"

#ifdef RGB_MATRIX_ENABLE
#include "rgb_matrix.h"
#endif

enum custom_keycodes {
  SEND_MAKE = SAFE_RANGE,
  SEND_VERSION,
  NEW_SAFE_RANGE
};

// Dashes (macOS)
#define KC_NDSH LALT(KC_MINS)
#define KC_MDSH S(LALT(KC_MINS))

// Window manager keys
#define WM_FULL LALT(LGUI(KC_F))
#define WM_NEXT LCTL(LALT(LGUI(KC_RGHT)))
#define WM_PREV LCTL(LALT(LGUI(KC_LEFT)))
#define WM_NW   LCTL(LGUI(KC_LEFT))
#define WM_N    LALT(LGUI(KC_UP))
#define WM_NE   LCTL(LGUI(KC_RGHT))
#define WM_E    LALT(LGUI(KC_RGHT))
#define WM_SE   S(LCTL(LGUI(KC_RGHT)))
#define WM_S    LALT(LGUI(KC_DOWN))
#define WM_SW   S(LCTL(LGUI(KC_LEFT)))
#define WM_W    LALT(LGUI(KC_LEFT))
#define WM_CNTR LALT(LGUI(KC_C))

// Unify backlight controls
#ifdef RGB_MATRIX_ENABLE
#define LIT_TOG RGB_TOG
#define LIT_DEC RGB_VAD
#define LIT_INC RGB_VAI
#else
#define LIT_TOG BL_TOGG
#define LIT_DEC BL_DEC
#define LIT_INC BL_INC
#endif
