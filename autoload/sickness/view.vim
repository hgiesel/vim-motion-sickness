function! sickness#view#add() abort
  " Line Setting user mappings {{{1
  if get(g:, 'sickness#view#use_default_maps', v:true)
    omap iv <plug>(textobj-sickness-view-i)
    xmap iv <plug>(textobj-sickness-view-i)
    omap av <plug>(textobj-sickness-view-a)
    xmap av <plug>(textobj-sickness-view-a)
  endif

  " Line Setting plug mappings {{{1
  onoremap <silent> <plug>(textobj-sickness-view-i) <cmd>call sickness#textobj#view#motion('i')<cr>
  xnoremap <silent> <plug>(textobj-sickness-view-i) <cmd>call sickness#textobj#view#motion('i')<cr>
  onoremap <silent> <plug>(textobj-sickness-view-a) <cmd>call sickness#textobj#view#motion('a')<cr>
  xnoremap <silent> <plug>(textobj-sickness-view-a) <cmd>call sickness#textobj#view#motion('a')<cr>
endfunction
