#pragma once

// Disable action_get_macro and fn_actions, since we don't use these
// and it saves on space in the firmware.
#define NO_ACTION_MACRO
#define NO_ACTION_FUNCTION

#ifdef AUDIO_ENABLE
// Play sounds when the default layer is set.
#define DEFAULT_LAYER_SONGS { SONG(QWERTY_SOUND), \
                              SONG(COLEMAK_SOUND) }
#endif

#define DYNAMIC_MACRO_SIZE 256

// Combo feature timeout (defaults to TAPPING_TERM)
#define COMBO_TERM 200
// Size of combo_events enum.
#define COMBO_COUNT 7
