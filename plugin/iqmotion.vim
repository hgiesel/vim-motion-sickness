" Iq-motions
" `iqb` `aqb`, etc. is used to select parameters (or arguments) within
" braces, very helpful for any kind of programming language

if exists('g:loaded_motion_sickness_iqmotion') || &compatible || v:version < 700
  finish
endif
let g:loaded_motion_sickness_iqmotion = 1

" Setting user mappings {{{1
omap iqb <plug>(Oiqbmotion)
vmap iqb <plug>(Viqbmotion)
omap aqb <plug>(Oaqbmotion)
vmap aqb <plug>(Vaqbmotion)

omap iQb <plug>(OiQbmotion)
vmap iQb <plug>(ViQbmotion)
omap aQb <plug>(OaQbmotion)
vmap aQb <plug>(VaQbmotion)

omap iqB <plug>(OiqBmotion)
vmap iqB <plug>(ViqBmotion)
omap aqB <plug>(OaqBmotion)
vmap aqB <plug>(VaqBmotion)

omap iQB <plug>(OiQBmotion)
vmap iQB <plug>(ViQBmotion)
omap aQB <plug>(OaQBmotion)
vmap aQB <plug>(VaQBmotion)

omap iqr <plug>(Oiqrmotion)
vmap iqr <plug>(Viqrmotion)
omap aqr <plug>(Oaqrmotion)
vmap aqr <plug>(Vaqrmotion)

omap iQr <plug>(OiQrmotion)
vmap iQr <plug>(ViQrmotion)
omap aQr <plug>(OaQrmotion)
vmap aQr <plug>(VaQrmotion)

omap iqa <plug>(Oiqamotion)
vmap iqa <plug>(Viqamotion)
omap aqa <plug>(Oaqamotion)
vmap aqa <plug>(Vaqamotion)

omap iQa <plug>(OiQamotion)
vmap iQa <plug>(ViQamotion)
omap aQa <plug>(OaQamotion)
vmap aQa <plug>(VaQamotion)

onoremap <silent>
      \ <plug>(Oiqbmotion)
      \ :<c-u>call iqmotion#MotionArgument(1, 0, '(', ')', ',')<CR>
vnoremap <silent>
      \ <plug>(Viqbmotion)
      \ <esc>:<c-u>call iqmotion#MotionArgument(1, 1, '(', ')', ',')<CR>
onoremap <silent>
      \ <plug>(Oaqbmotion)
      \ :<c-u>call iqmotion#MotionArgument(0, 0, '(', ')', ',')<CR>
vnoremap <silent>
      \ <plug>(Vaqbmotion)
      \ <esc>:<c-u>call iqmotion#MotionArgument(0, 1, '(', ')', ',')<CR>

onoremap <silent>
      \ <plug>(OiQbmotion)
      \ :<c-u>call iqmotion#MotionArgument(1, 0, '(', ')', ';')<CR>
vnoremap <silent>
      \ <plug>(ViQbmotion)
      \ <esc>:<c-u>call iqmotion#MotionArgument(1, 1, '(', ')', ';')<CR>
onoremap <silent>
      \ <plug>(OaQbmotion)
      \ :<c-u>call iqmotion#MotionArgument(0, 0, '(', ')', ';')<CR>
vnoremap <silent>
      \ <plug>(VaQbmotion)
      \ <esc>:<c-u>call iqmotion#MotionArgument(0, 1, '(', ')', ';')<CR>

onoremap <silent>
      \ <plug>(OiqBmotion)
      \ :<c-u>call iqmotion#MotionArgument(1, 0, '{', '}', ',')<CR>
vnoremap <silent>
      \ <plug>(ViqBmotion)
      \ <esc>:<c-u>call iqmotion#MotionArgument(1, 1, '{', '}', ',')<CR>
onoremap <silent>
      \ <plug>(OaqBmotion)
      \ :<c-u>call iqmotion#MotionArgument(0, 0, '{', '}', ',')<CR>
vnoremap <silent>
      \ <plug>(VaqBmotion)
      \ <esc>:<c-u>call iqmotion#MotionArgument(0, 1, '{', '}', ',')<CR>

onoremap <silent>
      \ <plug>(OiQBmotion)
      \ :<c-u>call iqmotion#MotionArgument(1, 0, '{', '}', ';')<CR>
vnoremap <silent>
      \ <plug>(ViQBmotion)
      \ <esc>:<c-u>call iqmotion#MotionArgument(1, 1, '{', '}', ';')<CR>
onoremap <silent>
      \ <plug>(OaQBmotion)
      \ :<c-u>call iqmotion#MotionArgument(0, 0, '{', '}', ';')<CR>
vnoremap <silent>
      \ <plug>(VaQBmotion)
      \ <esc>:<c-u>call iqmotion#MotionArgument(0, 1, '{', '}', ';')<CR>

onoremap <silent>
      \ <plug>(Oiqrmotion)
      \ :<c-u>call iqmotion#MotionArgument(1, 0, '[', ']', ',')<CR>
vnoremap <silent>
      \ <plug>(Viqrmotion)
      \ <esc>:<c-u>call iqmotion#MotionArgument(1, 1, '[', ']', ',')<CR>
onoremap <silent>
      \ <plug>(Oaqrmotion)
      \ :<c-u>call iqmotion#MotionArgument(0, 0, '[', ']', ',')<CR>
vnoremap <silent>
      \ <plug>(Vaqrmotion)
      \ <esc>:<c-u>call iqmotion#MotionArgument(0, 1, '[', ']', ',')<CR>

onoremap <silent>
      \ <plug>(OiQrmotion)
      \ :<c-u>call iqmotion#MotionArgument(1, 0, '[', ']', ';')<CR>
vnoremap <silent>
      \ <plug>(ViQrmotion)
      \ <esc>:<c-u>call iqmotion#MotionArgument(1, 1, '[', ']', ';')<CR>
onoremap <silent>
      \ <plug>(OaQrmotion)
      \ :<c-u>call iqmotion#MotionArgument(0, 0, '[', ']', ';')<CR>
vnoremap <silent>
      \ <plug>(VaQrmotion)
      \ <esc>:<c-u>call iqmotion#MotionArgument(0, 1, '[', ']', ';')<CR>

onoremap <silent>
      \ <plug>(Oiqamotion)
      \ :<c-u>call iqmotion#MotionArgument(1, 0, '<', '>', ',')<CR>
vnoremap <silent>
      \ <plug>(Viqamotion)
      \ <esc>:<c-u>call iqmotion#MotionArgument(1, 1, '<', '>', ',')<CR>
onoremap <silent>
      \ <plug>(Oaqamotion)
      \ :<c-u>call iqmotion#MotionArgument(0, 0, '<', '>', ',')<CR>
vnoremap <silent>
      \ <plug>(Vaqamotion)
      \ <esc>:<c-u>call iqmotion#MotionArgument(0, 1, '<', '>', ',')<CR>

onoremap <silent>
      \ <plug>(OiQamotion)
      \ :<c-u>call iqmotion#MotionArgument(1, 0, '<', '>', ';')<CR>
vnoremap <silent>
      \ <plug>(ViQamotion)
      \ <esc>:<c-u>call iqmotion#MotionArgument(1, 1, '<', '>', ';')<CR>
onoremap <silent>
      \ <plug>(OaQamotion)
      \ :<c-u>call iqmotion#MotionArgument(0, 0, '<', '>', ';')<CR>
vnoremap <silent>
      \ <plug>(VaQamotion)
      \ <esc>:<c-u>call iqmotion#MotionArgument(0, 1, '<', '>', ';')<CR>
