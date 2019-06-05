" Aliases
" `ir`, `ar`, `ia`, and `aa` where `r` and `a` are aliases for `[` and `<`
" (similiar to tpopes' vim-surround plugin

if exists('g:loaded_sick_alias') || &compatible || v:version < 700
  finish
endif
let g:loaded_sick_alias = 1

" Remappings {{{1
if
      \ !(exists('g:sick_expression_maps') && g:sick_expression_maps == 'char') && 
      \ !(exists('g:sick_field_maps') && g:sick_field_maps == 'char')
  onoremap <silent> ir i[
  vnoremap <silent> ir i[
  onoremap <silent> ar a[
  vnoremap <silent> ar a[

  onoremap <silent> ia i<
  vnoremap <silent> ia i<
  onoremap <silent> aa a<
  vnoremap <silent> aa a<
endif
