" filetype.vim - Custom file type detection
" Maintainer: Noah Frederick

augroup filetypedetect
  autocmd! BufRead,BufNewFile *.snippets set filetype=snippets
  autocmd! BufRead,BufNewFile *Test.php  set filetype=php.phpunit
  autocmd! BufRead,BufNewFile *_spec.rb  set filetype=ruby.rspec
  autocmd! BufRead,BufNewFile .env.*     setfiletype sh
  autocmd! BufRead,BufNewFile Brewfile   setfiletype ruby
augroup END

" vim: fdm=marker:sw=2:sts=2:et
