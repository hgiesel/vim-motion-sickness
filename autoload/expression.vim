" Defining functions {{{1
function! expression#motion(cur_pos, open_char, close_char, reach)
  let l:recursions  = 1
  let l:winview     = winsaveview()

  " this will only work with 10 recursions, because this could go on forever
  while l:recursions < 10
    " This block makes an assumption to what the qb section may look like with the
    " cursor ending on the end of the selection (how it should be)
    call s:Find_nth_char(l:recursions, a:close_char)
    call s:Make_a_q(a:open_char, a:close_char, a:reach)
    execute 'normal! o'

    if s:Cmp(getpos('v')[1:2], a:cur_pos[1:2]) !=# 1
          \ && s:Cmp(a:cur_pos[1:2], getpos('.')[1:2]) !=# 1
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

function! s:Make_a_q(open_char, close_char, reach)
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
    if col('.') == 1
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
    elseif l:next_char =~ '\v[a-zA-Z0-9_\$\<\>\=\# ]'

      if a:reach ==# 'f'
        " if possible, reach full line, but don't reach beyond ({[<
        " ex. if (hello) { bla; }
        let l:theline_unreversed = getline('.')[0:col('.') - 2] " cut out opendelim of qb match
        let l:theline = join(reverse(split(l:theline_unreversed, '.\zs')), '')
        let l:oldline = ''

        while (l:theline !=# l:oldline)
          let l:oldline = l:theline
          let l:theline = substitute(l:theline, '\%()\(.\{-}\)(\|\]\(.\{-}\)\[\|>\(.\{-}\)<\|}\(.\{-}\){\)', '_\1_', 'g')
        endwhile

        let l:opendelim_pos = match(l:theline, '.*\zs[(\[{<]')
        if l:opendelim_pos == -1
          normal! ^
        else
          let l:opendelim_pos = (len(l:theline) - l:opendelim_pos) + 1
          execute 'normal! '.l:opendelim_pos.'|'
        endif

      elseif a:reach ==# 'W'
        " reach a WORD, but don't reach beyond ({[<
        " ex. foo[bar::baz[arg]]
        let l:theline_unreversed = getline('.')[0:col('.') - 2] " cut out opendelim of qb match
        let l:theline = join(reverse(split(l:theline_unreversed, '.\zs')), '')
        let l:oldline = ''

        while (l:theline !=# l:oldline)
          let l:oldline = l:theline
          let l:theline = substitute(l:theline, '\%()\(.\{-}\)(\|\]\(.\{-}\)\[\|>\(.\{-}\)<\|}\(.\{-}\){\)', '_\1_', 'g')
        endwhile

        " biggest possible occurence of delims
        let l:opendelim_pos = match(l:theline, '.*\zs[(\[{<]')
        " first occurence of space
        let l:space_pos = match(l:theline, ' ')

        if l:opendelim_pos ==# -1
          let l:the_pos = l:space_pos
        elseif l:space_pos ==# -1
          let l:the_pos = l:opendelim_pos
        else
          let l:the_pos = min([l:opendelim_pos, l:space_pos])
        endif

        if l:the_pos == -1
          normal! ^
        else
          let l:the_pos = (len(l:theline) - l:the_pos) + 1
          execute 'normal! '.l:the_pos.'|'
        endif

      else " a:reach ==# 'w'
        normal! b
      endif

      let l:finished = 1
    endif

  endwhile

  return l:invalid
endfunction

function! s:Find_nth_char(n, char)
  if getline('.')[col('.') - 1] !=# a:char
    for i in range(a:n)
      silent! execute "normal! /" . a:char . "\<cr>"
    endfor
  endif

  silent! execute "normal! va" . a:char . "o"
endfunction

" like C {{{2
function! s:Cmp(a, b)
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
