" INDENTATION AND LINE MOTION
if exists('g:loaded_motion_sickness_indent') || &compatible || v:version < 700
  finish
endif
let g:loaded_motion_sickness_indent = 1

" Indentation Setting user mappings {{{1
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

" Indentation Setting plug mappings {{{1
onoremap <silent> <plug>(Oiipmotion) <cmd>call indent#motion(v:false, 'p')<cr>
vnoremap <silent> <plug>(Viipmotion) <cmd>call indent#motion(v:false, 'p')<cr>
onoremap <silent> <plug>(Oaipmotion) <cmd>call indent#motion(v:true, 'p')<cr>
vnoremap <silent> <plug>(Vaipmotion) <cmd>call indent#motion(v:true, 'p')<cr>

onoremap <silent> <plug>(Oiilmotion) <cmd>call indent#motion(v:false, 'l')<cr>
vnoremap <silent> <plug>(Viilmotion) <cmd>call indent#motion(v:false, 'l')<cr>
onoremap <silent> <plug>(Oailmotion) <cmd>call indent#motion(v:true, 'l')<cr>
vnoremap <silent> <plug>(Vailmotion) <cmd>call indent#motion(v:true, 'l')<cr>

onoremap <silent> <plug>(Oiibmotion) <cmd>call indent#motion(v:false, 'b')<cr>
vnoremap <silent> <plug>(Viibmotion) <cmd>call indent#motion(v:false, 'b')<cr>
onoremap <silent> <plug>(Oaibmotion) <cmd>call indent#motion(v:true, 'b')<cr>
vnoremap <silent> <plug>(Vaibmotion) <cmd>call indent#motion(v:true, 'b')<cr>

" Line Setting user mappings {{{1
omap il <plug>(Oilmotion)
vmap il <plug>(Vilmotion)
omap al <plug>(Oalmotion)
vmap al <plug>(Valmotion)

" Line Setting plug mappings {{{1
onoremap <silent> <plug>(Oilmotion) <cmd>call line#motion('i')<cr>
vnoremap <silent> <plug>(Vilmotion) <cmd>call line#motion('i')<cr>
onoremap <silent> <plug>(Oalmotion) <cmd>call line#motion('a')<cr>
vnoremap <silent> <plug>(Valmotion) <cmd>call line#motion('a')<cr>
