" z Add some lines which don't do anything cause they are comments And some more
" This plugin adds a lot of motion mappings. Here's a list
"
" 1. `ir`, `ar`, `ia`, and `aa` where `r` and `a` are aliases for `[` and `<`
"  (similiar to tpopes' vim-surround plugin
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
"
"  Planned for the future are:
" 1. `qc` to select colon (key: value) statements
" 2. `qe` to select equal statements
" 3. `qd` `qD` `Qd` `QD` is used to select dot statements, e.g. test().arg[50]
" 4. `qw` select arrow statements (in C) and to make iqb and qb work correctly with
" `<` characters splattered over the place
" 5 `qn` to select namespace statements
"
" 6. iz and az to select indentation levels

if exists('g:loaded_motion_sickness') || &compatible || v:version < 700
  finish
endif
let g:loaded_motion_sickness = 1

" like C {{{1
function! s:sick_cmp(a, b)
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
" }}}

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
function! s:sick_symbol_motion(wrap, symbol, mode)
  " position on the left when you started
  let l:start_col = col('.')
  let l:valid     = v:true

  " Go to open position
  silent! execute 'normal! F' . a:symbol

  " Found open_col
  if col('.') ==# l:start_col
    " open_col may be to the right
    silent! execute 'normal! f' . a:symbol

    " There is no open_col
    if col('.') ==# l:start_col
      let l:valid = v:false
    end
  endif

  if l:valid
    if a:wrap ==# 'i'
      execute "normal! l"

      if col('.') ==# l:start_col && getline('.')[l:start_col + 1] !=# a:symbol
        let l:valid = v:false
      endif
    endif

    let l:open_col = col('.')

    execute 'normal! v'
    " go back to where you started, in case you are in a fold that has the symbol
    " more than once (e.g. __fo|obar__)
    " jump from left end to middle again
    " This is only useful in visual mode, when you already selected someting and
    " enlarge this selection
    if a:mode ==# 'v'
      execute 'normal! ' . col("'>") . '|'
    endif
    execute 'normal! f' . a:symbol

    " If no close_pol found
    if col('.') ==# l:open_col
      let l:valid = v:false
    end

    if l:valid && a:wrap ==# 'i'
      execute "normal! h"
    endif
  endif

  if !l:valid
    execute 'normal! v' . l:start_col . '|'
    if a:mode ==# 'v'
      execute 'normal! v'
    endif
  endif
endfunction

function! s:sick_symbol_motion_add(symbol)
  for wrap in ['i', 'a']
      silent! execute  "onoremap <silent> " . wrap . a:symbol . " :\<c-u>call "
        \ . "<sid>sick_symbol_motion('" . wrap . "', '" . a:symbol . "', 'o')\<cr>"
      silent! execute  "vnoremap <silent> " . wrap . a:symbol . " :\<c-u>call "
        \ . "<sid>sick_symbol_motion('" . wrap . "', '" . a:symbol . "', 'v')\<cr>"
  endfor
endfunction

let g:sick_symbol_motion_chars =
      \ ['*', '_', '-', ':', '@', '!', '?', '/', "<bar>"]

for char in g:sick_symbol_motion_chars
  call s:sick_symbol_motion_add(char)
endfor
" }}}1

" qb Motion {{{1
omap <silent> qb <plug>Oqbmotion
vmap <silent> qb <plug>Vqbmotion
omap <silent> Qb <plug>OQbmotion
vmap <silent> Qb <plug>VQbmotion

omap <silent> qB <plug>OqBmotion
vmap <silent> qB <plug>VqBmotion
omap <silent> QB <plug>OQBmotion
vmap <silent> QB <plug>VQBmotion

omap <silent> qr <plug>Oqrmotion
vmap <silent> qr <plug>Vqrmotion
omap <silent> Qr <plug>OQrmotion
vmap <silent> Qr <plug>VQrmotion

omap <silent> qa <plug>Oqamotion
vmap <silent> qa <plug>Vqamotion
omap <silent> Qa <plug>OQamotion
vmap <silent> Qa <plug>VQamotion

onoremap <plug>Oqbmotion
      \ :<c-u>call <sid>sick_qb_motion(getpos('.'), '(', ')', v:false)<cr>
vnoremap <plug>Vqbmotion
      \ :<c-u>call <sid>sick_qb_motion(getpos('.'), '(', ')', v:false)<cr>
onoremap <plug>OQbmotion
      \ :<c-u>call <sid>sick_qb_motion(getpos('.'), '(', ')', v:true)<cr>
vnoremap <plug>VQbmotion
      \ :<c-u>call <sid>sick_qb_motion(getpos('.'), '(', ')', v:true)<cr>

onoremap <plug>OqBmotion
      \ :<c-u>call <sid>sick_qb_motion(getpos('.'), '{', '}', v:false)<cr>
vnoremap <plug>VqBmotion
      \ :<c-u>call <sid>sick_qb_motion(getpos('.'), '{', '}', v:false)<cr>
onoremap <plug>OQBmotion
      \ :<c-u>call <sid>sick_qb_motion(getpos('.'), '{', '}', v:true)<cr>
vnoremap <plug>VQBmotion
      \ :<c-u>call <sid>sick_qb_motion(getpos('.'), '{', '}', v:true)<cr>

onoremap <plug>Oqrmotion
      \ :<c-u>call <sid>sick_qb_motion(getpos('.'), '[', ']', v:false)<cr>
vnoremap <plug>Vqrmotion
      \ :<c-u>call <sid>sick_qb_motion(getpos('.'), '[', ']', v:false)<cr>
onoremap <plug>OQrmotion
      \ :<c-u>call <sid>sick_qb_motion(getpos('.'), '[', ']', v:true)<cr>
vnoremap <plug>VQrmotion
      \ :<c-u>call <sid>sick_qb_motion(getpos('.'), '[', ']', v:true)<cr>

onoremap <plug>Oqamotion
      \ :<c-u>call <sid>sick_qb_motion(getpos('.'), '<', '>', v:false)<cr>
vnoremap <plug>Vqamotion
      \ :<c-u>call <sid>sick_qb_motion(getpos('.'), '<', '>', v:false)<cr>
onoremap <plug>OQamotion
      \ :<c-u>call <sid>sick_qb_motion(getpos('.'), '<', '>', v:true)<cr>
vnoremap <plug>VQamotion
      \ :<c-u>call <sid>sick_qb_motion(getpos('.'), '<', '>', v:true)<cr>

function! s:sick_qb_motion(cur_pos, open_char, close_char, reach)
  let l:recursions  = 1
  let l:winview     = winsaveview()

  " this will only work with 10 recursions, because this could go on forever
  while l:recursions < 10
    " This block makes an assumption to what the qb section may look like with the
    " cursor ending on the end of the selection (how it should be)
    call s:sick_find_nth_char(l:recursions, a:close_char)
    call s:sick_make_a_q(a:open_char, a:close_char, a:reach)
    execute 'normal! o'

    if s:sick_cmp(getpos('v')[1:2], a:cur_pos[1:2]) !=# 1
          \ && s:sick_cmp(a:cur_pos[1:2], getpos('.')[1:2]) !=# 1
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

function! s:sick_make_a_q(open_char, close_char, reach)
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

      " D
      " if character next to such an statement is a character, it is
      " probably its name
    elseif l:next_char =~ '\v[a-zA-Z0-9_]'
      if a:reach
        normal! B
      else
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

function! s:sick_find_nth_char(n, char)
  if getline('.')[col('.') - 1] !=# a:char
    for i in range(a:n)
      silent! execute "normal! /" . a:char . "\<cr>"
    endfor
  endif

  silent! execute "normal! va" . a:char . "o"
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

    if s:sick_cmp(a:curpos, l:startpos) == -1 &&
          \ s:sick_cmp(l:startpos, l:endpos) == -1
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

vnoremap <silent> qd :<c-u>call <sid>qd_motion(getpos('.'),'.',v:false,v:false)<cr>
vnoremap <silent> qD :<c-u>call <sid>qd_motion(getpos('.'),'.',v:false,v:true)<cr>
vnoremap <silent> Qd :<c-u>call <sid>qd_motion(getpos('.'),'.',v:true,v:false)<cr>
vnoremap <silent> QD :<c-u>call <sid>qd_motion(getpos('.'),'.',v:true,v:true)<cr>

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

" iz motion {{{1
omap <silent> iz <plug>OIzmotion
omap <silent> az <plug>OIZmotion
vmap <silent> iz <plug>VIzmotion
vmap <silent> az <plug>VIZmotion

onoremap <plug>OIzmotion :<c-u>call <sid>iz_motion(0)<cr>
onoremap <plug>OIZmotion :<c-u>call <sid>iz_motion(&tabstop)<cr>
vnoremap <plug>VIzmotion :<c-u>call <sid>iz_motion(0)<cr>
vnoremap <plug>VIZmotion :<c-u>call <sid>iz_motion(&tabstop)<cr>

function s:iz_motion(margin)
  let l:cur_indent = indent(line("."))
  while indent(line('.') - 1) >= l:cur_indent - a:margin
    \ && getline(line('.') - 1) != ''
    execute 'normal k'
  endwhile

  execute "normal V"
  while indent(line('.') + 1) >= l:cur_indent - a:margin
    \ && getline(line('.') + 1) != ''
    execute 'normal j'
  endwhile
endfunction
" }}}
