" Symbols
"
" `i_`, `a_` and family, which are a lot of motions that work like `ab` or
" `aB` but with symbols
""""

if exists('g:loaded_motion_sickness_symbol') || &compatible || v:version < 700
  finish
endif
let g:loaded_motion_sickness_symbol = 1

let g:sick_symbol_maps = [
      \ ['asterisk', '*'],
      \ ['underscore', '_'],
      \ ['dash', '-'],
      \ ['colon', ':'],
      \ ['at', '@'],
      \ ['bang', '!'],
      \ ['question', '?'],
      \ ['slash', '/'],
      \ ['bar', '<bar>'],
      \ ]

" \ ['percent', '%'],

" Expression function {{{1
function! Symbol_maps_add(matchpairs)
  for l:pair in a:matchpairs
    execute "onoremap <silent> <plug>(Oi".pair[0]."Symbolmotion) :<c-u>call symbol#motion(v:false, '".pair[1]."', 'o')<cr>"
    execute "vnoremap <silent> <plug>(Vi".pair[0]."Symbolmotion) :<c-u>call symbol#motion(v:false, '".pair[1]."', 'v')<cr>"
    execute "onoremap <silent> <plug>(Oa".pair[0]."Symbolmotion) :<c-u>call symbol#motion(v:true, '".pair[1]."', 'o')<cr>"
    execute "vnoremap <silent> <plug>(Va".pair[0]."Symbolmotion) :<c-u>call symbol#motion(v:true, '".pair[1]."', 'v')<cr>"

    execute "omap i".pair[1]." <plug>(Oi".pair[0]."Symbolmotion)"
    execute "vmap i".pair[1]." <plug>(Vi".pair[0]."Symbolmotion)"
    execute "omap a".pair[1]." <plug>(Oa".pair[0]."Symbolmotion)"
    execute "vmap a".pair[1]." <plug>(Va".pair[0]."Symbolmotion)"
  endfor
endfunction

" Function calls {{{1
call Symbol_maps_add(g:sick_symbol_maps)
