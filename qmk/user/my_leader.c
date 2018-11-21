#include "my_leader.h"

bool leading = false;

uint16_t leader_sequence[LEADER_MAX_SIZE] = { 0 };
uint8_t leader_sequence_size = 0;

#ifdef AUDIO_ENABLE
float leader_cancel_tone[][2] = SONG(TERMINAL_SOUND);
#endif

bool leader_terminate(void) {
  leading = false;
  leader_sequence_size = 0;

  for (uint8_t i = 0; i < LEADER_MAX_SIZE; i++) {
    leader_sequence[i] = 0;
  }

  return false;
}

bool leader_cancel(void) {
#ifdef AUDIO_ENABLE
  stop_all_notes();
  PLAY_SONG(leader_cancel_tone);
#endif
  return leader_terminate();
}

__attribute__ ((weak))
bool leader_dictionary(void) {
  return false;
}

bool process_leader(uint16_t keycode, keyrecord_t *record) {
  if (record->event.pressed) {
    if (keycode == LEADER) {
      if (leading) {
        leader_cancel();
      } else {
        leading = true;
      }

      return false;
    } else if (!leading) {
      return true;
    }

    if ((leader_sequence_size + 1) > LEADER_MAX_SIZE) {
      return leader_cancel();
    }

    leader_sequence[leader_sequence_size] = keycode;
    leader_sequence_size++;

    return leader_dictionary();
  }

  return true;
}
