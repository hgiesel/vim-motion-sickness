
" Line Setting user mappings {{{1
function sickness#line#add()
  if get(g:, 'sickness#line#use_default_maps', v:true)
    omap il <plug>(textobj-sickness-line-i)
    vmap il <plug>(textobj-sickness-line-i)
    omap al <plug>(textobj-sickness-line-a)
    vmap al <plug>(textobj-sickness-line-a)
  endif

  " Line Setting plug mappings {{{1
  onoremap <silent> <plug>(textobj-sickness-line-i) <cmd>call sickness#textobj#line#motion('i')<cr>
  vnoremap <silent> <plug>(textobj-sickness-line-i) <cmd>call sickness#textobj#line#motion('i')<cr>
  onoremap <silent> <plug>(textobj-sickness-line-a) <cmd>call sickness#textobj#line#motion('a')<cr>
  vnoremap <silent> <plug>(textobj-sickness-line-a) <cmd>call sickness#textobj#line#motion('a')<cr>
endfunction
