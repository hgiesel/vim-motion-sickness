" 7. indentation motion
" ii: select current indentation delimited by lines with one indentation less or
" empty lines
" ai: select current indentation delimited by lines with one indentation less
" (which are included) or empty lines
" iI: select current indentation delimited by lines with one indentation less
" (note that this would select the whole file on an empty line)
" aI: select current indentation delimited by lines with one indentation less
" (which are included) (note that this on an indentation of zero would select
" the whole file)

if exists('g:loaded_motion_sickness_indent') || &compatible || v:version < 700
  finish
endif
let g:loaded_motion_sickness_indent = 1

" Setting user mappings {{{1
omap ii <plug>(Oiimotion)
vmap ii <plug>(Viimotion)
omap ai <plug>(Oaimotion)
vmap ai <plug>(Vaimotion)

omap iI <plug>(OiImotion)
vmap iI <plug>(ViImotion)
omap aI <plug>(OaImotion)
vmap aI <plug>(VaImotion)

" Setting plug mappings {{{1
onoremap <silent>
      \ <plug>(Oiimotion) :<c-u>call
      \ indent#sick_iz_motion(indent(line('.')), v:false)<cr>
onoremap <silent>
      \ <plug>(Oaimotion) :<c-u>call
      \ indent#sick_iz_motion(indent(line('.')), v:true)<cr>
vnoremap <silent>
      \ <plug>(Viimotion) :<c-u>call
      \ indent#sick_iz_motion(indent(line('.')), v:false)<cr>
vnoremap <silent>
      \ <plug>(Vaimotion) :<c-u>call
      \ indent#sick_iz_motion(indent(line('.')), v:true)<cr>

onoremap <silent>
      \ <plug>(OiImotion) :<c-u>call
      \ indent#sick_iz_motion_with_reach(indent(line('.')), v:false)<cr>
onoremap <silent>
      \ <plug>(OaImotion) :<c-u>call
      \ indent#sick_iz_motion_with_reach(indent(line('.')), v:true)<cr>
vnoremap <silent>
      \ <plug>(ViImotion) :<c-u>call
      \ indent#sick_iz_motion_with_reach(indent(line('.')), v:false)<cr>
vnoremap <silent>
      \ <plug>(VaImotion) :<c-u>call
      \ indent#sick_iz_motion_with_reach(indent(line('.')), v:true)<cr>
