
let g:sickness#symbol#default_maps =
      \ [ ['asterisk', '*']
      \ , ['underscore', '_']
      \ , ['dash', '-']
      \ , ['colon', ':']
      \ , ['at', '@']
      \ , ['bang', '!']
      \ , ['question', '?']
      \ , ['slash', '/']
      \ , ['bar', '<bar>']
      \ ]

let g:sickness#symbol#maps = get(g:, 'sickness#symbol#maps', g:sickness#symbol#default_maps)

" Expression function {{{1
function! sickness#symbol#add(matchpairs)
  for l:pair in a:matchpairs
    execute "onoremap <silent> <plug>(Oi".pair[0]."Symbolmotion) <cmd>call sickness#textobj#symbol#motion(v:false, '".pair[1]."', 'o')<cr>"
    execute "xnoremap <silent> <plug>(Vi".pair[0]."Symbolmotion) <cmd>call sickness#textobj#symbol#motion(v:false, '".pair[1]."', 'v')<cr>"
    execute "onoremap <silent> <plug>(Oa".pair[0]."Symbolmotion) <cmd>call sickness#textobj#symbol#motion(v:true, '".pair[1]."', 'o')<cr>"
    execute "xnoremap <silent> <plug>(Va".pair[0]."Symbolmotion) <cmd>call sickness#textobj#symbol#motion(v:true, '".pair[1]."', 'v')<cr>"

    if get(g:, 'sick_symbol_default_mappings', v:true)
      execute "omap i".pair[1]." <plug>(Oi".pair[0]."Symbolmotion)"
      execute "xmap i".pair[1]." <plug>(Vi".pair[0]."Symbolmotion)"
      execute "omap a".pair[1]." <plug>(Oa".pair[0]."Symbolmotion)"
      execute "xmap a".pair[1]." <plug>(Va".pair[0]."Symbolmotion)"
    endif
  endfor
endfunction
