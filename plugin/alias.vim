" Aliases
" `ir`, `ar`, `ia`, and `aa` where `r` and `a` are aliases for `[` and `<`
" (similiar to tpopes' vim-surround plugin

if exists('g:loaded_motion_sickness_alias') || &compatible || v:version < 700
  finish
endif
let g:loaded_motion_sickness_alias = 1

" Remappings {{{1
omap <silent> ir i[
vmap <silent> ir i[
omap <silent> ar a[
vmap <silent> ar a[

omap <silent> ia i<
vmap <silent> ia i<
omap <silent> aa a<
vmap <silent> aa a<
