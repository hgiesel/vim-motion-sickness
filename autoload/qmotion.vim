" Defining functions {{{1
function! qmotion#sick_qb_motion(cur_pos, open_char, close_char, reach)
  let l:recursions  = 1
  let l:winview     = winsaveview()

  " this will only work with 10 recursions, because this could go on forever
  while l:recursions < 10
    " This block makes an assumption to what the qb section may look like with the
    " cursor ending on the end of the selection (how it should be)
    call qmotion#sick_find_nth_char(l:recursions, a:close_char)
    call qmotion#sick_make_a_q(a:open_char, a:close_char, a:reach)
    execute 'normal! o'

    if qmotion#sick_cmp(getpos('v')[1:2], a:cur_pos[1:2]) !=# 1
          \ && qmotion#sick_cmp(a:cur_pos[1:2], getpos('.')[1:2]) !=# 1
      " legit qb section: reset window and finish
      call winrestview({'topline':l:winview.topline, 'leftcol':l:winview.leftcol})
      return 0

      " xyz::foo(abc)
    else
      " no legit qb section
      normal! v
      call setpos('.', a:cur_pos)
      let l:recursions += 1
    endif
  endwhile

  " if you've come this far, there is no qb statement
  call winrestview({'topline':l:winview.topline, 'leftcol':l:winview.leftcol})
endfunction

function! qmotion#sick_make_a_q(open_char, close_char, reach)
  let l:invalid = 0
  let l:recursion = 0
  let l:finished  = 0

  while !(l:invalid || l:finished)
    let l:next_char = getline('.')[col('.') - 2]

    " I'll allow an recursion depth of five
    let l:recursion += 1
    if l:recursion ==# 5
      let l:invalid = v:true
    endif

    " A
    " if there is a space or bol to the left of proposed statement, it's
    " no statement
    if l:next_char ==# ' ' || col('.') == 1
      let l:invalid = 1

      " B
      " if character right beside open_char is another closing statement
      " of any kind this one should tried to be embraced as well
    elseif l:next_char =~# '\v[\)\]\}\>]'
      normal! h
      let l:mark_col = col('.')
      normal! %

      if l:mark_col ==# col('.')
        " Can't make it invalid at this point , because it might be >()
        normal! l
      endif

      " C
      " if is enclosed two times by l:open_char, e.g. in bash $((1 + 2))
      " i don't allow q to be enclosed by two non identical characters,
      " like $[( )], cause that would be madness!
    elseif l:next_char ==# a:open_char
      if a:open_char ==# '.'
        let l:finished = 1

      else
        normal! o
        if getline('.')[col('.')] =~# a:close_char
          normal! loh

        else
          let l:invalid = 1
        endif
      endif

      " if character next to such an statement is a character, it is
      " probably its name
    elseif l:next_char =~ '\v[a-zA-Z0-9_]'
      if a:reach ==# 'f'
        " if possible, reach full line, but don't reach beyond ({[<
        " TODO make smart replace thing like in iq
        " ex. if (abc) { function(); }

      elseif a:reach ==# 'W'
        " reach a WORD, but don't reach beyond ({[<
        " TODO make smart replace thing like in iq
        " ex. foo[bar::baz[arg]]
        call search('\m\%(\s\|[(\[<{]\|^\)', 'bW')
        if getpos('.')[2] != 1
          normal! l
        endif
      else " a:reach ==# 'w'
        normal! b
      endif

      let l:finished = 1

      " E
      " for common structures like `$()` `<()` `>()` `=()` `#()`
      " which are found e.g. in shell scripts or jquery or ruby
    elseif l:next_char =~# '\v[\$\<\>\=\#]'
      normal! h
      let l:finished = 1
    endif

  endwhile

  return l:invalid
endfunction

function! qmotion#sick_find_nth_char(n, char)
  if getline('.')[col('.') - 1] !=# a:char
    for i in range(a:n)
      silent! execute "normal! /" . a:char . "\<cr>"
    endfor
  endif

  silent! execute "normal! va" . a:char . "o"
endfunction

" like C {{{2
function! qmotion#sick_cmp(a, b)
  for i in range(len(a:a))
    if a:a[i] < a:b[i]
      return -1

    elseif a:a[i] > a:b[i]
      return 1
    endif
  endfor

  return 0
endfunction

" this function finds the kind of braces you search for, will embrace it and you will
" end op on the left
