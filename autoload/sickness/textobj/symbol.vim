" Defining functinos {{{1
function! sickness#textobj#symbol#motion(wrap, symbol) abort
  let l:winsave = winsaveview()
  let l:curpos = getpos('.')

  let l:recdepth = 1
  if mode() ==# 'v'
    while getline('.')[col('.') - 1] ==# a:symbol
      normal! h
      let l:recdepth += 1
    endwhile
  endif

  normal! 
  let l:newcurpos = getpos('.')

  for _ in range(l:recdepth)
    silent! execute 'normal! F' . a:symbol
  endfor

  if getpos('.') == l:newcurpos
    silent! execute 'normal! f' . a:symbol
  endif

  let l:beginpos = getpos('.')

  if !a:wrap
    normal! 1 
  endif

  normal! v
  call setpos('.', l:newcurpos)

  for _ in range(l:recdepth)
    silent! execute 'normal! f' . a:symbol
  endfor

  let l:endpos = getpos('.')

  if !a:wrap
    execute "normal! \<bs>"
  endif

  if l:beginpos == l:endpos
    normal! 
    call winrestview(l:winsave)
    call setpos('.', l:curpos)
  endif
endfunction
