function! sickness#textobj#line#motion(mode) abort
  if !empty(getline('.'))
    normal! 

    if a:mode ==# 'i' && match(getline('.'), '\S') !=# -1
      execute 'normal! ^vg_'

    elseif a:mode ==# 'a'
      execute "normal! 0v$\<bs>"
    endif
  endif
endfunction
