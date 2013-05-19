" after/plugin/tabular.vim - Custom presets for Tabular

if !exists(":Tabularize")
  finish
endif

AddTabularPattern! rocket /=/l1l0

" vim:set et sw=2:
