" Iq-motions
" `iqb` `aqb`, etc. is used to select parameters (or arguments) within
" braces, very helpful for any kind of programming language

if exists('g:loaded_motion_sickness_iqmotion') || &compatible || v:version < 700
  finish
endif
let g:loaded_motion_sickness_iqmotion = 1

" Setting user mappings {{{1
omap iqb <plug>(Oiqbmotion)
vmap iqb <plug>(Viqbmotion)
omap aqb <plug>(Oaqbmotion)
vmap aqb <plug>(Vaqbmotion)

omap iQb <plug>(OiQbmotion)
vmap iQb <plug>(ViQbmotion)
omap aQb <plug>(OaQbmotion)
vmap aQb <plug>(VaQbmotion)

omap iqB <plug>(OiqBmotion)
vmap iqB <plug>(ViqBmotion)
omap aqB <plug>(OaqBmotion)
vmap aqB <plug>(VaqBmotion)

omap iQB <plug>(OiQBmotion)
vmap iQB <plug>(ViQBmotion)
omap aQB <plug>(OaQBmotion)
vmap aQB <plug>(VaQBmotion)

omap iqr <plug>(Oiqrmotion)
vmap iqr <plug>(Viqrmotion)
omap aqr <plug>(Oaqrmotion)
vmap aqr <plug>(Vaqrmotion)

omap iQr <plug>(OiQrmotion)
vmap iQr <plug>(ViQrmotion)
omap aQr <plug>(OaQrmotion)
vmap aQr <plug>(VaQrmotion)

omap iqa <plug>(Oiqamotion)
vmap iqa <plug>(Viqamotion)
omap aqa <plug>(Oaqamotion)
vmap aqa <plug>(Vaqamotion)

omap iQa <plug>(OiQamotion)
vmap iQa <plug>(ViQamotion)
omap aQa <plug>(OaQamotion)
vmap aQa <plug>(VaQamotion)

onoremap <silent>
      \ <plug>(Oiqbmotion)
      \ :<c-u>call <SID>MotionArgument(1, 0, '(', ')', ',')<CR>
vnoremap <silent>
      \ <plug>(Viqbmotion)
      \ <esc>:<c-u>call <SID>MotionArgument(1, 1, '(', ')', ',')<CR>
onoremap <silent>
      \ <plug>(Oaqbmotion)
      \ :<c-u>call <SID>MotionArgument(0, 0, '(', ')', ',')<CR>
vnoremap <silent>
      \ <plug>(Vaqbmotion)
      \ <esc>:<c-u>call <SID>MotionArgument(0, 1, '(', ')', ',')<CR>

onoremap <silent>
      \ <plug>(OiQbmotion)
      \ :<c-u>call <SID>MotionArgument(1, 0, '(', ')', ';')<CR>
vnoremap <silent>
      \ <plug>(ViQbmotion)
      \ <esc>:<c-u>call <SID>MotionArgument(1, 1, '(', ')', ';')<CR>
onoremap <silent>
      \ <plug>(OaQbmotion)
      \ :<c-u>call <SID>MotionArgument(0, 0, '(', ')', ';')<CR>
vnoremap <silent>
      \ <plug>(VaQbmotion)
      \ <esc>:<c-u>call <SID>MotionArgument(0, 1, '(', ')', ';')<CR>

onoremap <silent>
      \ <plug>(OiqBmotion)
      \ :<c-u>call <SID>MotionArgument(1, 0, '{', '}', ',')<CR>
vnoremap <silent>
      \ <plug>(ViqBmotion)
      \ <esc>:<c-u>call <SID>MotionArgument(1, 1, '{', '}', ',')<CR>
onoremap <silent>
      \ <plug>(OaqBmotion)
      \ :<c-u>call <SID>MotionArgument(0, 0, '{', '}', ',')<CR>
vnoremap <silent>
      \ <plug>(VaqBmotion)
      \ <esc>:<c-u>call <SID>MotionArgument(0, 1, '{', '}', ',')<CR>

onoremap <silent>
      \ <plug>(OiQBmotion)
      \ :<c-u>call <SID>MotionArgument(1, 0, '{', '}', ';')<CR>
vnoremap <silent>
      \ <plug>(ViQBmotion)
      \ <esc>:<c-u>call <SID>MotionArgument(1, 1, '{', '}', ';')<CR>
onoremap <silent>
      \ <plug>(OaQBmotion)
      \ :<c-u>call <SID>MotionArgument(0, 0, '{', '}', ';')<CR>
vnoremap <silent>
      \ <plug>(VaQBmotion)
      \ <esc>:<c-u>call <SID>MotionArgument(0, 1, '{', '}', ';')<CR>

onoremap <silent>
      \ <plug>(Oiqrmotion)
      \ :<c-u>call <SID>MotionArgument(1, 0, '[', ']', ',')<CR>
vnoremap <silent>
      \ <plug>(Viqrmotion)
      \ <esc>:<c-u>call <SID>MotionArgument(1, 1, '[', ']', ',')<CR>
onoremap <silent>
      \ <plug>(Oaqrmotion)
      \ :<c-u>call <SID>MotionArgument(0, 0, '[', ']', ',')<CR>
vnoremap <silent>
      \ <plug>(Vaqrmotion)
      \ <esc>:<c-u>call <SID>MotionArgument(0, 1, '[', ']', ',')<CR>

onoremap <silent>
      \ <plug>(OiQrmotion)
      \ :<c-u>call <SID>MotionArgument(1, 0, '[', ']', ';')<CR>
vnoremap <silent>
      \ <plug>(ViQrmotion)
      \ <esc>:<c-u>call <SID>MotionArgument(1, 1, '[', ']', ';')<CR>
onoremap <silent>
      \ <plug>(OaQrmotion)
      \ :<c-u>call <SID>MotionArgument(0, 0, '[', ']', ';')<CR>
vnoremap <silent>
      \ <plug>(VaQrmotion)
      \ <esc>:<c-u>call <SID>MotionArgument(0, 1, '[', ']', ';')<CR>

onoremap <silent>
      \ <plug>(Oiqamotion)
      \ :<c-u>call <SID>MotionArgument(1, 0, '<', '>', ',')<CR>
vnoremap <silent>
      \ <plug>(Viqamotion)
      \ <esc>:<c-u>call <SID>MotionArgument(1, 1, '<', '>', ',')<CR>
onoremap <silent>
      \ <plug>(Oaqamotion)
      \ :<c-u>call <SID>MotionArgument(0, 0, '<', '>', ',')<CR>
vnoremap <silent>
      \ <plug>(Vaqamotion)
      \ <esc>:<c-u>call <SID>MotionArgument(0, 1, '<', '>', ',')<CR>

onoremap <silent>
      \ <plug>(OiQamotion)
      \ :<c-u>call <SID>MotionArgument(1, 0, '<', '>', ';')<CR>
vnoremap <silent>
      \ <plug>(ViQamotion)
      \ <esc>:<c-u>call <SID>MotionArgument(1, 1, '<', '>', ';')<CR>
onoremap <silent>
      \ <plug>(OaQamotion)
      \ :<c-u>call <SID>MotionArgument(0, 0, '<', '>', ';')<CR>
vnoremap <silent>
      \ <plug>(VaQamotion)
      \ <esc>:<c-u>call <SID>MotionArgument(0, 1, '<', '>', ';')<CR>

" ORIGINAL Author:  Takahiro SUZUKI <takahiro.suzuki.ja@gmDELETEMEail.com>
" Version: 1.1.1 (Vim 7.1)
" Licence: MIT Licence

function! s:GetOutOfDoubleQuote()
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
  normal %h
  let pair_pos = getpos('.')
  call setpos('.', pos_save)
  return pair_pos
endfunction

function! s:GetInnerText(r1, r2)
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

function! s:GetPrevCommaOrBeginArgs(arglist, offset, fielddelim)
  let commapos = strridx(a:arglist, a:fielddelim, a:offset)
  return max([commapos+1, 0])
endfunction

function! s:GetNextCommaOrEndArgs(arglist, offset, fielddelim)
  let commapos = stridx(a:arglist, a:fielddelim, a:offset)
  if commapos == -1
    return strlen(a:arglist)-1
  endif
  return commapos-1
endfunction

function! s:MoveToNextNonSpace()
  let oldp = getpos('.')
  let moved = 0
  """echo 'move:' . getline('.')[getpos('.')[2]-1]
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
    exe 'normal ' . a:num . 'h'
  endif
endfunction

function! s:MoveRight(num)
  if a:num>0
    exe 'normal ' . a:num . 'l'
  endif
endfunction

function! s:MotionArgument(inner, visual, opendelim, closedelim, fielddelim)
  let current_c = getline('.')[getpos('.')[2]-1]
  if current_c==a:fielddelim || current_c==a:opendelim
    normal l
  endif

  " get out of "double quoted string" because [( does not take effect in it
  call <SID>GetOutOfDoubleQuote()

  let rightup      = <SID>GetOuterFunctionParenthesis(a:opendelim)       " on (
  if getline('.')[rightup[2]-1] != a:opendelim
    " not in a function declaration nor call
    return
  endif
  let rightup_pair = <SID>GetPair(rightup)                    " before )
  let arglist_str  = <SID>GetInnerText(rightup, rightup_pair) " inside ()
  let arglist_sub  = arglist_str
  " cursor offset from rightup
  let offset  = getpos('.')[2] - rightup[2] - 1 " -1 for the removed parenthesis
  " replace all parentheses and commas inside them to '_'
  let arglist_sub = substitute(arglist_sub, "'".'\([^'."'".']\{-}\)'."'", '\="(".substitute(submatch(1), ".", "_", "g").")"', 'g') " replace '..' => (__)
  let arglist_sub = substitute(arglist_sub, '\[\([^'."'".']\{-}\)\]', '\="(".substitute(submatch(1), ".", "_", "g").")"', 'g')     " replace [..] => (__)
  let arglist_sub = substitute(arglist_sub, '<\([^'."'".']\{-}\)>', '\="(".substitute(submatch(1), ".", "_", "g").")"', 'g')       " replace <..> => (__)
  let arglist_sub = substitute(arglist_sub, '"\([^'."'".']\{-}\)"', '(\1)', 'g') " replace ''..'' => (..)
  """echo 'transl quotes: ' . arglist_sub
  while stridx(arglist_sub, a:opendelim) >= 0 && stridx(arglist_sub, a:closedelim) >= 0 " TODO
    let arglist_sub = substitute(arglist_sub , '(\([^()]\{-}\))', '\="<".substitute(submatch(1), ",", "_", "g").">"', 'g')
    """echo 'sub single quot: ' . arglist_sub
  endwhile

  " the beginning/end of this argument
  let thisargbegin = <SID>GetPrevCommaOrBeginArgs(arglist_sub, offset, a:fielddelim)
  let thisargend   = <SID>GetNextCommaOrEndArgs(arglist_sub, offset, a:fielddelim)

  " function(..., the_nth_arg, ...)
  "             [^left]    [^right]
  let left  = offset - thisargbegin
  let right = thisargend - thisargbegin

  """echo 'on(='. rightup[2] . ' before)=' . rightup_pair[2]
  """echo arglist_str
  """echo arglist_sub
  """echo offset
  """echo 'argbegin='. thisargbegin . '  argend='. thisargend
  """echo 'left=' . left . '  right='. right

  let delete_trailing_space = 0
  if a:inner
    " ia
    call <SID>MoveLeft(left)
    let right -= <SID>MoveToNextNonSpace()
  else
    " aa
    if thisargbegin ==# 0 && thisargend ==# strlen(arglist_sub)-1
      " only single argument
      call <SID>MoveLeft(left)
    elseif thisargbegin ==# 0
      " head of the list (do not delete '(')
      call <SID>MoveLeft(left)
      let right += 1
      let delete_trailing_space = 1
    else
      " normal or tail of the list
      call <SID>MoveLeft(left+1)
      let right += 1
    endif
  endif

  exe 'normal v'

  call <SID>MoveRight(right)
  if delete_trailing_space
    exe 'normal l'
    call <SID>MoveToNextNonSpace()
    exe 'normal h'
  endif
endfunction

" option. turn 1 to search the most toplevel function
if !exists('g:argumentobject_force_toplevel')
  let g:argumentobject_force_toplevel = 0
endif
