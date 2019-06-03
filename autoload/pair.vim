" Defining functions {{{1
function! pair#sick_qe_motion(cur_pos, char, front)
  let l:invalid = v:false
  let l:cur_col = line('.')
  normal! 0

  " find char
  if search(a:char) != l:cur_col
    let l:invalid = v:true
  endif

  if !l:invalid
    " select chars in front or after chars,
    " depending on argument
    if a:front
      call search('\S', 'b')
      normal! v^
    else
      call search(a:char, 'ce')
      call search('\S')
      normal! v$
    endif

  else
    call setpos(a:cur_pos)
  endif
endfunction

