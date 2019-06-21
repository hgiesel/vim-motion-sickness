
let g:sickness#indentation#exclude_leading_indents = get(g:, 'sickness#indentation#exclude_leading_indents', v:true)

  " Indentation Setting user mappings {{{1
function! sickness#indentation#add()
  if get(g:, 'sickness#indent#use_default_maps', v:true)
    omap iip <plug>(textobj-sickness-indentation-paragraph-i)
    xmap iip <plug>(textobj-sickness-indentation-paragraph-i)
    omap aip <plug>(textobj-sickness-indentation-paragraph-a)
    xmap aip <plug>(textobj-sickness-indentation-paragraph-a)

    omap iil <plug>(textobj-sickness-indentation-level-i)
    xmap iil <plug>(textobj-sickness-indentation-level-i)
    omap ail <plug>(textobj-sickness-indentation-level-a)
    xmap ail <plug>(textobj-sickness-indentation-level-a)

    omap iib <plug>(textobj-sickness-indentation-block-i)
    xmap iib <plug>(textobj-sickness-indentation-block-i)
    omap aib <plug>(textobj-sickness-indentation-block-a)
    xmap aib <plug>(textobj-sickness-indentation-block-a)

    omap iit <plug>(textobj-sickness-indentation-top-i)
    xmap iit <plug>(textobj-sickness-indentation-top-i)
    omap ait <plug>(textobj-sickness-indentation-top-a)
    xmap ait <plug>(textobj-sickness-indentation-top-a)
  endif

  " Indentation Setting plug mappings {{{1
  onoremap <silent> <plug>(textobj-sickness-indentation-paragraph-i)
        \ <cmd>call sickness#textobj#indentation#motion(v:false, 'p')<cr>
  xnoremap <silent> <plug>(textobj-sickness-indentation-paragraph-i)
        \ <cmd>call sickness#textobj#indentation#motion(v:false, 'p')<cr>
  onoremap <silent> <plug>(textobj-sickness-indentation-paragraph-a)
        \ <cmd>call sickness#textobj#indentation#motion(v:true, 'p')<cr>
  xnoremap <silent> <plug>(textobj-sickness-indentation-paragraph-a)
        \ <cmd>call sickness#textobj#indentation#motion(v:true, 'p')<cr>

  onoremap <silent> <plug>(textobj-sickness-indentation-level-i)
        \ <cmd>call sickness#textobj#indentation#motion(v:false, 'l')<cr>
  xnoremap <silent> <plug>(textobj-sickness-indentation-level-i)
        \ <cmd>call sickness#textobj#indentation#motion(v:false, 'l')<cr>
  onoremap <silent> <plug>(textobj-sickness-indentation-level-a)
        \ <cmd>call sickness#textobj#indentation#motion(v:true, 'l')<cr>
  xnoremap <silent> <plug>(textobj-sickness-indentation-level-a)
        \ <cmd>call sickness#textobj#indentation#motion(v:true, 'l')<cr>

  onoremap <silent> <plug>(textobj-sickness-indentation-block-i)
        \ <cmd>call sickness#textobj#indentation#motion(v:false, 'b')<cr>
  xnoremap <silent> <plug>(textobj-sickness-indentation-block-i)
        \ <cmd>call sickness#textobj#indentation#motion(v:false, 'b')<cr>
  onoremap <silent> <plug>(textobj-sickness-indentation-block-a)
        \ <cmd>call sickness#textobj#indentation#motion(v:true, 'b')<cr>
  xnoremap <silent> <plug>(textobj-sickness-indentation-block-a)
        \ <cmd>call sickness#textobj#indentation#motion(v:true, 'b')<cr>

  onoremap <silent> <plug>(textobj-sickness-indentation-top-i)
        \ <cmd>call sickness#textobj#indentation#motion(v:false, 't')<cr>
  xnoremap <silent> <plug>(textobj-sickness-indentation-top-i)
        \ <cmd>call sickness#textobj#indentation#motion(v:false, 't')<cr>
  onoremap <silent> <plug>(textobj-sickness-indentation-top-a)
        \ <cmd>call sickness#textobj#indentation#motion(v:true, 't')<cr>
  xnoremap <silent> <plug>(textobj-sickness-indentation-top-a)
        \ <cmd>call sickness#textobj#indentation#motion(v:true, 't')<cr>
endfunction
