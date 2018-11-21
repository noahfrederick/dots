#pragma once

#include "my.h"

#define LEADER_MAX_SIZE 3
#define LEADER_SINGLE(key) \
  if (leader_sequence[0] == (key))
#define LEADER_DOUBLE(key1, key2) \
  if (leader_sequence[0] == (key1) \
      && leader_sequence[1] == (key2))
#define LEADER_TRIPLE(key1, key2, key3) \
  if (leader_sequence[0] == (key1) \
      && leader_sequence[1] == (key2) \
      && leader_sequence[2] == (key3))

#define GET_LEADER_MACRO(_1, _2, _3, NAME, ...) NAME
#define LEADER(...) GET_LEADER_MACRO(__VA_ARGS__, \
    LEADER_TRIPLE, LEADER_DOUBLE, LEADER_SINGLE)(__VA_ARGS__)

#define LEADER_DICT extern uint16_t leader_sequence[LEADER_MAX_SIZE]; \
  bool leader_dictionary(void)

bool process_leader(uint16_t keycode, keyrecord_t *record);
bool leader_dictionary(void);
bool leader_terminate(void);
bool leader_cancel(void);
