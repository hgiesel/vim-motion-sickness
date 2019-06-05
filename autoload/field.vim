" ORIGINAL Author:  Takahiro SUZUKI <takahiro.suzuki.ja@gmDELETEMEail.com>
" Version: 1.1.1 (Vim 7.1)
" Licence: MIT Licence
"
" Terminology:
" - fielddelim: typically comma, might be semicolon, etc.
" - opendelim: ({[<
" - closedelim: )}]>
" - blanks: space and tab
" - field character: everything except blanks, linefeeds, and fielddelim
"
" Algorithm:
" (*) for head element:
" - delete elem
" - delete right till first field character
" - DONE
"
" (*) for middle/tail element:
" - delete elem
" - check if on right is field character before newline
"   | if not:
"     - delete left until first field character
"     - DONE
"   | if yes:
"     - delete fielddelim and blanks on right
"     - DONE
"
" (*) for single element:
" - delete elem
" - check if cursor on same line as opendelim, but not as closedelim
"   | if yes:
"     - delete left and remember col of opendelim
"     - delete right until newline
"     - look up col of closedelim on the next line
"       | if same as col of opendelim:
"         - DONE
"       | if not:
"         - delete right until closedelim
"         - DONE
"   | if not:
"     - delete left until you reach opendelim
"     - delete right until you reach closedelim
"     - DONE

function! s:GetOutOfDoubleQuote()
  " get out of double quoteed string (one letter before the beginning)
  let line     = getline('.')
  let pos_save = getpos('.')
  let mark_b   = getpos("'<")
  let mark_e   = getpos("'>")
  let repl     = '_'

  if getline('.')[getpos('.')[2]-1] ==# '_'
    let repl = '?'
  endif

  while 1
    exe 'silent! normal ^va"'
    normal :\<ESC>\<CR>
    if getpos("'<") ==# getpos("'>")
      break
    endif
    exe 'normal gvr' . repl
  endwhile

  call setpos('.', pos_save)
  if getline('.')[getpos('.')[2]-1] ==# repl
    " in double quote
    call setline('.', line)
    if getpos('.') ==# getpos("'<")
      normal h
    else
      normal F"
  endif
  else
    " not in double quote
    call setline('.', line)
  endif
endfunction

function! s:GetOuterFunctionParenthesis(opendelim)
  let pos_save = getpos('.')
  let rightup_before = pos_save

  if a:opendelim ==# '('
    silent! normal [(
  elseif a:opendelim ==# '{'
    silent! normal [{
  else
    execute 'silent! normal F' . a:opendelim
  endif

  let rightup_p = getpos('.')
  while rightup_p != rightup_before
    if ! g:argumentobject_force_toplevel && getline('.')[getpos('.')[2]-1-1] =~ '[a-zA-Z0-9_]'
      " found a function
      break
    endif
    let rightup_before = rightup_p

    if a:opendelim ==# '('
      silent! normal [(
    elseif a:opendelim ==# '{'
      silent! normal [{
    else
      execute 'silent! normal F' . a:opendelim
    endif
    let rightup_p = getpos('.')
  endwhile
  call setpos('.', pos_save)
  return rightup_p
endfunction

function! s:GetPair(pos)
  let pos_save = getpos('.')
  call setpos('.', a:pos)
  execute "normal! %\<bs>"
  let pair_pos = getpos('.')
  call setpos('.', pos_save)
  return pair_pos
endfunction

function! s:GetInnerText(r1, r2)
  let pos_save = getpos('.')
  let reg_save = @@
  call setpos('.', a:r1)
  normal! 1 v
  call setpos('.', a:r2)
  normal! y
  let val = @@
  call setpos('.', pos_save)
  let @@ = reg_save
  return val
endfunction

function! s:GetPrevCommaOrBeginArgs(arglist, offset, fielddelim)
  let commapos = strridx(a:arglist, a:fielddelim, a:offset)
  " echo 'prev commapos '. string(a:offset) . ':'. commapos
  return max([commapos + 1, 0])
endfunction

function! s:GetNextCommaOrEndArgs(arglist, offset, fielddelim)
  let commapos = stridx(a:arglist, a:fielddelim, a:offset)
  " echo 'next commapos '. string(a:offset) . ':' .commapos
  if commapos ==# -1
    return strlen(a:arglist) - 1
  else
    return commapos - 1
  endif
endfunction

function! s:MoveToNextNonSpace()
  let oldp = getpos('.')
  let moved = 0
  while getline('.')[getpos('.')[2]-1] ==# ' '
    normal l
    if oldp == getpos('.')
      break
    endif
    let oldp = getpos('.')
    let moved += 1
  endwhile
  return moved
endfunction

function! s:MoveLeft(num)
  if a:num>0
    execute 'normal ' . a:num . "\<bs>"
  endif
endfunction

function! s:MoveRight(num)
  if a:num>0
    execute 'normal ' . a:num . ' '
  endif
endfunction

function! field#motion(inner, visual, opendelim, closedelim, fielddelim)

  normal! 
  let current_c = getline('.')[getpos('.')[2]-1]
  if current_c ==# a:fielddelim || current_c ==# a:opendelim
    normal l
  endif

  " get out of "double quoted string" because [( does not take effect in it
  call s:GetOutOfDoubleQuote()
  let rightup = s:GetOuterFunctionParenthesis(a:opendelim)

  " if getline('.')[rightup[2]-1] != a:opendelim
  "   " not in a function declaration nor call
  "   return
  " endif
  let rightup_pair = s:GetPair(rightup)                    " before )
  let arglist_str  = s:GetInnerText(rightup, rightup_pair) " inside ()
  let arglist_sub  = arglist_str
  " cursor offset from rightup


  let offset = 0
  let idx = 0
  let l:continue = v:true
  while l:continue
    if idx == 0 && rightup[1] == getpos('.')[1]
      " last line
      let offset += getpos('.')[2] - rightup[2] - 1 " -1 for the removed parenthesis
      " echo 'case0 '.offset
      break

    elseif idx == 0 && rightup[1] < getpos('.')[1]
      " get the characters starting from the opendelim
      " e.g. `foo(asdf,` will be three characters
      let offset += strlen(getline(rightup[1])) - rightup[2]
      " echo 'case1 '.offset

    elseif rightup[1] + idx < getpos('.')[1]
      " get the whole line
      " e.g. `"sdf",` will be 6 characters
      let offset += strlen(getline(rightup[1] + idx))
      " echo 'case2 '.offset

    else " rightup[1] == getpos('.')[1]
      " last line
      let offset += getpos('.')[2] - 1
      " echo 'case3 '.offset
      break
    endif

    let idx += 1
  endwhile

  if l:offset < 0
    return
  endif

  " replace all parentheses and commas inside them to '_'
  let arglist_sub = substitute(arglist_sub, "'".'\([^'."'".']\{-}\)'."'", '\="(".substitute(submatch(1), ".", "_", "g").")"', 'g') " replace '..' => (__)
  let arglist_sub = substitute(arglist_sub, '\[\([^'."'".']\{-}\)\]', '\="(".substitute(submatch(1), ".", "_", "g").")"', 'g')     " replace [..] => (__)
  let arglist_sub = substitute(arglist_sub, '<\([^'."'".']\{-}\)>', '\="(".substitute(submatch(1), ".", "_", "g").")"', 'g')       " replace <..> => (__I
  let arglist_sub = substitute(arglist_sub, '"\([^'."'".']\{-}\)"', '(\1)', 'g') " replace ''..'' => (..)

  " replaces commas:
  while stridx(arglist_sub, a:opendelim) >= 0 && stridx(arglist_sub, a:closedelim) >= 0
    let arglist_sub = substitute(arglist_sub, '(\([^()]\{-}\))', '\="<".substitute(submatch(1), ",", "_", "g").">"', 'g')
  endwhile

  " echo arglist_sub

  " the beginning/end of this argument
  let thisargbegin = s:GetPrevCommaOrBeginArgs(arglist_sub, offset, a:fielddelim)
  let thisargend   = s:GetNextCommaOrEndArgs(arglist_sub, offset, a:fielddelim)

  " echo string(thisargbegin).':'.string(thisargend)

  " function(..., the_nth_arg, ...)
  "             [^left]    [^right]
  let left  = offset - thisargbegin
  let right = thisargend - thisargbegin

  let delete_trailing_space = 0
  if a:inner
    " ia
    call s:MoveLeft(left)
    let right -= s:MoveToNextNonSpace()
  else
    " aa
    if thisargbegin ==# 0 && thisargend ==# strlen(arglist_sub) - 1
      " only single argument
      " echo 'single '.thisargbegin . ':'.thisargend
      call s:MoveLeft(left)
    elseif thisargbegin ==# 0
      " head of the list (do not delete '(')
      call s:MoveLeft(left)
      let right += 1
      let delete_trailing_space = 1
      " echo 'head '.right
    else
      " normal or tail of the list
      call s:MoveLeft(left+1)
      let right += 1
      " echo 'tail ' . right
    endif
  endif

  execute 'normal v'

  call s:MoveRight(right)
  if delete_trailing_space
    execute 'normal! 1 '
    call s:MoveToNextNonSpace()
    if (!a:inner && (col('.') + 1 == col('$')))
      execute "normal! $"
    else
      execute "normal! \<bs>"
    endif
  endif
endfunction

" option. turn 1 to search the most toplevel function
if !exists('g:argumentobject_force_toplevel')
  let g:argumentobject_force_toplevel = 0
endif
