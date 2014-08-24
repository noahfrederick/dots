filetype plugin on
set runtimepath+=$HOME/.vim/bundle/vim-textobj-user
set runtimepath+=$HOME/.vim/bundle/vim-textobj-function
runtime! plugin/textobj/function.vim

if !exists('g:loaded_textobj_function')
  finish
endif

" Abbreviated function name
function! Select(line_number, object)
  return util#test#SelectTextObject(a:line_number, a:object)
endfunction

describe 'PHP function text object'
  before
    new
    set filetype=php
    runtime after/ftplugin/php.vim
    call util#test#ReadFixture('php')
  end

  after
    bdelete!
  end

  context '<Plug>(textobj-function-a)'
    it 'selects the next method if there is no method under the cursor'
      Expect Select(17, 'af') ==# ['V', 18, 21]
    end

    it 'selects the method under the cursor'
      " At the first line.
      Expect Select(13, 'af') ==# ['V', 13, 16]

      " At a middle line.
      Expect Select(15, 'af') ==# ['V', 13, 16]

      " At the last line.
      Expect Select(16, 'af') ==# ['V', 13, 16]
    end

    it 'ignores non-method blocks'
      Expect Select(58, 'af') ==# ['V', 54, 62]
    end

    it 'recognizes methods with argument lists over multiple lines'
      Expect Select(46, 'af') ==# ['V', 46, 52]
      Expect Select(47, 'af') ==# ['V', 46, 52]
      Expect Select(51, 'af') ==# ['V', 46, 52]
    end

    it 'fails if there is no appropriate method'
      TODO
      " SKIP 'Issue with [m'
      Expect Select(64, 'af') ==# ['v', 64, 64]
    end
  end
end
