# My Planck Keyboard Layout

The Planck is a 40% computer keyboard with an [ortholinear][olkb] layout
(the keys are arranged in columns rather than being staggered as on a traditional typewriter keyboard).
The keys are laid out in a 4 by 12 grid with a 2-unit wide spacebar on the bottom row (the so-called MIT layout), for a total of 47 keys.

The board's microcontroller is programmed through the free/libre [Quantum MK firmware][qmk], which allows for a great
deal of flexibility in implementing keyboard layouts. The keymap is organized into layers that can be switched between
by hold or tapping function keys.

[olkb]: https://olkb.com/reference/primer/
[qmk]: https://github.com/qmk/qmk_firmware

## Building

Run the following from this keymap directory:

    make clean; make dfu

----------

You can find the latest version of my keymap file at <https://github.com/noahfrederick/dots/tree/master/planck>.
