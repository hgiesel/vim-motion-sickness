" Defining functions {{{1
" Segment motions (qd, qw, qn)
" make direction and greedy, instead of reach and greedy, that's too much
" a. `qd` `qD` `Qd` `QD` is used to select dot statements, e.g. test().arg[50]
" (default: `.`)
" q works how far it should go left
" d works how far it should go right

" Planned for the future are:
" b. `qn` to select namespace statements std::cout (default: `:`)
" c. `qw` select arrow statements (in C: ->) with `<` characters splattered over
" the place (default: `->`)

" (each of them should be settable)
" foo(abc).def.ghi   d
" abc->def->ghi w
" abc:def:ghi   n

" (each of them should be settable)
" data hello_world :: [String]  h
" var foo = "Hello world!"      e
" key": "value"                 c

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

