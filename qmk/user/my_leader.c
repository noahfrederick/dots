/* Copyright 2018 Noah Frederick
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

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
