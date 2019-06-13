
let g:sickness#field#default_delimiter =
      \ [
      \ ['comma', ',']
      \ ]

let g:sickness#field#delimiters = get(g:, 'sickness#field#delimiters', g:sickness#field#default_delimiter)

" Fields function {{{1
function! sickness#field#add(bracketdefs, fielddelimdefs)
  for l:bracketdef in a:bracketdefs

    if get(g:, 'sickness#field#use_default_maps', v:true) && exists('g:sickness#field#preferred_shortcut_map') " use preferred shortcut map
      let l:theindex = 1

      if g:sickness#field#preferred_shortcut_map ==# 'char'
        let l:theindex = 1
      elseif g:sickness#field#preferred_shortcut_map ==# 'opendelim'
        let l:theindex = 2
      elseif g:sickness#field#preferred_shortcut_map ==# 'closedelim'
        let l:theindex = 3
      endif

      execute 'omap i' . l:bracketdef[l:theindex] . ' <plug>(textobj-sickness-field-' . l:bracketdef[0] . '-i)'
      execute 'xmap i' . l:bracketdef[l:theindex] . ' <plug>(textobj-sickness-field-' . l:bracketdef[0] . '-i)'
      execute 'omap a' . l:bracketdef[l:theindex] . ' <plug>(textobj-sickness-field-' . l:bracketdef[0] . '-a)'
      execute 'xmap a' . l:bracketdef[l:theindex] . ' <plug>(textobj-sickness-field-' . l:bracketdef[0] . '-a)'

      for l:fielddelimdef in a:fielddelimdefs
        execute 'omap if' . l:fielddelimdef[1] . l:bracketdef[l:theindex] . ' <plug>(textobj-sickness-field-' . l:bracketdef[0] . '-' . l:fielddelimdef[0] . '-i)'
        execute 'xmap if' . l:fielddelimdef[1] . l:bracketdef[l:theindex] . ' <plug>(textobj-sickness-field-' . l:bracketdef[0] . '-' . l:fielddelimdef[0] . '-i)'
        execute 'omap af' . l:fielddelimdef[1] . l:bracketdef[l:theindex] . ' <plug>(textobj-sickness-field-' . l:bracketdef[0] . '-' . l:fielddelimdef[0] . '-a)'
        execute 'xmap af' . l:fielddelimdef[1] . l:bracketdef[l:theindex] . ' <plug>(textobj-sickness-field-' . l:bracketdef[0] . '-' . l:fielddelimdef[0] . '-a)'
      endfor

    elseif get(g:, 'sickness#field#use_default_maps', v:true) " use prefix maps
      execute 'omap if' . l:bracketdef[1] . ' <plug>(textobj-sickness-field-' . l:bracketdef[0] . '-i)'
      execute 'xmap if' . l:bracketdef[1] . ' <plug>(textobj-sickness-field-' . l:bracketdef[0] . '-i)'
      execute 'omap af' . l:bracketdef[1] . ' <plug>(textobj-sickness-field-' . l:bracketdef[0] . '-a)'
      execute 'xmap af' . l:bracketdef[1] . ' <plug>(textobj-sickness-field-' . l:bracketdef[0] . '-a)'

      execute 'omap if' . l:bracketdef[2] . ' <plug>(textobj-sickness-field-' . l:bracketdef[0] . '-i)'
      execute 'xmap if' . l:bracketdef[2] . ' <plug>(textobj-sickness-field-' . l:bracketdef[0] . '-i)'
      execute 'omap af' . l:bracketdef[2] . ' <plug>(textobj-sickness-field-' . l:bracketdef[0] . '-a)'
      execute 'xmap af' . l:bracketdef[2] . ' <plug>(textobj-sickness-field-' . l:bracketdef[0] . '-a)'

      execute 'omap if' . l:bracketdef[3] . ' <plug>(textobj-sickness-field-' . l:bracketdef[0] . '-i)'
      execute 'xmap if' . l:bracketdef[3] . ' <plug>(textobj-sickness-field-' . l:bracketdef[0] . '-i)'
      execute 'omap af' . l:bracketdef[3] . ' <plug>(textobj-sickness-field-' . l:bracketdef[0] . '-a)'
      execute 'xmap af' . l:bracketdef[3] . ' <plug>(textobj-sickness-field-' . l:bracketdef[0] . '-a)'

      for l:fielddelimdef in a:fielddelimdefs
        execute 'omap if' . l:fielddelimdef[1] . l:bracketdef[1] . ' <plug>(textobj-sickness-field-' . l:bracketdef[0] . '-' . l:fielddelimdef[0] . '-i)'
        execute 'xmap if' . l:fielddelimdef[1] . l:bracketdef[1] . ' <plug>(textobj-sickness-field-' . l:bracketdef[0] . '-' . l:fielddelimdef[0] . '-i)'
        execute 'omap af' . l:fielddelimdef[1] . l:bracketdef[1] . ' <plug>(textobj-sickness-field-' . l:bracketdef[0] . '-' . l:fielddelimdef[0] . '-a)'
        execute 'xmap af' . l:fielddelimdef[1] . l:bracketdef[1] . ' <plug>(textobj-sickness-field-' . l:bracketdef[0] . '-' . l:fielddelimdef[0] . '-a)'

        execute 'omap if' . l:fielddelimdef[1] . l:bracketdef[2] . ' <plug>(textobj-sickness-field-' . l:bracketdef[0] . '-' . l:fielddelimdef[0] . '-i)'
        execute 'xmap if' . l:fielddelimdef[1] . l:bracketdef[2] . ' <plug>(textobj-sickness-field-' . l:bracketdef[0] . '-' . l:fielddelimdef[0] . '-i)'
        execute 'omap af' . l:fielddelimdef[1] . l:bracketdef[2] . ' <plug>(textobj-sickness-field-' . l:bracketdef[0] . '-' . l:fielddelimdef[0] . '-a)'
        execute 'xmap af' . l:fielddelimdef[1] . l:bracketdef[2] . ' <plug>(textobj-sickness-field-' . l:bracketdef[0] . '-' . l:fielddelimdef[0] . '-a)'

        execute 'omap if' . l:fielddelimdef[1] . l:bracketdef[3] . ' <plug>(textobj-sickness-field-' . l:bracketdef[0] . '-' . l:fielddelimdef[0] . '-i)'
        execute 'xmap if' . l:fielddelimdef[1] . l:bracketdef[3] . ' <plug>(textobj-sickness-field-' . l:bracketdef[0] . '-' . l:fielddelimdef[0] . '-i)'
        execute 'omap af' . l:fielddelimdef[1] . l:bracketdef[3] . ' <plug>(textobj-sickness-field-' . l:bracketdef[0] . '-' . l:fielddelimdef[0] . '-a)'
        execute 'xmap af' . l:fielddelimdef[1] . l:bracketdef[3] . ' <plug>(textobj-sickness-field-' . l:bracketdef[0] . '-' . l:fielddelimdef[0] . '-a)'
      endfor
    endif

    " set textobj plugs
    execute 'onoremap <plug>(textobj-sickness-field-' . l:bracketdef[0] . "-i)"
          \ " <cmd>call sickness#textobj#field#motion(0, 0, '" . l:bracketdef[2] . "', '" . l:bracketdef[3] . "', ',')<cr>"
    execute 'xnoremap <plug>(textobj-sickness-field-' . l:bracketdef[0] . "-i)" .
          \ " <cmd>call sickness#textobj#field#motion(0, 1, '" . l:bracketdef[2] . "', '" . l:bracketdef[3] . "', ',')<cr>"
    execute 'onoremap <plug>(textobj-sickness-field-' . l:bracketdef[0] . "-a)" .
          \ " <cmd>call sickness#textobj#field#motion(1, 0, '" . l:bracketdef[2] . "', '" . l:bracketdef[3] . "', ',')<cr>"
    execute 'xnoremap <plug>(textobj-sickness-field-' . l:bracketdef[0] . "-a)" .
          \ " <cmd>call sickness#textobj#field#motion(1, 1, '" . l:bracketdef[2] . "', '" . l:bracketdef[3] . "', ',')<cr>"

    for l:fielddelimdef in a:fielddelimdefs
      execute 'onoremap <silent> <plug>(textobj-sickness-field-' . l:bracketdef[0] . '-' . l:fielddelimdef[0] . "-i)" .
            \ " <cmd>call sickness#textobj#field#motion(0, 0, '" . l:bracketdef[2] . "', '" . l:bracketdef[3] . "', '" . l:fielddelimdef[1] . "')<cr>"
      execute 'xnoremap <silent> <plug>(textobj-sickness-field-' . l:bracketdef[0] . '-' . l:fielddelimdef[0] . "-i)" .
            \ " <cmd>call sickness#textobj#field#motion(0, 1, '" . l:bracketdef[2] . "', '" . l:bracketdef[3] . "', '" . l:fielddelimdef[1] . "')<cr>"
      execute 'onoremap <silent> <plug>(textobj-sickness-field-' . l:bracketdef[0] . '-' . l:fielddelimdef[0] . "-a)" .
            \ " <cmd>call sickness#textobj#field#motion(1, 0, '" . l:bracketdef[2] . "', '" . l:bracketdef[3] . "', '" . l:fielddelimdef[1] . "')<cr>"
      execute 'xnoremap <silent> <plug>(textobj-sickness-field-' . l:bracketdef[0] . '-' . l:fielddelimdef[0] . "-a)" .
            \ " <cmd>call sickness#textobj#field#motion(1, 1, '" . l:bracketdef[2] . "', '" . l:bracketdef[3] . "', '" . l:fielddelimdef[1] . "')<cr>"
    endfor

  endfor
endfunction
