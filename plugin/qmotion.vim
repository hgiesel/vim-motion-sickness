" Q-motions
" `qb` `qB` `qr` `qa` which are motions that select statements, e.g.
" foo(500 + 500))o)o
" while you would use `ib` to select everything within the parentheses and
" `ab` to select the whole parenthesis, you can use `qb` to use the whole
" parenthesis and the word before it. Also works with $(( )) or similiar
" things

if exists('g:loaded_motion_sickness_qmotion') || &compatible || v:version < 700
  finish
endif
let g:loaded_motion_sickness_qmotion = 1

" Setting user mappings {{{1
omap qb <plug>(Oqbmotion)
vmap qb <plug>(Vqbmotion)
omap Qb <plug>(OQbmotion)
vmap Qb <plug>(VQbmotion)

omap qB <plug>(OqBmotion)
vmap qB <plug>(VqBmotion)
omap QB <plug>(OQBmotion)
vmap QB <plug>(VQBmotion)

omap qr <plug>(Oqrmotion)
vmap qr <plug>(Vqrmotion)
omap Qr <plug>(OQrmotion)
vmap Qr <plug>(VQrmotion)

omap qa <plug>(Oqamotion)
vmap qa <plug>(Vqamotion)
omap Qa <plug>(OQamotion)
vmap Qa <plug>(VQamotion)

" Setting plug mappings {{{1
onoremap <silent>
      \ <plug>(Oqbmotion)
      \ :<c-u>call qmotion#sick_qb_motion(getpos('.'), '(', ')', v:false)<cr>
vnoremap <silent>
      \ <plug>(Vqbmotion)
      \ <esc>:<c-u>call qmotion#sick_qb_motion(getpos('.'), '(', ')', v:false)<cr>
onoremap <silent>
      \ <plug>(OQbmotion)
      \ :<c-u>call qmotion#sick_qb_motion(getpos('.'), '(', ')', v:true)<cr>
vnoremap <silent>
      \ <plug>(VQbmotion)
      \ <esc>:<c-u>call qmotion#sick_qb_motion(getpos('.'), '(', ')', v:true)<cr>

onoremap <silent>
      \ <plug>(OqBmotion)
      \ :<c-u>call qmotion#sick_qb_motion(getpos('.'), '{', '}', v:false)<cr>
vnoremap <silent>
      \ <plug>(VqBmotion)
      \ <esc>:<c-u>call qmotion#sick_qb_motion(getpos('.'), '{', '}', v:false)<cr>
onoremap <silent>
      \ <plug>(OQBmotion)
      \ :<c-u>call qmotion#sick_qb_motion(getpos('.'), '{', '}', v:true)<cr>
vnoremap <silent>
      \ <plug>(VQBmotion)
      \ <esc>:<c-u>call qmotion#sick_qb_motion(getpos('.'), '{', '}', v:true)<cr>

onoremap <silent>
      \ <plug>(Oqrmotion)
      \ :<c-u>call qmotion#sick_qb_motion(getpos('.'), '[', ']', v:false)<cr>
vnoremap <silent>
      \ <plug>(Vqrmotion)
      \ <esc>:<c-u>call qmotion#sick_qb_motion(getpos('.'), '[', ']', v:false)<cr>
onoremap <silent>
      \ <plug>(OQrmotion)
      \ :<c-u>call qmotion#sick_qb_motion(getpos('.'), '[', ']', v:true)<cr>
vnoremap <silent>
      \ <plug>(VQrmotion)
      \ <esc>:<c-u>call qmotion#sick_qb_motion(getpos('.'), '[', ']', v:true)<cr>

onoremap <silent>
      \ <plug>(Oqamotion)
      \ :<c-u>call qmotion#sick_qb_motion(getpos('.'), '<', '>', v:false)<cr>
vnoremap <silent>
      \ <plug>(Vqamotion)
      \ <esc>:<c-u>call qmotion#sick_qb_motion(getpos('.'), '<', '>', v:false)<cr>
onoremap <silent>
      \ <plug>(OQamotion)
      \ :<c-u>call qmotion#sick_qb_motion(getpos('.'), '<', '>', v:true)<cr>
vnoremap <silent>
      \ <plug>(VQamotion)
      \ <esc>:<c-u>call qmotion#sick_qb_motion(getpos('.'), '<', '>', v:true)<cr>
