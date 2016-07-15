" z Add some lines which don't do anything cause they are comments And some more
" This plugin adds a lot of motion mappings. Here's a list
"
" 1. `ir`, `ar`, `ia`, and `aa` where `r` and `a` are aliases for `[` and `<`
"  (similiar to tpopes' vim-surround plugin
"
"
"
"  Symbol aliases
"
" 2. `i_`, `a_` and family, which are a lot of motions that work like `ab` or
"  `aB` but with symbols
"
" 3. `qb` `qB` `qr` `qa` which are motions that select statements, e.g.
"  foo(500 + 500))o)o
"  while you would use `ib` to select everything within the parentheses and
"  `ab` to select the whole parenthesis, you can use `qb` to use the whole
"  parenthesis and the word before it. Also works with $(( )) or similiar
"  things
"
" 4. `iqb` `aqb`, etc. is used to select parameters (or arguments) within
"  braces, very helpful for any kind of programming language
" 5. `qd` `qD` `Qd` `QD` is used to select dot statements, e.g. test().arg[50]
"
"  Planned for the future are: `qc` to select colon statements; `qw` to
"  select arrow statements (in C) and to make iqb and qb work correctly with
"  `<` characters splattered over the place

" Util functions {{{1
" CAUTION sick_cursor_between_cursors(a, b, c) is NOT the same as
" sick_cursor_between_cursors(a, c, b)

if exists('g:loaded_motion_sickness') || &compatible || v:version < 700
  finish
endif
let g:loaded_motion_sickness = 1

function! s:sick_cursor_in(thecursor, a, b)
  return s:sick_cmp(a:a, a:thecursor) ==# -1 && s:sick_cmp(a:thecursor, a:b) ==# -1
endfunction

function! s:sick_cursor_in_or_on(thecursor, a, b)
  return s:sick_cursor_in(a:thecursor, a:a, a:b) ||
        \ s:sick_cmp(a:a, a:thecursor) ==# 0 && s:sick_cmp(a:thecursor, a:b) ==# 0
endfunction

" like C
function! s:sick_cmp(a, b)
  for i in range(len(a:a))
    if a:a[i] < a:b[i]
      return -1

    elseif a:b[i] > a:a[i]
      return 1
    endif
  endfor

  return 0
endfunction

function! s:sick_find_nth_char(n, char)
  if getline('.')[col('.')-1] !=# a:char
    for i in range(a:n)
      silent! execute "normal! /" . a:char . "\<cr>"
    endfor
  endif

  silent! execute "normal! va" . a:char . "o"
endfunction
" }}}1

" Alias Motion {{{1
function! s:sick_alias_motions_add(char_from, char_to)
  for arg in ['i', 'a']
    for mapping in ['o', 'v']
      execute mapping . 'noremap <silent> ' . arg . a:char_from .
            \ ' ' . arg . a:char_to
    endfor
  endfor
endfunction

call s:sick_alias_motions_add('a', '<')
call s:sick_alias_motions_add('r', '[')
" }}}1

" Symbol Motion {{{1
function! s:sick_symbol_motion_v(wrap, symbol)
  " position on the left when you started
  let l:start_pos = getpos('.')
  " position on the right when you started
  let l:end_pos   = getpos("'>")

  " Go to close position
  call setpos('.', l:start_pos)
  if a:symbol ==# '?'
    silent! execute 'normal! ?\\' . a:symbol . ''

  else
    silent! execute 'normal! ?' . a:symbol . ''
  endif

  if a:wrap ==# 'i'
    execute "normal! 1 "
  endif
  let l:open_pos = getpos('.')

  " Go to open position
  silent! execute 'normal! v'
  call setpos('.', l:end_pos)

  silent! execute 'normal! /' . a:symbol . ''
  if a:wrap ==# 'i'
    execute "normal! \<bs>"
  endif
  let l:close_pos = getpos('.')

  " Go back if no valid selection
  if !(s:sick_cmp(l:open_pos, l:end_pos) ==# -1 ||
        \ s:sick_cmp(l:end_pos, l:close_pos) ==# -1)
    normal! v
    call setpos('.', l:start_pos)
  end
endfunction

function! s:sick_symbol_motion_o(wrap, symbol)
  let l:start_pos = getpos('.')

  " Go to close position
  " Special treatment for question mark
  if a:symbol ==# '?'
    silent! execute "normal! ?\\" . a:symbol . "\<cr>"

  else
    silent! execute "normal! ?" . a:symbol . "\<cr>"
  endif
  let l:open_pos = getpos('.')

  if a:wrap ==# 'i'
    silent! execute "normal! 1 "

    " if you only moved one space, go back, but only if you started on a:symbol
    if s:sick_cmp(getpos('.'), l:start_pos) ==# 0 &&
          \ getline('.')[col('.') - 1] ==# a:symbol
      silent! execute "normal! \<bs>"
    endif
  endif

  " Go to open position
  silent! execute "normal! v/" . a:symbol . "\<cr>"
  let l:close_pos = getpos('.')

  if a:wrap ==# 'i'
    execute "normal! \<bs>"
  endif

  " Go back if no valid selection
  if a:wrap ==# 'i'
    if !(s:sick_cmp(l:open_pos, l:start_pos) ==# -1 &&
          \ s:sick_cmp(l:start_pos, l:close_pos) ==# -1)
      normal! v
      call setpos('.', l:start_pos)
    else
      normal! o
    end
  end
endfunction

function! s:sick_symbol_motion_add(symbol)
  for wrap in ['i', 'a']
      silent! execute  "onoremap <silent> " . wrap . a:symbol . " :\<c-u>call " .
        \ "<sid>sick_symbol_motion_o('" . wrap . "', '" . a:symbol . "')\<cr>"
      silent! execute  "vnoremap <silent> " . wrap . a:symbol . " :\<c-u>call " .
        \ "<sid>sick_symbol_motion_v('" . wrap . "', '" . a:symbol . "')\<cr>"
  endfor
endfunction

let g:sick_symbol_motion_chars =
      \ ['*', '_', '-', ':', '@', '!', '?', '/', "<bar>"]

for char in g:sick_symbol_motion_chars
  call s:sick_symbol_motion_add(char)
endfor
" }}}1

" qb Motion {{{1
function! s:sick_make_a_q(open_char, close_char, reach)
  let l:invalid = 0
  let l:recursion = 0
  let l:finished  = 0

  while !l:invalid && !l:finished && l:recursion < 5
    let l:next_char = getline('.')[col('.') - 2]
    let l:recursion += 1

    " if there is a space or bol to the left of proposed statement, it's
    " no statement
    if l:next_char ==# ' ' || col('.') == 1
      let l:invalid = 1

      " if character right beside open_char is another closing statement
      " of any kind this one should be embraced as well
    elseif l:next_char =~# '\v[\)\]\}\>]'
      normal! h
      let l:mark_col = col('.')
      normal! %

      if l:mark_col ==# col('.')
        normal! l
      endif

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
      if a:reach
        normal! B

      else
        normal! b
      endif

      let l:finished = 1

      " for common structures like `$()` `<()` `>()` `=()`
      " which are found e.g. in shell scripts or jquery
    elseif l:next_char =~# '\v[\$\<\>\=]'
      normal! h
      let l:finished = 1
    endif

  endwhile

  return l:invalid
endfunction

function! s:sick_qb_motion_v(cur_pos, open_char, close_char, reach)
  let l:repetitions = 1
  let l:winview = winsaveview()

  " this checks if the cursor is inside the name of the statement
  " e.g. `fo|o(55)` where `|` is the cursor
  " this will only work with 10 recursions, because this could go on forever
  while l:repetitions < 10
    call s:sick_find_nth_char(l:repetitions,a:close_char)
    call s:sick_make_a_q(a:open_char,a:close_char,a:reach)
    execute 'normal! o'

    if !s:sick_cursor_in(a:cur_pos, getpos('v'), getpos('.'))
      normal! v
      call setpos('.',a:cur_pos)
      let l:repetitions += 1

    else
      call winrestview({'topline':l:winview.topline,
            \ 'leftcol':l:winview.leftcol})
      return 0
    endif
  endwhile

  " if the function has come this far, it is assumed that the cursor is
  " inside the braces of the statement (and not the name)
  silent! execute "normal! va".a:open_char

  " if there is no statement under your cursor, `make_a_q()` would
  " unnecessarily change your cursor position
  if mode(0) == 'v'
    silent! execute "normal! o"
    call s:sick_make_a_q(a:open_char,a:close_char,a:reach)
    call winrestview({'topline':l:winview.topline,
          \ 'leftcol':l:winview.leftcol})
  endif
endfunction

function! s:sick_qb_motion_o(cur_pos, open_char, close_char, reach)
  let l:repetitions = 1
  let l:winview = winsaveview()

  " this checks if the cursor is inside the name of the statement
  " e.g. `fo|o(55)` where `|` is the cursor
  " this will only work with 10 recursions, because this could go on forever
  while l:repetitions < 10
    call s:sick_find_nth_char(l:repetitions,a:close_char)
    call s:sick_make_a_q(a:open_char,a:close_char,a:reach)
    execute 'normal! o'

    if !s:sick_cursor_in(a:cur_pos, getpos('v'), getpos('.'))
      normal! v
      call setpos('.',a:cur_pos)
      let l:repetitions += 1

    else
      call winrestview({'topline':l:winview.topline,
            \ 'leftcol':l:winview.leftcol})
      return 0
    endif
  endwhile

  " if the function has come this far, it is assumed that the cursor is
  " inside the braces of the statement (and not the name)
  silent! execute "normal! va".a:open_char

  " if there is no statement under your cursor, `make_a_q()` would
  " unnecessarily change your cursor position
  if mode(0) == 'v'
    silent! execute "normal! o"
    call s:sick_make_a_q(a:open_char,a:close_char,a:reach)
    call winrestview({'topline':l:winview.topline,
          \ 'leftcol':l:winview.leftcol})
  endif
endfunction

function! s:sick_qb_motion_add(synonym, open_char, close_char)
  for reach in ['q', 'Q']
    execute "onoremap <silent> " . reach . a:synonym . " :\<c-u>call <sid>" .
          \ "sick_qb_motion_o(getpos('.'), '" . a:open_char . "', '" .
          \ a:close_char . "', '" . reach . "')\<cr>"
    execute "vnoremap <silent> " . reach . a:synonym . " :\<c-u>call <sid>" .
          \ "sick_qb_motion_v(getpos('.'), '" . a:open_char . "', '" .
          \ a:close_char . "', '" . reach . "')\<cr>"
  endfor
endfunction

call s:sick_qb_motion_add('b', '(', ')')
call s:sick_qb_motion_add('B', '{', '}')
call s:sick_qb_motion_add('r', '[', ']')
call s:sick_qb_motion_add('a', '<', '>')

call s:sick_qb_motion_add('(', '(', ')')
call s:sick_qb_motion_add('{', '{', '}')
call s:sick_qb_motion_add('[', '[', ']')
call s:sick_qb_motion_add('<', '<', '>')
" }}}1

" qd Motion {{{1
" make direction and greedy, instead of reach and greedy, that's too much
function! s:qd_motion(cur_pos,chars,reach,greedy)
  let l:invalid      = 0
  let l:finished       = 0
  let l:dot_was_found    = 0
  let l:made_an_assumption = 0
  let l:fall_back_braces   = [0,0]
  let l:invalid_chars    = '\v[ \;]'
  let l:cursor_char = getline('.')[col('.') - 1]

  if l:cursor_char =~# '\v[\(\)\[\]\{\}\<\>]'
    execute "normal! f".a:chars
    if getline('.')[col('.') - 1] !=# a:chars
      let l:invalid = 1

    else
      if s:sick_make_a_q(a:chars,a:chars,a:reach) ==# 1
        let l:invalid = 1

      else
        normal! o
        let l:dot_was_found = 1
      endif
    endif

  elseif l:cursor_char =~# '\V'.a:chars
    normal! v

    if s:sick_make_a_q(a:chars,a:chars,a:reach) ==# 1
      let l:invalid = 1

    else
      normal! o
      let l:dot_was_found = 1
    endif

  else
    silent! normal! viw
  endif

  if a:reach && !l:invalid
    silent! normal! oBo
  endif

  " plus::foo(a + minus::arg(55)).test
  while !l:invalid && !l:finished
    if col('.') !=# col('$')
      let l:next_char = getline('.')[col('.')]
    endif

    " if character to the right is alpha, it's probably identifer of the
    " next element
    if l:next_char =~# '\v[a-zA-Z_]'
      silent! normal! e

      " if character to the right is opening brace, enclose that brace
    elseif l:next_char =~# '\v[\(\{\[\<]'
      let l:a_pos = getpos('.')
      silent! normal! l%

      " it must be a broken brace, abort
      if l:a_pos ==# getpos('.')
        let l:invalid = 1
      endif

      " if the closing braces come at the start, there's a possibility,
      " the statement is inside these braces, e.g. `foo(b|ar()).test`
      " with `|` being the cursor.
      " After the first jump, there's no possibility of this anymore,
      " e.g. foo(foobar.test).test
    elseif l:next_char =~# '\v[\)\}\]\>]'
      if l:dot_was_found && !a:greedy
        let l:finished    = 1

      else
        if l:made_an_assumption ==# 0
          let l:fall_back_braces = [getpos('v'),getpos('.')]
        endif

        let l:made_an_assumption = 1
        silent! normal! lvv%

        if a:reach
          silent! normal! B

        else
          silent! normal! b
        endif

        silent! normal! o
      endif

      " dot was found!!1
    elseif l:next_char =~# '\V'.a:chars
      if getline('.')[col('.') + 1] =~# '\v[A-Za-z_\$]'
        if l:dot_was_found && !a:greedy
          let l:finished    = 1

        else
          silent! normal! le
          let l:dot_was_found = 1
        endif

        let l:made_an_assumption = 0

      else
        let l:invalid = 1
      endif

      " found a closing character or at the end of the current line
    else " l:next_char =~# l:invalid_chars || col('.') + 1 ==# col('$')
      if l:dot_was_found
        let l:finished = 1

        if l:made_an_assumption
          normal! v
          call setpos('.',l:fall_back_braces[0])
          normal! v
          call setpos('.',l:fall_back_braces[1])
        endif

      else
        let l:invalid  = 1
      endif
    endif
  endwhile

  if l:invalid
    normal! v
    call setpos('.',a:cur_pos)
  endif
endfunction

onoremap <silent> qd :<c-u>call <sid>qd_motion(getpos('.'),'.',0,0)<cr>
onoremap <silent> qD :<c-u>call <sid>qd_motion(getpos('.'),'.',0,1)<cr>
onoremap <silent> Qd :<c-u>call <sid>qd_motion(getpos('.'),'.',1,0)<cr>
onoremap <silent> QD :<c-u>call <sid>qd_motion(getpos('.'),'.',1,1)<cr>

vnoremap <silent> qd :<c-u>call <sid>qd_motion(getpos('.'),'.',0,0)<cr>
vnoremap <silent> qD :<c-u>call <sid>qd_motion(getpos('.'),'.',0,1)<cr>
vnoremap <silent> Qd :<c-u>call <sid>qd_motion(getpos('.'),'.',1,0)<cr>
vnoremap <silent> QD :<c-u>call <sid>qd_motion(getpos('.'),'.',1,1)<cr>

function! s:brace_dict_matches(brace_dict)
  if a:brace_dict['(']    ==# a:brace_dict[')'] &&
        \ a:brace_dict['[']   ==# a:brace_dict[']'] &&
        \ a:brace_dict['{']   ==# a:brace_dict['}'] &&
        \ a:brace_dict['<']   ==# a:brace_dict['>'] &&
        \ a:brace_dict['"'] % 2 ==# 0         &&
        \ a:brace_dict["'"] % 2 ==# 0
    return 1
  endif

  return 0
endfunction
" }}}1

" iqb Motion {{{1
function! s:iq_motion(curpos,open_ch,close_ch,delim,inner)
  let l:finished     = 0

  " these behave special, because of the braces
  let l:brace_dict   = {'(':0,')':0,'{':0,'}':0,'[':0,']':0,
        \ '<':0,'>':0, "'":0,'"':0}
  let l:search_char = a:delim

  silent! execute "normal! va".a:open_ch
  let l:abs_endpos = getpos('.')

  if l:abs_endpos ==# a:curpos
    return 0
  endif

  normal! o
  let l:round = 0

  while !l:finished
    let l:round += 1

    let l:brace_dict['('] = 0
    let l:brace_dict[')'] = 0
    let l:brace_dict['['] = 0
    let l:brace_dict[']'] = 0
    let l:brace_dict['{'] = 0
    let l:brace_dict['}'] = 0
    let l:brace_dict['<'] = 0
    let l:brace_dict['>'] = 0
    let l:brace_dict['"'] = 0
    let l:brace_dict["'"] = 0

    let l:startpos = getpos('.')
    silent! execute "normal! vv"

    let l:found_next_delim = 0
    while !l:found_next_delim
      let l:a_char = getline('.')[col('.')]

      let l:searchpos    = getpos('.')
      let l:searchpos[2] += 1

      if l:searchpos ==# l:abs_endpos
        let l:search_char = a:close_ch
      endif

      if l:a_char ==# l:search_char &&
            \ s:brace_dict_matches(l:brace_dict)
        let l:found_next_delim = 1

      elseif l:a_char ==# '('
        let l:brace_dict['('] += 1

      elseif l:a_char ==# ')'
        let l:brace_dict[')'] += 1

      elseif l:a_char ==# '['
        let l:brace_dict['['] += 1

      elseif l:a_char ==# ']'
        let l:brace_dict[']'] += 1

      elseif l:a_char ==# '{'
        let l:brace_dict['{'] += 1

      elseif l:a_char ==# '}'
        let l:brace_dict['}'] += 1

        " this needs to work with `->` and all the comparisons in
        " order to be functional
        " elseif l:a_char ==# '<'
        "   let l:brace_dict['<'] += 1
        " elseif l:a_char ==# '>'
        "   let l:brace_dict['>'] += 1
      elseif l:a_char ==# '"'
        let l:brace_dict['"'] += 1

      elseif l:a_char ==# "'"
        let l:brace_dict["'"] += 1
      endif

      execute "normal! 1 "
    endwhile

    let l:endpos = getpos('.')

    if s:sick_cursor_onbetween_cursors(a:curpos, l:startpos, l:endpos)
      let l:finished = 1
    endif
  endwhile

  if a:inner
    silent! execute "normal! ?\\v[^ \\n\\\\]\<cr>o/\\v[^ \\n\\\\]\<cr>"

  else
    if l:round ==# 1
      silent! execute "normal! o/\\v[^ \\n\\\\]\<cr>o"

    else
      silent! execute "normal! ?\\v[^ \\n\\\\]\<cr>"
    endif
  endif
endfunction

onoremap <silent> iqb :<c-u>call <sid>iq_motion(getpos('.'), '(', ')', ',', 1)<cr>
onoremap <silent> iqB :<c-u>call <sid>iq_motion(getpos('.'), '{', '}', ',', 1)<cr>
onoremap <silent> iqr :<c-u>call <sid>iq_motion(getpos('.'), '[', ']', ',', 1)<cr>
onoremap <silent> iqa :<c-u>call <sid>iq_motion(getpos('.'), '<', '>', ',', 1)<cr>

onoremap <silent> iQb :<c-u>call <sid>iq_motion(getpos('.'), '(', ')', ';', 1)<cr>
onoremap <silent> iQB :<c-u>call <sid>iq_motion(getpos('.'), '{', '}', ';', 1)<cr>
onoremap <silent> iQr :<c-u>call <sid>iq_motion(getpos('.'), '[', ']', ';', 1)<cr>
onoremap <silent> iQa :<c-u>call <sid>iq_motion(getpos('.'), '<', '>', ';', 1)<cr>

onoremap <silent> aqb :<c-u>call <sid>iq_motion(getpos('.'), '(', ')', ',', 0)<cr>
onoremap <silent> aqB :<c-u>call <sid>iq_motion(getpos('.'), '{', '}', ',', 0)<cr>
onoremap <silent> aqr :<c-u>call <sid>iq_motion(getpos('.'), '[', ']', ',', 0)<cr>
onoremap <silent> aqa :<c-u>call <sid>iq_motion(getpos('.'), '<', '>', ',', 0)<cr>

onoremap <silent> aQb :<c-u>call <sid>iq_motion(getpos('.'), '(', ')', ';', 0)<cr>
onoremap <silent> aQB :<c-u>call <sid>iq_motion(getpos('.'), '{', '}', ';', 0)<cr>
onoremap <silent> aQr :<c-u>call <sid>iq_motion(getpos('.'), '[', ']', ';', 0)<cr>
onoremap <silent> aQa :<c-u>call <sid>iq_motion(getpos('.'), '<', '>', ';', 0)<cr>

vnoremap <silent> iqb :<c-u>call <sid>iq_motion(getpos('.'), '(', ')', ',', 1)<cr>
vnoremap <silent> iqB :<c-u>call <sid>iq_motion(getpos('.'), '{', '}', ',', 1)<cr>
vnoremap <silent> iqr :<c-u>call <sid>iq_motion(getpos('.'), '[', ']', ',', 1)<cr>
vnoremap <silent> iqa :<c-u>call <sid>iq_motion(getpos('.'), '<', '>', ',', 1)<cr>

vnoremap <silent> iQb :<c-u>call <sid>iq_motion(getpos('.'), '(', ')', ';', 1)<cr>
vnoremap <silent> iQB :<c-u>call <sid>iq_motion(getpos('.'), '{', '}', ';', 1)<cr>
vnoremap <silent> iQr :<c-u>call <sid>iq_motion(getpos('.'), '[', ']', ';', 1)<cr>
vnoremap <silent> iQa :<c-u>call <sid>iq_motion(getpos('.'), '<', '>', ';', 1)<cr>

vnoremap <silent> aqb :<c-u>call <sid>iq_motion(getpos('.'), '(', ')', ',', 0)<cr>
vnoremap <silent> aqB :<c-u>call <sid>iq_motion(getpos('.'), '{', '}', ',', 0)<cr>
vnoremap <silent> aqr :<c-u>call <sid>iq_motion(getpos('.'), '[', ']', ',',0)<cr>
vnoremap <silent> aqa :<c-u>call <sid>iq_motion(getpos('.'), '<', '>', ',',0)<cr>

vnoremap <silent> aQb :<c-u>call <sid>iq_motion(getpos('.'), '(', ')', ';',0)<cr>
vnoremap <silent> aQB :<c-u>call <sid>iq_motion(getpos('.'), '{', '}', ';',0)<cr>
vnoremap <silent> aQr :<c-u>call <sid>iq_motion(getpos('.'), '[', ']', ';',0)<cr>
vnoremap <silent> aQa :<c-u>call <sid>iq_motion(getpos('.'), '<', '>', ';',0)<cr>
" }}}1
