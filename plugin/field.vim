" Iq-motions
" `iqb` `aqb`, etc. is used to select parameters (or arguments) within
" braces, very helpful for any kind of programming language

if exists('g:loaded_sick_field') || &compatible || v:version < 700
  finish
endif
let g:loaded_sick_field = 1

" Setting user mappings {{{1
if !exists('g:sick_field_maps')
  let g:sick_field_maps = 'f-prefix'
endif

" Setting user mappings {{{1
" Option 1: f-prefix ib/iB/ir/ia {{{1
if g:sick_field_maps == 'f-prefix'
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

  omap if( <plug>(Oifbmotion)
  vmap if( <plug>(Vifbmotion)
  omap af( <plug>(Oafbmotion)
  vmap af( <plug>(Vafbmotion)

  omap if[ <plug>(Oifrmotion)
  vmap if[ <plug>(Vifrmotion)
  omap af[ <plug>(Oafrmotion)
  vmap af[ <plug>(Vafrmotion)

  omap if{ <plug>(OifBmotion)
  vmap if{ <plug>(VifBmotion)
  omap af{ <plug>(OafBmotion)
  vmap af{ <plug>(VafBmotion)

  omap if< <plug>(Oifamotion)
  vmap if< <plug>(Vifamotion)
  omap af< <plug>(Oafamotion)
  vmap af< <plug>(Vafamotion)

  omap if) <plug>(Oifbmotion)
  vmap if) <plug>(Vifbmotion)
  omap af) <plug>(Oafbmotion)
  vmap af) <plug>(Vafbmotion)

  omap if] <plug>(Oifrmotion)
  vmap if] <plug>(Vifrmotion)
  omap af] <plug>(Oafrmotion)
  vmap af] <plug>(Vafrmotion)

  omap if} <plug>(OifBmotion)
  vmap if} <plug>(VifBmotion)
  omap af} <plug>(OafBmotion)
  vmap af} <plug>(VafBmotion)

  omap if> <plug>(Oifamotion)
  vmap if> <plug>(Vifamotion)
  omap af> <plug>(Oafamotion)
  vmap af> <plug>(Vafamotion)

elseif g:sick_field_maps == 'char'
  omap ib <plug>(Oifbmotion)
  vmap ib <plug>(Vifbmotion)
  omap ab <plug>(Oafbmotion)
  vmap ab <plug>(Vafbmotion)

  omap ir <plug>(Oifrmotion)
  vmap ir <plug>(Vifrmotion)
  omap ar <plug>(Oafrmotion)
  vmap ar <plug>(Vafrmotion)

  omap iB <plug>(OifBmotion)
  vmap iB <plug>(VifBmotion)
  omap aB <plug>(OafBmotion)
  vmap aB <plug>(VafBmotion)

  omap ia <plug>(Oifamotion)
  vmap ia <plug>(Vifamotion)
  omap aa <plug>(Oafamotion)
  vmap aa <plug>(Vafamotion)

elseif g:sick_field_maps == 'opendelim'
  omap i( <plug>(Oifbmotion)
  vmap i( <plug>(Vifbmotion)
  omap a( <plug>(Oafbmotion)
  vmap a( <plug>(Vafbmotion)

  omap i{ <plug>(OifBmotion)
  vmap i{ <plug>(VifBmotion)
  omap a{ <plug>(OafBmotion)
  vmap a{ <plug>(VafBmotion)

  omap i( <plug>(Oifrmotion)
  vmap i( <plug>(Vifrmotion)
  omap a( <plug>(Oafrmotion)
  vmap a( <plug>(Vafrmotion)

  omap i< <plug>(Oifamotion)
  vmap i< <plug>(Vifamotion)
  omap a< <plug>(Oafamotion)
  vmap a< <plug>(Vafamotion)

elseif g:sick_field_maps == 'closedelim'
  omap i) <plug>(Oifbmotion)
  vmap i) <plug>(Vifbmotion)
  omap a) <plug>(Oafbmotion)
  vmap a) <plug>(Vafbmotion)

  omap i} <plug>(OifBmotion)
  vmap i} <plug>(VifBmotion)
  omap a} <plug>(OafBmotion)
  vmap a} <plug>(VafBmotion)

  omap i] <plug>(Oifrmotion)
  vmap i] <plug>(Vifrmotion)
  omap a] <plug>(Oafrmotion)
  vmap a] <plug>(Vafrmotion)

  omap i> <plug>(Oifamotion)
  vmap i> <plug>(Vifamotion)
  omap a> <plug>(Oafamotion)
  vmap a> <plug>(Vafamotion)
endif

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
