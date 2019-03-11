#
# Generate DRY terminal/GUI Vim color schemes.
#

require 'yaml'

def hi(group, options = {})
  tokens = ['highlight']
  tokens << group.to_s

  if (fg = options.delete(:fg))
    tokens << "guifg=#{fg[:gui]}"
    tokens << "ctermfg=#{fg[:cterm]}"
  end

  if (bg = options.delete(:bg))
    tokens << "guibg=#{bg[:gui]}"
    tokens << "ctermbg=#{bg[:cterm]}"
  end

  if (extra = options.delete(:extra))
    tokens << "guiextra=#{extra[:gui]}"
  end

  if options.empty?
    tokens << 'gui=NONE'
    tokens << 'cterm=NONE'
  else
    rest = options.keys.join(',')
    tokens << "gui=#{rest}"
    tokens << "cterm=#{rest}"
  end

  puts tokens.join(' ')
end

def hl(group, other)
  tokens = ['highlight! link']
  tokens << group.to_s
  tokens << other.to_s

  puts tokens.join(' ')
end

def colorscheme(name)
  puts <<~EOS
  " #{name}.vim - Vim color scheme
  "
  " This is a generated file. See colorscheme.rb.

  " Setup {{{
  highlight! clear

  if exists('g:syntax_on')
    syntax reset
  endif

  let g:colors_name = '#{name}'

  "}}}
  EOS

  yield

  puts <<~EOF

  " vim: fdm=marker:sw=2:sts=2:et
  EOF
end

def section(label)
  puts "\" #{label} {{{"
  yield
  puts "\n\"}}}"
end

NONE = { cterm: 'NONE', gui: 'NONE' }

def alacritty
  YAML.load_file("#{ENV['HOME']}/.config/alacritty/alacritty.yml")
end

def translate_colors(hash)
  Hash[hash.map { |k, v| [k, v.sub(/^0x/, '#')] }]
end

def colors
  @colors ||= alacritty['colors']
end

def primary
  @primary ||= translate_colors(colors['primary'])
end

def normal
  @normal ||= translate_colors(colors['normal'])
end

def bright
  @bright ||= translate_colors(colors['bright'])
end

def background; { cterm: 'NONE', gui: primary['background'] }; end
def foreground; { cterm: 'NONE', gui: primary['foreground'] }; end

def black;   { cterm: 0, gui: normal['black']   }; end
def red;     { cterm: 1, gui: normal['red']     }; end
def green;   { cterm: 2, gui: normal['green']   }; end
def yellow;  { cterm: 3, gui: normal['yellow']  }; end
def blue;    { cterm: 4, gui: normal['blue']    }; end
def magenta; { cterm: 5, gui: normal['magenta'] }; end
def cyan;    { cterm: 6, gui: normal['cyan']    }; end
def white;   { cterm: 7, gui: normal['white']   }; end

def bright_black;   { cterm: 8,  gui: bright['black']   }; end
def bright_red;     { cterm: 9,  gui: bright['red']     }; end
def bright_green;   { cterm: 10, gui: bright['green']   }; end
def bright_yellow;  { cterm: 11, gui: bright['yellow']  }; end
def bright_blue;    { cterm: 12, gui: bright['blue']    }; end
def bright_magenta; { cterm: 13, gui: bright['magenta'] }; end
def bright_cyan;    { cterm: 14, gui: bright['cyan']    }; end
def bright_white;   { cterm: 15, gui: bright['white']   }; end
