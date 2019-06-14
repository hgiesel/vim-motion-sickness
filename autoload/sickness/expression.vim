" Expression function {{{1

let g:sickness#expression#default_openclosedelims =
      \ [ ['parenthesis', 'b', '(', ')']
      \ , ['brace'      , 'B', '{', '}']
      \ , ['bracket'    , 'r', '[', ']']
      \ , ['chevron'    , 'a', '<', '>']
      \ ]

let g:sickness#expression#openclosedelims = get(g:, 'sickness#expression#openclosedelim', g:sickness#expression#default_openclosedelims)

function! sickness#expression#add(openclosedelimdefs)
  for l:openclosedelimdef in a:openclosedelimdefs

    if get(g:, 'sickness#expression#use_default_maps', v:true) && exists('g:sickness#expression#preferred_shortcut_map') " use shortcut map
      let l:theindex = 1

      if g:sickness#expression#preferred_shortcut_map ==# 'char'
        let l:theindex = 1
      elseif g:sickness#expression#preferred_shortcut_map ==# 'opendelim'
        let l:theindex = 2
      elseif g:sickness#expression#preferred_shortcut_map ==# 'closedelim'
        let l:theindex = 3
      endif

      execute 'omap ie' . l:openclosedelimdef[l:theindex] . ' <plug>(textobj-sickness-expression-' . l:openclosedelimdef[0] . '-i)'
      execute 'xmap ie' . l:openclosedelimdef[l:theindex] . ' <plug>(textobj-sickness-expression-' . l:openclosedelimdef[0] . '-i)'
      execute 'omap ae' . l:openclosedelimdef[l:theindex] . ' <plug>(textobj-sickness-expression-' . l:openclosedelimdef[0] . '-a)'
      execute 'xmap ae' . l:openclosedelimdef[l:theindex] . ' <plug>(textobj-sickness-expression-' . l:openclosedelimdef[0] . '-a)'

    elseif get(g:, 'sickness#expression#use_default_maps', v:true) " use prefix maps
      execute 'omap ie' . l:openclosedelimdef[1] . ' <plug>(textobj-sickness-expression-' . l:openclosedelimdef[0] . '-i)'
      execute 'xmap ie' . l:openclosedelimdef[1] . ' <plug>(textobj-sickness-expression-' . l:openclosedelimdef[0] . '-i)'
      execute 'omap ae' . l:openclosedelimdef[1] . ' <plug>(textobj-sickness-expression-' . l:openclosedelimdef[0] . '-a)'
      execute 'xmap ae' . l:openclosedelimdef[1] . ' <plug>(textobj-sickness-expression-' . l:openclosedelimdef[0] . '-a)'

      execute 'omap ie' . l:openclosedelimdef[2] . ' <plug>(textobj-sickness-expression-' . l:openclosedelimdef[0] . '-i)'
      execute 'xmap ie' . l:openclosedelimdef[2] . ' <plug>(textobj-sickness-expression-' . l:openclosedelimdef[0] . '-i)'
      execute 'omap ae' . l:openclosedelimdef[2] . ' <plug>(textobj-sickness-expression-' . l:openclosedelimdef[0] . '-a)'
      execute 'xmap ae' . l:openclosedelimdef[2] . ' <plug>(textobj-sickness-expression-' . l:openclosedelimdef[0] . '-a)'

      execute 'omap ie' . l:openclosedelimdef[3] . ' <plug>(textobj-sickness-expression-' . l:openclosedelimdef[0] . '-i)'
      execute 'xmap ie' . l:openclosedelimdef[3] . ' <plug>(textobj-sickness-expression-' . l:openclosedelimdef[0] . '-i)'
      execute 'omap ae' . l:openclosedelimdef[3] . ' <plug>(textobj-sickness-expression-' . l:openclosedelimdef[0] . '-a)'
      execute 'xmap ae' . l:openclosedelimdef[3] . ' <plug>(textobj-sickness-expression-' . l:openclosedelimdef[0] . '-a)'
    endif

    " set textobj plugs
    execute "onoremap <silent> <plug>(textobj-sickness-expression-" . l:openclosedelimdef[0] . "-i) " .
          \ "<cmd>call sickness#textobj#expression#motion('" . l:openclosedelimdef[2] . "', '" . l:openclosedelimdef[3] . "', 'b')<cr>"
    execute "xnoremap <silent> <plug>(textobj-sickness-expression-" . l:openclosedelimdef[0] . "-i) " .
          \ "<cmd>call sickness#textobj#expression#motion('" . l:openclosedelimdef[2] . "', '" . l:openclosedelimdef[3] . "', 'b')<cr>"
    execute "xnoremap <silent> <plug>(textobj-sickness-expression-" . l:openclosedelimdef[0] . "-a) " .
          \ "<cmd>call sickness#textobj#expression#motion('" . l:openclosedelimdef[2] . "', '" . l:openclosedelimdef[3] . "', 'B')<cr>"
    execute "onoremap <silent> <plug>(textobj-sickness-expression-" . l:openclosedelimdef[0] . "-a) " .
          \ "<cmd>call sickness#textobj#expression#motion('" . l:openclosedelimdef[2] . "', '" . l:openclosedelimdef[3] . "', 'B')<cr>"

  endfor
endfunction
