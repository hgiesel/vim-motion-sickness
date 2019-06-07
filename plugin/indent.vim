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
omap iip <plug>(Oiipmotion)
vmap iip <plug>(Viipmotion)
omap aip <plug>(Oaipmotion)
vmap aip <plug>(Vaipmotion)

omap iil <plug>(Oiilmotion)
vmap iil <plug>(Viilmotion)
omap ail <plug>(Oailmotion)
vmap ail <plug>(Vailmotion)

omap iib <plug>(Oiibmotion)
vmap iib <plug>(Viibmotion)
omap aib <plug>(Oaibmotion)
vmap aib <plug>(Vaibmotion)

omap il <plug>(Oilmotion)
vmap il <plug>(Vilmotion)
omap al <plug>(Oalmotion)
vmap al <plug>(Valmotion)

" " Setting plug mappings {{{1
onoremap <silent>
      \ <plug>(Oiipmotion) <cmd>call indent#motion(v:false, '')<cr>
vnoremap <silent>
      \ <plug>(Viipmotion) <cmd>call indent#motion(v:false, '')<cr>
onoremap <silent>
      \ <plug>(Oaipmotion) <cmd>call indent#motion(v:true, '')<cr>
vnoremap <silent>
      \ <plug>(Vaipmotion) <cmd>call indent#motion(v:true, '')<cr>

onoremap <silent>
      \ <plug>(Oiibmotion) <cmd>call indent#motion(v:false, 'all')<cr>
vnoremap <silent>
      \ <plug>(Viibmotion) <cmd>call indent#motion(v:false, 'all')<cr>
onoremap <silent>
      \ <plug>(Oaibmotion) <cmd>call indent#motion(v:false, 'escape')<cr>
vnoremap <silent>
      \ <plug>(Vaibmotion) <cmd>call indent#motion(v:false, 'escape')<cr>

onoremap <silent> <plug>(Oilmotion) $v^o
vnoremap <silent> <plug>(Vilmotion) <esc>$v^o
onoremap <silent> <plug>(Oalmotion) g_v0o
vnoremap <silent> <plug>(Valmotion) <esc>g_v0o
