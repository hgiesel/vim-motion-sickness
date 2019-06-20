let g:sickness#field#default_openclosedelims =
      \ [ ['parenthesis', 'b', '(', ')']
      \ , ['brace'      , 'B', '{', '}']
      \ , ['bracket'    , 'r', '[', ']']
      \ , ['chevron'    , 'a', '<', '>']
      \ ]

let g:sickness#field#openclosedelims = get(g:, 'sickness#field#maps', g:sickness#field#default_openclosedelims)

let g:sickness#field#default_fielddelims =
      \ [
      \ ['comma', ',']
      \ ]

let g:sickness#field#fielddelims = get(g:, 'sickness#field#delimiters', g:sickness#field#default_fielddelims)

" Fields function {{{1
function! sickness#field#add(openclosedelimdefs, fielddelimdefs) abort
  for l:openclosedelimdef in a:openclosedelimdefs

    if get(g:, 'sickness#field#use_default_maps', v:true) && exists('g:sickness#field#preferred_shortcut_map') " use preferred shortcut map
      let l:theindex = 1

      if g:sickness#field#preferred_shortcut_map ==# 'char'
        let l:theindex = 1
      elseif g:sickness#field#preferred_shortcut_map ==# 'opendelim'
        let l:theindex = 2
      elseif g:sickness#field#preferred_shortcut_map ==# 'closedelim'
        let l:theindex = 3
      endif

      execute 'omap i' . l:openclosedelimdef[l:theindex] . ' <plug>(textobj-sickness-field-' . l:openclosedelimdef[0] . '-i)'
      execute 'xmap i' . l:openclosedelimdef[l:theindex] . ' <plug>(textobj-sickness-field-' . l:openclosedelimdef[0] . '-i)'
      execute 'omap a' . l:openclosedelimdef[l:theindex] . ' <plug>(textobj-sickness-field-' . l:openclosedelimdef[0] . '-a)'
      execute 'xmap a' . l:openclosedelimdef[l:theindex] . ' <plug>(textobj-sickness-field-' . l:openclosedelimdef[0] . '-a)'

      for l:fielddelimdef in a:fielddelimdefs
        execute 'omap if' . l:fielddelimdef[1] . l:openclosedelimdef[l:theindex] . ' <plug>(textobj-sickness-field-' . l:openclosedelimdef[0] . '-' . l:fielddelimdef[0] . '-i)'
        execute 'xmap if' . l:fielddelimdef[1] . l:openclosedelimdef[l:theindex] . ' <plug>(textobj-sickness-field-' . l:openclosedelimdef[0] . '-' . l:fielddelimdef[0] . '-i)'
        execute 'omap af' . l:fielddelimdef[1] . l:openclosedelimdef[l:theindex] . ' <plug>(textobj-sickness-field-' . l:openclosedelimdef[0] . '-' . l:fielddelimdef[0] . '-a)'
        execute 'xmap af' . l:fielddelimdef[1] . l:openclosedelimdef[l:theindex] . ' <plug>(textobj-sickness-field-' . l:openclosedelimdef[0] . '-' . l:fielddelimdef[0] . '-a)'
      endfor

    elseif get(g:, 'sickness#field#use_default_maps', v:true) " use prefix maps
      execute 'omap if' . l:openclosedelimdef[1] . ' <plug>(textobj-sickness-field-' . l:openclosedelimdef[0] . '-i)'
      execute 'xmap if' . l:openclosedelimdef[1] . ' <plug>(textobj-sickness-field-' . l:openclosedelimdef[0] . '-i)'
      execute 'omap af' . l:openclosedelimdef[1] . ' <plug>(textobj-sickness-field-' . l:openclosedelimdef[0] . '-a)'
      execute 'xmap af' . l:openclosedelimdef[1] . ' <plug>(textobj-sickness-field-' . l:openclosedelimdef[0] . '-a)'

      execute 'omap if' . l:openclosedelimdef[2] . ' <plug>(textobj-sickness-field-' . l:openclosedelimdef[0] . '-i)'
      execute 'xmap if' . l:openclosedelimdef[2] . ' <plug>(textobj-sickness-field-' . l:openclosedelimdef[0] . '-i)'
      execute 'omap af' . l:openclosedelimdef[2] . ' <plug>(textobj-sickness-field-' . l:openclosedelimdef[0] . '-a)'
      execute 'xmap af' . l:openclosedelimdef[2] . ' <plug>(textobj-sickness-field-' . l:openclosedelimdef[0] . '-a)'

      execute 'omap if' . l:openclosedelimdef[3] . ' <plug>(textobj-sickness-field-' . l:openclosedelimdef[0] . '-i)'
      execute 'xmap if' . l:openclosedelimdef[3] . ' <plug>(textobj-sickness-field-' . l:openclosedelimdef[0] . '-i)'
      execute 'omap af' . l:openclosedelimdef[3] . ' <plug>(textobj-sickness-field-' . l:openclosedelimdef[0] . '-a)'
      execute 'xmap af' . l:openclosedelimdef[3] . ' <plug>(textobj-sickness-field-' . l:openclosedelimdef[0] . '-a)'

      for l:fielddelimdef in a:fielddelimdefs
        execute 'omap if' . l:fielddelimdef[1] . l:openclosedelimdef[1] . ' <plug>(textobj-sickness-field-' . l:openclosedelimdef[0] . '-' . l:fielddelimdef[0] . '-i)'
        execute 'xmap if' . l:fielddelimdef[1] . l:openclosedelimdef[1] . ' <plug>(textobj-sickness-field-' . l:openclosedelimdef[0] . '-' . l:fielddelimdef[0] . '-i)'
        execute 'omap af' . l:fielddelimdef[1] . l:openclosedelimdef[1] . ' <plug>(textobj-sickness-field-' . l:openclosedelimdef[0] . '-' . l:fielddelimdef[0] . '-a)'
        execute 'xmap af' . l:fielddelimdef[1] . l:openclosedelimdef[1] . ' <plug>(textobj-sickness-field-' . l:openclosedelimdef[0] . '-' . l:fielddelimdef[0] . '-a)'

        execute 'omap if' . l:fielddelimdef[1] . l:openclosedelimdef[2] . ' <plug>(textobj-sickness-field-' . l:openclosedelimdef[0] . '-' . l:fielddelimdef[0] . '-i)'
        execute 'xmap if' . l:fielddelimdef[1] . l:openclosedelimdef[2] . ' <plug>(textobj-sickness-field-' . l:openclosedelimdef[0] . '-' . l:fielddelimdef[0] . '-i)'
        execute 'omap af' . l:fielddelimdef[1] . l:openclosedelimdef[2] . ' <plug>(textobj-sickness-field-' . l:openclosedelimdef[0] . '-' . l:fielddelimdef[0] . '-a)'
        execute 'xmap af' . l:fielddelimdef[1] . l:openclosedelimdef[2] . ' <plug>(textobj-sickness-field-' . l:openclosedelimdef[0] . '-' . l:fielddelimdef[0] . '-a)'

        execute 'omap if' . l:fielddelimdef[1] . l:openclosedelimdef[3] . ' <plug>(textobj-sickness-field-' . l:openclosedelimdef[0] . '-' . l:fielddelimdef[0] . '-i)'
        execute 'xmap if' . l:fielddelimdef[1] . l:openclosedelimdef[3] . ' <plug>(textobj-sickness-field-' . l:openclosedelimdef[0] . '-' . l:fielddelimdef[0] . '-i)'
        execute 'omap af' . l:fielddelimdef[1] . l:openclosedelimdef[3] . ' <plug>(textobj-sickness-field-' . l:openclosedelimdef[0] . '-' . l:fielddelimdef[0] . '-a)'
        execute 'xmap af' . l:fielddelimdef[1] . l:openclosedelimdef[3] . ' <plug>(textobj-sickness-field-' . l:openclosedelimdef[0] . '-' . l:fielddelimdef[0] . '-a)'
      endfor
    endif

    " set textobj plugs
    execute 'onoremap <plug>(textobj-sickness-field-' . l:openclosedelimdef[0] . "-i)"
          \ " <cmd>call sickness#textobj#field#motion(0, 0, '" . l:openclosedelimdef[2] . "', '" . l:openclosedelimdef[3] . "', ',')<cr>"
    execute 'xnoremap <plug>(textobj-sickness-field-' . l:openclosedelimdef[0] . "-i)" .
          \ " <cmd>call sickness#textobj#field#motion(0, 1, '" . l:openclosedelimdef[2] . "', '" . l:openclosedelimdef[3] . "', ',')<cr>"
    execute 'onoremap <plug>(textobj-sickness-field-' . l:openclosedelimdef[0] . "-a)" .
          \ " <cmd>call sickness#textobj#field#motion(1, 0, '" . l:openclosedelimdef[2] . "', '" . l:openclosedelimdef[3] . "', ',')<cr>"
    execute 'xnoremap <plug>(textobj-sickness-field-' . l:openclosedelimdef[0] . "-a)" .
          \ " <cmd>call sickness#textobj#field#motion(1, 1, '" . l:openclosedelimdef[2] . "', '" . l:openclosedelimdef[3] . "', ',')<cr>"

    for l:fielddelimdef in a:fielddelimdefs
      execute 'onoremap <silent> <plug>(textobj-sickness-field-' . l:openclosedelimdef[0] . '-' . l:fielddelimdef[0] . "-i)" .
            \ " <cmd>call sickness#textobj#field#motion(0, 0, '" . l:openclosedelimdef[2] . "', '" . l:openclosedelimdef[3] . "', '" . l:fielddelimdef[1] . "')<cr>"
      execute 'xnoremap <silent> <plug>(textobj-sickness-field-' . l:openclosedelimdef[0] . '-' . l:fielddelimdef[0] . "-i)" .
            \ " <cmd>call sickness#textobj#field#motion(0, 1, '" . l:openclosedelimdef[2] . "', '" . l:openclosedelimdef[3] . "', '" . l:fielddelimdef[1] . "')<cr>"
      execute 'onoremap <silent> <plug>(textobj-sickness-field-' . l:openclosedelimdef[0] . '-' . l:fielddelimdef[0] . "-a)" .
            \ " <cmd>call sickness#textobj#field#motion(1, 0, '" . l:openclosedelimdef[2] . "', '" . l:openclosedelimdef[3] . "', '" . l:fielddelimdef[1] . "')<cr>"
      execute 'xnoremap <silent> <plug>(textobj-sickness-field-' . l:openclosedelimdef[0] . '-' . l:fielddelimdef[0] . "-a)" .
            \ " <cmd>call sickness#textobj#field#motion(1, 1, '" . l:openclosedelimdef[2] . "', '" . l:openclosedelimdef[3] . "', '" . l:fielddelimdef[1] . "')<cr>"
    endfor

  endfor
endfunction
