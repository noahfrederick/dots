" after/plugin/tabular.vim - Custom presets for Tabular

if !exists(":Tabularize")
  finish
endif

AddTabularPattern! rocket /=>/

" vim:set et sw=2:
