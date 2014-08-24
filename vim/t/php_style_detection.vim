describe 'PHP style detection'
  before
    new
    set filetype=php
    runtime after/ftplugin/php.vim
  end

  after
    bdelete!
  end

  context 'of braces'
    it 'defaults to same line'
      TODO
    end

    it 'detects same line'
      TODO
    end

    it 'detects new line'
      TODO
    end
  end

  context 'of spaces after if etc.'
    it 'defaults to no space'
      TODO
    end

    it 'detects no space'
      TODO
    end

    it 'detects space'
      TODO
    end
  end
end

