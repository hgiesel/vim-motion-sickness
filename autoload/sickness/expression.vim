" Expression function {{{1
function! sickness#expression#add(bracketdefs)
  for l:bracketdef in a:bracketdefs

    if get(g:, 'sickness#expression#use_default_maps', v:true) && exists('g:sickness#expression#preferred_shortcut_map') " use shortcut map
      let l:theindex = 1

      if g:sickness#expression#preferred_default_maps ==# 'char'
        let l:theindex = 1
      elseif g:sickness#expression#preferred_default_maps ==# 'opendelim'
        let l:theindex = 2
      elseif g:sickness#expression#preferred_default_maps ==# 'closedelim'
        let l:theindex = 3
      endif

      execute 'omap ie' . l:bracketdef[l:theindex] . ' <plug>(textobj-sickness-expression-' . l:bracketdef[0] . '-i)'
      execute 'xmap ie' . l:bracketdef[l:theindex] . ' <plug>(textobj-sickness-expression-' . l:bracketdef[0] . '-i)'
      execute 'omap ae' . l:bracketdef[l:theindex] . ' <plug>(textobj-sickness-expression-' . l:bracketdef[0] . '-a)'
      execute 'xmap ae' . l:bracketdef[l:theindex] . ' <plug>(textobj-sickness-expression-' . l:bracketdef[0] . '-a)'

    elseif get(g:, 'sickness#expression#use_default_maps', v:true) " use prefix maps
      execute 'omap ie' . l:bracketdef[1] . ' <plug>(textobj-sickness-expression-' . l:bracketdef[0] . '-i)'
      execute 'xmap ie' . l:bracketdef[1] . ' <plug>(textobj-sickness-expression-' . l:bracketdef[0] . '-i)'
      execute 'omap ae' . l:bracketdef[1] . ' <plug>(textobj-sickness-expression-' . l:bracketdef[0] . '-a)'
      execute 'xmap ae' . l:bracketdef[1] . ' <plug>(textobj-sickness-expression-' . l:bracketdef[0] . '-a)'

      execute 'omap ie' . l:bracketdef[2] . ' <plug>(textobj-sickness-expression-' . l:bracketdef[0] . '-i)'
      execute 'xmap ie' . l:bracketdef[2] . ' <plug>(textobj-sickness-expression-' . l:bracketdef[0] . '-i)'
      execute 'omap ae' . l:bracketdef[2] . ' <plug>(textobj-sickness-expression-' . l:bracketdef[0] . '-a)'
      execute 'xmap ae' . l:bracketdef[2] . ' <plug>(textobj-sickness-expression-' . l:bracketdef[0] . '-a)'

      execute 'omap ie' . l:bracketdef[3] . ' <plug>(textobj-sickness-expression-' . l:bracketdef[0] . '-i)'
      execute 'xmap ie' . l:bracketdef[3] . ' <plug>(textobj-sickness-expression-' . l:bracketdef[0] . '-i)'
      execute 'omap ae' . l:bracketdef[3] . ' <plug>(textobj-sickness-expression-' . l:bracketdef[0] . '-a)'
      execute 'xmap ae' . l:bracketdef[3] . ' <plug>(textobj-sickness-expression-' . l:bracketdef[0] . '-a)'
    endif

    " set textobj plugs
    execute "onoremap <silent> <plug>(textobj-sickness-expression-" . l:bracketdef[0] . "-i) " .
          \ "<cmd>call sickness#textobj#expression#motion('" . l:bracketdef[2] . "', '" . l:bracketdef[3] . "', 'W')<cr>"
    execute "xnoremap <silent> <plug>(textobj-sickness-expression-" . l:bracketdef[0] . "-i) " .
          \ "<cmd>call sickness#textobj#expression#motion('" . l:bracketdef[2] . "', '" . l:bracketdef[3] . "', 'W')<cr>"
    execute "xnoremap <silent> <plug>(textobj-sickness-expression-" . l:bracketdef[0] . "-a) " .
          \ "<cmd>call sickness#textobj#expression#motion('" . l:bracketdef[2] . "', '" . l:bracketdef[3] . "', 'f')<cr>"
    execute "onoremap <silent> <plug>(textobj-sickness-expression-" . l:bracketdef[0] . "-a) " .
          \ "<cmd>call sickness#textobj#expression#motion('" . l:bracketdef[2] . "', '" . l:bracketdef[3] . "', 'f')<cr>"

  endfor
endfunction
