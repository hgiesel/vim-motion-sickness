" Iq-motions
" `iqb` `aqb`, etc. is used to select parameters (or arguments) within
" braces, very helpful for any kind of programming language

if exists('g:loaded_motion_sickness_field') || &compatible || v:version < 700
  finish
endif
let g:loaded_motion_sickness_field = 1

" Setting user mappings {{{1
omap ifb <plug>(Oifbmotion)
vmap ifb <plug>(Vifbmotion)
omap afb <plug>(Oafbmotion)
vmap afb <plug>(Vafbmotion)

omap ifr <plug>(Oifrmotion)
vmap ifr <plug>(Vifrmotion)
omap afr <plug>(Oafrmotion)
vmap afr <plug>(Vafrmotion)

omap ifB <plug>(OifBmotion)
vmap ifB <plug>(VifBmotion)
omap afB <plug>(OafBmotion)
vmap afB <plug>(VafBmotion)

omap ifa <plug>(Oifamotion)
vmap ifa <plug>(Vifamotion)
omap afa <plug>(Oafamotion)
vmap afa <plug>(Vafamotion)

" omap iQb <plug>(OiQbmotion)
" vmap iQb <plug>(ViQbmotion)
" omap aQb <plug>(OaQbmotion)
" vmap aQb <plug>(VaQbmotion)

" omap iQB <plug>(OiQBmotion)
" vmap iQB <plug>(ViQBmotion)
" omap aQB <plug>(OaQBmotion)
" vmap aQB <plug>(VaQBmotion)

" omap iQr <plug>(OiQrmotion)
" vmap iQr <plug>(ViQrmotion)
" omap aQr <plug>(OaQrmotion)
" vmap aQr <plug>(VaQrmotion)

" omap iQa <plug>(OiQamotion)
" vmap iQa <plug>(ViQamotion)
" omap aQa <plug>(OaQamotion)
" vmap aQa <plug>(VaQamotion)

onoremap <silent>
      \ <plug>(Oifbmotion)
      \ :<c-u>call field#motion(1, 0, '(', ')', ',')<CR>
vnoremap <silent>
      \ <plug>(Vifbmotion)
      \ <esc>:<c-u>call field#motion(1, 1, '(', ')', ',')<CR>
onoremap <silent>
      \ <plug>(Oafbmotion)
      \ :<c-u>call field#motion(0, 0, '(', ')', ',')<CR>
vnoremap <silent>
      \ <plug>(Vafbmotion)
      \ <esc>:<c-u>call field#motion(0, 1, '(', ')', ',')<CR>

onoremap <silent>
      \ <plug>(OifBmotion)
      \ :<c-u>call field#motion(1, 0, '{', '}', ',')<CR>
vnoremap <silent>
      \ <plug>(VifBmotion)
      \ <esc>:<c-u>call field#motion(1, 1, '{', '}', ',')<CR>
onoremap <silent>
      \ <plug>(OafBmotion)
      \ :<c-u>call field#motion(0, 0, '{', '}', ',')<CR>
vnoremap <silent>
      \ <plug>(VafBmotion)
      \ <esc>:<c-u>call field#motion(0, 1, '{', '}', ',')<CR>

onoremap <silent>
      \ <plug>(Oifrmotion)
      \ :<c-u>call field#motion(1, 0, '[', ']', ',')<CR>
vnoremap <silent>
      \ <plug>(Vifrmotion)
      \ <esc>:<c-u>call field#motion(1, 1, '[', ']', ',')<CR>
onoremap <silent>
      \ <plug>(Oafrmotion)
      \ :<c-u>call field#motion(0, 0, '[', ']', ',')<CR>
vnoremap <silent>
      \ <plug>(Vafrmotion)
      \ <esc>:<c-u>call field#motion(0, 1, '[', ']', ',')<CR>

onoremap <silent>
      \ <plug>(Oifamotion)
      \ :<c-u>call field#motion(1, 0, '<', '>', ',')<CR>
vnoremap <silent>
      \ <plug>(Vifamotion)
      \ <esc>:<c-u>call field#motion(1, 1, '<', '>', ',')<CR>
onoremap <silent>
      \ <plug>(Oafamotion)
      \ :<c-u>call field#motion(0, 0, '<', '>', ',')<CR>
vnoremap <silent>
      \ <plug>(Vafamotion)
      \ <esc>:<c-u>call field#motion(0, 1, '<', '>', ',')<CR>

" onoremap <silent>
"       \ <plug>(OiQbmotion)
"       \ :<c-u>call field#motion(1, 0, '(', ')', ';')<CR>
" vnoremap <silent>
"       \ <plug>(ViQbmotion)
"       \ <esc>:<c-u>call field#motion(1, 1, '(', ')', ';')<CR>
" onoremap <silent>
"       \ <plug>(OaQbmotion)
"       \ :<c-u>call field#motion(0, 0, '(', ')', ';')<CR>
" vnoremap <silent>
"       \ <plug>(VaQbmotion)
"       \ <esc>:<c-u>call field#motion(0, 1, '(', ')', ';')<CR>

" onoremap <silent>
"       \ <plug>(OiQBmotion)
"       \ :<c-u>call field#motion(1, 0, '{', '}', ';')<CR>
" vnoremap <silent>
"       \ <plug>(ViQBmotion)
"       \ <esc>:<c-u>call field#motion(1, 1, '{', '}', ';')<CR>
" onoremap <silent>
"       \ <plug>(OaQBmotion)
"       \ :<c-u>call field#motion(0, 0, '{', '}', ';')<CR>
" vnoremap <silent>
"       \ <plug>(VaQBmotion)
"       \ <esc>:<c-u>call field#motion(0, 1, '{', '}', ';')<CR>

" onoremap <silent>
"       \ <plug>(OiQrmotion)
"       \ :<c-u>call field#motion(1, 0, '[', ']', ';')<CR>
" vnoremap <silent>
"       \ <plug>(ViQrmotion)
"       \ <esc>:<c-u>call field#motion(1, 1, '[', ']', ';')<CR>
" onoremap <silent>
"       \ <plug>(OaQrmotion)
"       \ :<c-u>call field#motion(0, 0, '[', ']', ';')<CR>
" vnoremap <silent>
"       \ <plug>(VaQrmotion)
"       \ <esc>:<c-u>call field#motion(0, 1, '[', ']', ';')<CR>

" onoremap <silent>
"       \ <plug>(OiQamotion)
"       \ :<c-u>call field#motion(1, 0, '<', '>', ';')<CR>
" vnoremap <silent>
"       \ <plug>(ViQamotion)
"       \ <esc>:<c-u>call field#motion(1, 1, '<', '>', ';')<CR>
" onoremap <silent>
"       \ <plug>(OaQamotion)
"       \ :<c-u>call field#motion(0, 0, '<', '>', ';')<CR>
" vnoremap <silent>
"       \ <plug>(VaQamotion)
"       \ <esc>:<c-u>call field#motion(0, 1, '<', '>', ';')<CR>
