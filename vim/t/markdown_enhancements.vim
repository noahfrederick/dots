set runtimepath+=$HOME/.vim/plugged/switch.vim
runtime! plugin/switch.vim

describe 'Markdown enhancement'
  before
    new
    set filetype=markdown
    " Required for mapping's use of <C-u>
    set backspace=2
    set autoindent
    runtime after/ftplugin/markdown.vim
  end

  after
    bdelete!
  end

  context 'of unordered lists'
    it 'continues a list with - after <CR>'
      execute "normal i- Item 1\<CR>Item 2"
      Expect getline(1) ==# '- Item 1'
      Expect getline(2) ==# '- Item 2'
    end

    it 'preserves the indent when continuing a list with <CR>'
      execute "normal i  - Item 1\<CR>Item 2"
      Expect getline(1) ==# '  - Item 1'
      Expect getline(2) ==# '  - Item 2'
    end

    it 'breaks the line after <CR>'
      execute "normal i- Item 1xItem 2"
      execute "normal ggfxi\<CR>"
      Expect getline(1) ==# '- Item 1'
      Expect getline(2) ==# '- xItem 2'
    end

    it 'continues a list with - after o'
      execute "normal i- Item 1\<Esc>oItem 2"
      Expect getline(1) ==# '- Item 1'
      Expect getline(2) ==# '- Item 2'
    end

    it 'continues a list upward with - after O'
      execute "normal i- Item 1\<Esc>OItem 0"
      Expect getline(1) ==# '- Item 0'
      Expect getline(2) ==# '- Item 1'
    end

    it 'continues a list with *'
      execute "normal i* Item 1\<CR>Item 2"
      Expect getline(1) ==# '* Item 1'
      Expect getline(2) ==# '* Item 2'
    end

    it 'continues a list with +'
      execute "normal i+ Item 1\<CR>Item 2"
      Expect getline(1) ==# '+ Item 1'
      Expect getline(2) ==# '+ Item 2'
    end

    it 'continues a list with --'
      execute "normal i-- Item 1\<CR>Item 2"
      Expect getline(1) ==# '-- Item 1'
      Expect getline(2) ==# '-- Item 2'
    end

    it 'continues a list with ++ (using --)'
      execute "normal i++ Item 1\<CR>Item 2"
      Expect getline(1) ==# '++ Item 1'
      Expect getline(2) ==# '-- Item 2'
    end

    it 'continues a list with - [ ]'
      execute "normal i- [ ] Item 1\<CR>Item 2"
      Expect getline(1) ==# '- [ ] Item 1'
      Expect getline(2) ==# '- [ ] Item 2'
    end

    it 'continues a list with - [x] (using - [ ])'
      execute "normal i- [x] Item 1\<CR>Item 2"
      Expect getline(1) ==# '- [x] Item 1'
      Expect getline(2) ==# '- [ ] Item 2'
    end

    it 'discontinues a list after a blank item'
      " This test is overly fussy for some reason, and variations fail in
      " circumstances where the mapping works correctly when used
      " interactively.
      0put = '- '
      execute "normal A\<CR>Outside"
      Expect getline(1) ==# ''
      Expect getline(2) ==# 'Outside'
    end
  end

  context 'of ordered lists'
    it 'continues a list after <CR>'
      execute "normal i1. Item 1\<CR>Item 2"
      Expect getline(1) ==# '1. Item 1'
      Expect getline(2) ==# '2. Item 2'
    end

    it 'continues a list after o'
      execute "normal i1. Item 1\<Esc>oItem 2"
      Expect getline(1) ==# '1. Item 1'
      Expect getline(2) ==# '2. Item 2'
    end

    it 'continues a list upward after O'
      execute "normal i1. Item 1\<Esc>OItem 0"
      Expect getline(1) ==# '1. Item 0'
      Expect getline(2) ==# '2. Item 1'
    end

    it 'increments following list items when inserting a new one'
      0put = '1. Item 1'
      1put = '2. Item 2'
      2put = '3. Item 3'
      3put = '4. Item 4'
      normal 2GoNew Item
      Expect getline(1) ==# '1. Item 1'
      Expect getline(2) ==# '2. Item 2'
      Expect getline(3) ==# '3. New Item'
      Expect getline(4) ==# '4. Item 3'
      Expect getline(5) ==# '5. Item 4'
    end
  end

  context 'of block quotes'
    it 'continues a block quote after <CR>'
      execute "normal i> Item 1\<CR>Item 2"
      Expect getline(1) ==# '> Item 1'
      Expect getline(2) ==# '> Item 2'
    end

    it 'continues a block quote after o'
      execute "normal i> Item 1\<Esc>oItem 2"
      Expect getline(1) ==# '> Item 1'
      Expect getline(2) ==# '> Item 2'
    end

    it 'continues a block quote upward after O'
      execute "normal i> Item 1\<Esc>OItem 0"
      Expect getline(1) ==# '> Item 0'
      Expect getline(2) ==# '> Item 1'
    end
  end

  context 'of ---'
    it 'inserts literal characters when not at beginning of line'
      " Insert on second line
      normal oText ---
      Expect getline(1) ==# ''
      Expect getline(2) ==# 'Text ---'
      Expect getline(3) ==# ''
    end

    it 'inserts a YAML frontmatter block on the first line'
      " Insert on first line
      normal i---
      Expect getline(1) ==# '---'
      Expect getline(2) ==# '---'
    end

    it 'underlines the text in the line above'
      0put = 'Example Heading'
      " Insert on second line
      normal o---
      Expect getline(1) ==# 'Example Heading'
      Expect getline(2) ==# '---------------'
      Expect getline(3) ==# ''
    end

    it 'inserts a textwidth-length horizonal rule under a blank line'
      set textwidth=6
      " Insert on second line
      normal o---
      Expect getline(1) ==# ''
      Expect getline(2) ==# '------'
    end

    it 'inserts a fixed-length horizonal rule under a blank line when textwidth=0'
      set textwidth=0
      " Insert on second line
      normal o---
      Expect getline(1) ==# ''
      Expect getline(2) ==# '----------'
    end
  end

  context 'for headings'
    it 'can promote headings'
      0put = '## Example heading'
      execute "normal \<Left>"
      Expect getline(1) ==# '# Example heading'
      " Does nothing if already an H1
      execute "normal \<Left>"
      Expect getline(1) ==# '# Example heading'
    end

    it 'can demote headings'
      0put = '##### Example heading'
      execute "normal \<Right>"
      Expect getline(1) ==# '###### Example heading'
      " Does nothing if already an H6
      execute "normal \<Right>"
      Expect getline(1) ==# '###### Example heading'
    end

    it 'creates a heading from a non-heading'
      0put = 'Example text'
      execute "normal \<Right>"
      Expect getline(1) ==# '# Example text'
    end
  end

  context 'Switch features'
    it 'cycles checked/unchecked states of - [ ] style list items'
      if !exists(':Switch')
        SKIP 'Switch.vim not available'
      endif

      0put = '- [ ] A task'
      execute "normal \<CR>"
      Expect getline(1) ==# '- [x] A task'
      execute "normal \<CR>"
      Expect getline(1) ==# '- [ ] A task'
    end

    it 'cycles checked/unchecked states of -- style list items'
      if !exists(':Switch')
        SKIP 'Switch.vim not available'
      endif

      0put = '-- A task'
      execute "normal \<CR>"
      Expect getline(1) ==# '++ A task'
      execute "normal \<CR>"
      Expect getline(1) ==# '-- A task'
    end

    it 'cycles TODO keywords in plain list items'
      if !exists(':Switch')
        SKIP 'Switch.vim not available'
      endif

      0put = '- A task'
      execute "normal \<CR>"
      Expect getline(1) ==# '- TODO A task'
      execute "normal \<CR>"
      Expect getline(1) ==# '- DONE A task'
      execute "normal \<CR>"
      Expect getline(1) ==# '- WAITING A task'
      execute "normal \<CR>"
      Expect getline(1) ==# '- CANCELED A task'
      execute "normal \<CR>"
      Expect getline(1) ==# '- A task'
    end
  end
end
