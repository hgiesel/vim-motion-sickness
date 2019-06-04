" ORIGINAL Author:  Takahiro SUZUKI <takahiro.suzuki.ja@gmDELETEMEail.com>
" Version: 1.1.1 (Vim 7.1)
" Licence: MIT Licence
"
function! iqmotion#GetOutOfDoubleQuote()
  " get out of double quoteed string (one letter before the beginning)
  let line = getline('.')
  let pos_save = getpos('.')
  let mark_b = getpos("'<")
  let mark_e = getpos("'>")
  let repl='_'
  if getline('.')[getpos('.')[2]-1] ==# '_'
    let repl='?'
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

function! iqmotion#GetOuterFunctionParenthesis(opendelim)
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

function! iqmotion#GetPair(pos)
  let pos_save = getpos('.')
  call setpos('.', a:pos)
  normal %h

  let pair_pos = getpos('.')
  call setpos('.', pos_save)
  return pair_pos
endfunction

function! iqmotion#GetInnerText(r1, r2)
  let pos_save = getpos('.')
  let reg_save = @@
  call setpos('.', a:r1)
  normal lv
  call setpos('.', a:r2)
  normal y
  let val = @@
  call setpos('.', pos_save)
  let @@ = reg_save
  return val
endfunction

function! iqmotion#GetPrevCommaOrBeginArgs(arglist, offset, fielddelim)
  let commapos = strridx(a:arglist, a:fielddelim, a:offset)
  return max([commapos+1, 0])
endfunction

function! iqmotion#GetNextCommaOrEndArgs(arglist, offset, fielddelim)
  let commapos = stridx(a:arglist, a:fielddelim, a:offset)
  if commapos == -1
    return strlen(a:arglist)-1
  endif
  return commapos-1
endfunction

function! iqmotion#MoveToNextNonSpace()
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

function! iqmotion#MoveLeft(num)
  if a:num>0
    exe 'normal ' . a:num . 'h'
  endif
endfunction

function! iqmotion#MoveRight(num)
  if a:num>0
    exe 'normal ' . a:num . 'l'
  endif
endfunction

function! iqmotion#MotionArgument(inner, visual, opendelim, closedelim, fielddelim)
  let current_c = getline('.')[getpos('.')[2]-1]
  if current_c ==# a:fielddelim || current_c ==# a:opendelim
    normal l
  endif

  " get out of "double quoted string" because [( does not take effect in it
  call iqmotion#GetOutOfDoubleQuote()

  let rightup = iqmotion#GetOuterFunctionParenthesis(a:opendelim)       " on (

  " if getline('.')[rightup[2]-1] != a:opendelim
  "   " not in a function declaration nor call
  "   return
  " endif
  let rightup_pair = iqmotion#GetPair(rightup)                    " before )
  let arglist_str  = iqmotion#GetInnerText(rightup, rightup_pair) " inside ()
  let arglist_sub  = arglist_str
  " cursor offset from rightup
  let offset  = getpos('.')[2] - rightup[2] - 1 " -1 for the removed parenthesis
  " replace all parentheses and commas inside them to '_'
  let arglist_sub = substitute(arglist_sub, "'".'\([^'."'".']\{-}\)'."'", '\="(".substitute(submatch(1), ".", "_", "g").")"', 'g') " replace '..' => (__)
  let arglist_sub = substitute(arglist_sub, '\[\([^'."'".']\{-}\)\]', '\="(".substitute(submatch(1), ".", "_", "g").")"', 'g')     " replace [..] => (__)
  let arglist_sub = substitute(arglist_sub, '<\([^'."'".']\{-}\)>', '\="(".substitute(submatch(1), ".", "_", "g").")"', 'g')       " replace <..> => (__)
  let arglist_sub = substitute(arglist_sub, '"\([^'."'".']\{-}\)"', '(\1)', 'g') " replace ''..'' => (..)

  while stridx(arglist_sub, a:opendelim) >= 0 && stridx(arglist_sub, a:closedelim) >= 0
    let arglist_sub = substitute(arglist_sub , '(\([^()]\{-}\))', '\="<".substitute(submatch(1), ",", "_", "g").">"', 'g')
  endwhile

  " the beginning/end of this argument
  let thisargbegin = iqmotion#GetPrevCommaOrBeginArgs(arglist_sub, offset, a:fielddelim)
  let thisargend   = iqmotion#GetNextCommaOrEndArgs(arglist_sub, offset, a:fielddelim)

  " function(..., the_nth_arg, ...)
  "             [^left]    [^right]
  let left  = offset - thisargbegin
  let right = thisargend - thisargbegin

  let delete_trailing_space = 0
  if a:inner
    " ia
    call iqmotion#MoveLeft(left)
    let right -= iqmotion#MoveToNextNonSpace()
  else
    " aa
    " echo string(thisargbegin) . ' : ' . string(rightup) . ' : ' . line('.')

    if thisargbegin ==# 0 && thisargend ==# strlen(arglist_sub) - 1
      " only single argument
      echo 'single'
      call iqmotion#MoveLeft(left)
    elseif thisargbegin ==# 0 && rightup[1] ==# line('.')
      " head of the list (do not delete '(')
      echo 'head '
      call iqmotion#MoveLeft(left)
      let right += 1
      let delete_trailing_space = 1
    else
      echo 'tail'
      " normal or tail of the list
      call iqmotion#MoveLeft(left+1)
      let right += 1

      if getline('.')[col('.') - 1] !=# a:fielddelim
        echo 'tail 2'
        call search(a:fielddelim, 'bW')
      endif
    endif
  endif

  exe 'normal v'
  call search('\m\%('.a:fielddelim.'\|'.a:closedelim.'\)', 'W')

  if !delete_trailing_space
    normal! h
  else
    exe 'normal l'
    call iqmotion#MoveToNextNonSpace()
    exe 'normal h'
  endif
endfunction

" option. turn 1 to search the most toplevel function
if !exists('g:argumentobject_force_toplevel')
  let g:argumentobject_force_toplevel = 0
endif
