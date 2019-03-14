Personal configuration files for Unix-like systems

The repository's structure mimics the contents of `XDG_CONFIG_HOME`
(e.g., `fish/config.fish` corresponds to `~/.config/fish/config.fish`).

Software
========

Neovim
------

**What?** [Neovim][nvim] is a free, cross-platform text editor based on Vim.

**Why?** It is infinitely extensible and has an elegant modal editing model. I
use Neovim for all text-editing purposes including note-taking and programming,
and also as a pager.

[nvim]: https://neovim.io/

Emacs
-----

**What?** [Emacs][emacs] is a free, cross-platform text editor, mail client,
news reader, organizer, and more. It does not take the streamlined,
minimalistic approach that (Neo)Vim does, but it can be made to emulate Vim.

**Why?** I keep Emacs around exclusively for [Org mode][org]. See my
[emacs.org](emacs/emacs.org) file for more.

[emacs]: https://www.gnu.org/software/emacs/
[org]: https://orgmode.org

Fish
----

**What?** [fish][fish] is a user-friendly command line shell.

**Why?** The project is guided by a principled set of
[design guidelines][fish-design]. The result is a shell with a consistent
scripting language, deep extensibility, and virtually no configuration
required.

[fish]: https://fishshell.com
[fish-design]: https://fishshell.com/docs/current/design.html

Tmux
----

**What?** [Tmux][tmux] is a popular terminal multiplexer.

**Why?** My workflow revolves around disposable sessions, each having a
one-to-one correspondence to a project. Switching tasks involves switching
sessions. I can freely destroy and recreate sessions for particular projects
via [Tmuxinator][tmuxinator].

[tmux]: http://tmux.sourceforge.net
[tmuxinator]: https://github.com/tmuxinator/tmuxinator
