" after/plugin/accio.vim - Accio overrides
" Maintainer: Noah Frederick

execute "sign define AccioError text=\u276f"
execute "sign define AccioWarning text=\u276f"

highlight! link AccioErrorSign SyntasticErrorSign
highlight! link AccioWarningSign SyntasticErrorSign

" vim: fdm=marker:sw=2:sts=2:et
