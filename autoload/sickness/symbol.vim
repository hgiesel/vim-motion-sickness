
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
function! sickness#symbol#add(matchpairs) abort
  for l:pair in a:matchpairs
    execute "onoremap <silent> <plug>(textobj-sickness-symbol-".pair[0]."-i) <cmd>call sickness#textobj#symbol#motion(v:false, '".pair[1]."')<cr>"
    execute "xnoremap <silent> <plug>(textobj-sickness-symbol-".pair[0]."-i) <cmd>call sickness#textobj#symbol#motion(v:false, '".pair[1]."')<cr>"
    execute "onoremap <silent> <plug>(textobj-sickness-symbol-".pair[0]."-a) <cmd>call sickness#textobj#symbol#motion(v:true, '".pair[1]."')<cr>"
    execute "xnoremap <silent> <plug>(textobj-sickness-symbol-".pair[0]."-a) <cmd>call sickness#textobj#symbol#motion(v:true, '".pair[1]."')<cr>"

    if get(g:, 'sick_symbol_default_mappings', v:true)
      execute "omap i".pair[1]." <plug>(textobj-sickness-symbol-".pair[0]."-i)"
      execute "xmap i".pair[1]." <plug>(textobj-sickness-symbol-".pair[0]."-i)"
      execute "omap a".pair[1]." <plug>(textobj-sickness-symbol-".pair[0]."-a)"
      execute "xmap a".pair[1]." <plug>(textobj-sickness-symbol-".pair[0]."-a)"
    endif
  endfor
endfunction
