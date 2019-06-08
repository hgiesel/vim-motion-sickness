" INDENTATION MOTION
" ii: select current indentation delimited by lines with one indentation less or
" empty lines

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

" onoremap <plug>(Oiipmotion) <cmd>call indent#motion(v:false, '')<cr>
" vnoremap <plug>(Viipmotion) <cmd>call indent#motion(v:false, '')<cr>
" onoremap <plug>(Oaipmotion) <cmd>call indent#motion(v:false, '')<cr>
" vnoremap <plug>(Vaipmotion) <cmd>call indent#motion(v:false, '')<cr>

" onoremap <plug>(Oiilmotion) <cmd>call indent#motion(v:false, '')<cr>
" vnoremap <plug>(Viilmotion) <cmd>call indent#motion(v:false, '')<cr>
" onoremap <plug>(Oailmotion) <cmd>call indent#motion(v:false, '')<cr>
" vnoremap <plug>(Vailmotion) <cmd>call indent#motion(v:false, '')<cr>

" onoremap <plug>(Oiibmotion) <cmd>call indent#motion(v:false, '')<cr>
" vnoremap <plug>(Viibmotion) <cmd>call indent#motion(v:false, '')<cr>
" onoremap <plug>(Oaibmotion) <cmd>call indent#motion(v:false, '')<cr>
" vnoremap <plug>(Vaibmotion) <cmd>call indent#motion(v:false, '')<cr>

omap il <plug>(Oilmotion)
vmap il <plug>(Vilmotion)
omap al <plug>(Oalmotion)
vmap al <plug>(Valmotion)

onoremap <silent> <plug>(Oilmotion) <cmd>call line#motion('i')<cr>
vnoremap <silent> <plug>(Vilmotion) <cmd>call line#motion('i')<cr>
onoremap <silent> <plug>(Oalmotion) <cmd>call line#motion('a')<cr>
vnoremap <silent> <plug>(Valmotion) <cmd>call line#motion('a')<cr>
