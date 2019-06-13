function! sickness#textobj#view#motion(mode)
  normal! m'

  if a:mode ==# 'i'
    execute 'keepjumps normal! HVL'

  elseif a:mode ==# 'a'
    1
    normal! V
    $
  endif
endfunction
