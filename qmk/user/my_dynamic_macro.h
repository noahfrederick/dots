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

