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
omap iQb <plug>(OiQbmotion)
vmap iQb <plug>(ViQbmotion)

omap aqb <plug>(Oaqbmotion)
vmap aqb <plug>(Vaqbmotion)
omap aQb <plug>(OaQbmotion)
vmap aQb <plug>(VaQbmotion)

omap iqB <plug>(OiqBmotion)
vmap iqB <plug>(ViqBmotion)
omap iQB <plug>(OiQBmotion)
vmap iQB <plug>(ViQBmotion)

omap aqB <plug>(OaqVmotion)
vmap aqB <plug>(VaqVmotion)
omap aQB <plug>(OaQVmotion)
vmap aQB <plug>(VaQVmotion)

omap iqr <plug>(Oiqrmotion)
vmap iqr <plug>(Viqrmotion)
omap iQr <plug>(OiQrmotion)
vmap iQr <plug>(ViQrmotion)

omap aqr <plug>(Oaqrmotion)
vmap aqr <plug>(Vaqrmotion)
omap aQr <plug>(OaQrmotion)
vmap aQr <plug>(VaQrmotion)

omap iqa <plug>(Oiqamotion)
vmap iqa <plug>(Viqamotion)
omap iQa <plug>(OiQamotion)
vmap iQa <plug>(ViQamotion)

omap aqa <plug>(Oaqamotion)
vmap aqa <plug>(Vaqamotion)
omap aQa <plug>(OaQamotion)
vmap aQa <plug>(VaQamotion)

"" ia
"vnoremap <silent> 
"      \ <plug>(Viqbmotion)
"      \ <ESC>:<c-u>call <SID>MotionArgument(1, 1)<CR>
"" aa
"vnoremap <silent>
"      \ <plug>(Vaqbmotion)
"      \ <ESC>:<c-u>call <SID>MotionArgument(0, 1)<CR>
""ia
"onoremap <silent>
"      \ <plug>(Oiqbmotion)
"      \ :<c-u>call <SID>MotionArgument(1, 0)<CR>
"" aa
"onoremap <silent>
"      \ <plug>(Oaqbmotion)
"      \ :<c-u>call <SID>MotionArgument(0, 0)<CR>

" Setting plug mappings {{{1
onoremap <silent>
      \ <plug>(Oiqbmotion) :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '(', ')', ',', v:false)<cr>
vnoremap <silent>
      \ <plug>(Viqbmotion) :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '(', ')', ',', v:false)<cr>
onoremap <silent>
      \ <plug>(OiQbmotion) :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '(', ')', ';', v:false)<cr>
vnoremap <silent>
      \ <plug>(ViQbmotion) :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '(', ')', ';', v:false)<cr>

onoremap <silent>
      \ <plug>(Oiqbmotion) :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '(', ')', ',', v:true)<cr>
vnoremap <silent>
      \ <plug>(Viqbmotion) :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '(', ')', ',', v:true)<cr>
onoremap <silent>
      \ <plug>(OiQbmotion) :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '(', ')', ';', v:true)<cr>
vnoremap <silent>
      \ <plug>(ViQbmotion) :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '(', ')', ';', v:true)<cr>

onoremap <silent>
      \ <plug>(OiqBmotion) :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '{', '}', ',', v:false)<cr>
vnoremap <silent>
      \ <plug>(ViqBmotion) :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '{', '}', ',', v:false)<cr>
onoremap <silent>
      \ <plug>(OiQBmotion) :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '{', '}', ';', v:false)<cr>
vnoremap <silent>
      \ <plug>(ViQBmotion) :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '{', '}', ';', v:false)<cr>

onoremap <silent>
      \ <plug>(OaqBmotion) :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '{', '}', ',', v:true)<cr>
vnoremap <silent>
      \ <plug>(VaqBmotion) :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '{', '}', ',', v:true)<cr>
onoremap <silent>
      \ <plug>(OaQBmotion) :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '{', '}', ';', v:true)<cr>
vnoremap <silent>
      \ <plug>(VaQBmotion) :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '{', '}', ';', v:true)<cr>

onoremap <silent>
      \ <plug>(Oiqrmotion) :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '[', ']', ',', v:false)<cr>
vnoremap <silent>
      \ <plug>(Viqrmotion) :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '[', ']', ',', v:false)<cr>
onoremap <silent>
      \ <plug>(OiQrmotion) :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '[', ']', ';', v:false)<cr>
vnoremap <silent>
      \ <plug>(ViQrmotion) :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '[', ']', ';', v:false)<cr>

onoremap <silent>
      \ <plug>(Oaqrmotion) :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '[', ']', ',', v:true)<cr>
vnoremap <silent>
      \ <plug>(Vaqrmotion) :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '[', ']', ',', v:true)<cr>
onoremap <silent>
      \ <plug>(OaQrmotion) :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '[', ']', ';', v:true)<cr>
vnoremap <silent>
      \ <plug>(VaQrmotion) :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '[', ']', ';', v:true)<cr>

onoremap <silent>
      \ <plug>(Oiqamotion) :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '<', '>', ',', v:false)<cr>
vnoremap <silent>
      \ <plug>(Viqamotion) :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '<', '>', ',', v:false)<cr>
onoremap <silent>
      \ <plug>(OiQamotion) :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '<', '>', ';', v:false)<cr>
vnoremap <silent>
      \ <plug>(ViQamotion) :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '<', '>', ';', v:false)<cr>

onoremap <silent>
      \ <plug>(Oaqamotion) :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '<', '>', ',', v:true)<cr>
vnoremap <silent>
      \ <plug>(Vaqamotion) :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '<', '>', ',', v:true)<cr>
onoremap <silent>
      \ <plug>(OaQamotion) :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '<', '>', ';', v:true)<cr>
vnoremap <silent>
      \ <plug>(VaQamotion) :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '<', '>', ';', v:true)<cr>

" Defining functions {{{1
function! s:sick_iqb_motion(cur_pos, open_ch, close_ch, delim, reach)
  let l:finished  = v:false
  let l:recursion = 0

  " these behave special
  let l:brace_dict  = {
        \ '(': 0,
        \ ')': 0,
        \ '{': 0,
        \ '}': 0,
        \ '[': 0,
        \ ']': 0,
        \ '<': 0,
        \ '>': 0,
        \ "'": 0,
        \ '"': 0,
        \ }

  let l:search_char = a:delim

  silent! execute 'normal! va' . a:open_ch . 'o'
  let l:abs_endpos = getpos('.')

  " There is no a<symbol> here, so you can't look for inner arguments
  if l:abs_endpos == a:cur_pos
    let l:finished = v:true
  endif

  " foo(arg, bar, xyz);
  while !l:finished
    let l:recursion += 1

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

      if l:a_char ==# l:search_char && s:brace_dict_matches(l:brace_dict)
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
      elseif l:a_char == '"'
        let l:brace_dict['"'] += 1

      elseif l:a_char == "'"
        let l:brace_dict["'"] += 1
      endif

      execute "normal! 1 "
    endwhile

    let l:endpos = getpos('.')

    if s:sick_cmp(a:cur_pos, l:start_pos) == -1 &&
          \ s:sick_cmp(l:start_pos, l:end_pos) == -1
      let l:finished = 1
    endif
  endwhile

  if a:reach
    silent! execute "normal! ?\\v[^ \\n\\\\]\<cr>o/\\v[^ \\n\\\\]\<cr>"

  else
    if l:recursion ==# 1
      silent! execute "normal! o/\\v[^ \\n\\\\]\<cr>o"

    else
      silent! execute "normal! ?\\v[^ \\n\\\\]\<cr>"
    endif
  endif
endfunction

function! s:brace_dict_matches(brace_dict)
  if a:brace_dict['(']    ==# a:brace_dict[')']
        \ && a:brace_dict['[']     ==# a:brace_dict[']']
        \ && a:brace_dict['{']     ==# a:brace_dict['}']
        \ && a:brace_dict['<']     ==# a:brace_dict['>']
        \ && a:brace_dict['"'] % 2 ==# 0
        \ && a:brace_dict["'"] % 2 ==# 0
    return 1
  endif

  return 0
endfunction



""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""
"=============================================================================
" argtextobj.vim - Text-Object like motion for arguments
"=============================================================================
"
" Author:  Takahiro SUZUKI <takahiro.suzuki.ja@gmDELETEMEail.com>
" Version: 1.1.1 (Vim 7.1)
" Licence: MIT Licence
"
"=============================================================================
" Document: {{{1
"
"-----------------------------------------------------------------------------
" Description:
"   This plugin installes a text-object like motion 'a' (argument). You can
"   d(elete), c(hange), v(select)... an argument or inner argument in familiar
"   ways, such as 'daa'(delete-an-argument), 'cia'(change-inner-argument)
"   or 'via'(select-inner-argument).
"
"   What this script do is more than just typing
"     F,dt,
"   because it recognizes inclusion relationship of parentheses.
"
"   There is an option to descide whether the motion should go out to toplevel
"   function or not in nested function application.

"
"-----------------------------------------------------------------------------
" Installation:
"   Place this file in /usr/share/vim/vim*/plugin or ~/.vim/plugin/
"   Now text-object like argument motion 'ia' and 'aa' is enabled by default.
"
"-----------------------------------------------------------------------------
" Options:
"   Write below in your .vimrc if you want to apply motions to the toplevel
"   function.
"     let g:argumentobject_force_toplevel = 1
"   By default, this options is set to 0, which means your operation affects
"   to the most inner level
"
"-----------------------------------------------------------------------------
" Examples:
" case 1: delete an argument
"     function(int arg1,    char* arg2="a,b,c(d,e)")
"                              [N]  daa
"     function(int arg1)
"                     [N] daa
"     function()
"             [N]
"
" case 2: delete inner argument
"     function(int arg1,    char* arg2="a,b,c(d,e)")
"                              [N]  cia
"     function(int arg1,    )
"                          [I]
"
" case 3: smart argument recognition (g:argumentobject_force_toplevel = 0)
"     function(1, (20*30)+40, somefunc2(3, 4))
"                   [N]  cia
"     function(1, , somefunc2(3, 4))
"                [I]
"     function(1, (20*30)+40, somefunc2(3, 4))
"                                      [N]  caa
"     function(1, (20*30)+40, somefunc2(4))
"                                      [I]
"
" case 4: smart argument recognition (g:argumentobject_force_toplevel = 1)
"     function(1, (20*30)+40, somefunc2(3, 4))
"                   [N]  cia
"     function(1, , somefunc2(3, 4))
"                [I]
"     function(1, (20*30)+40, somefunc2(3, 4))
"                                      [N]  caa
"     function(1, (20*30)+40)
"                          [I]
"
"-----------------------------------------------------------------------------
" ToDo:
"   - do nothing on null parentheses '()'
"
"-----------------------------------------------------------------------------
" ChangeLog:
"   1.1.1:
"     - debug (stop beeping on using text objects). Thanks to Nadav Samet.
"
"   1.1.unreleased:
"     - support for commas in <..> (for cpp templates)
"
"   1.1:
"     - support for commas in quoted string (".."), array ([..])
"       do nothing outside a function declaration/call
"
"   1.0:
"     - Initial release
" }}}1
"=============================================================================

"if exists('loaded_argtextobj') || v:version < 701
"  finish
"endif
"let loaded_argtextobj = 1


function! s:GetOutOfDoubleQuote()
  " get out of double quoteed string (one letter before the beginning)
  let line = getline('.')
  let pos_save = getpos('.')
  let mark_b = getpos("'<")
  let mark_e = getpos("'>")
  let repl='_'
  if getline('.')[getpos('.')[2]-1]=='_'
    let repl='?'
  endif

  while 1
    exe 'silent! normal ^va"'
    normal :\<ESC>\<CR>
    if getpos("'<")==getpos("'>")
      break
    endif
    exe 'normal gvr' . repl
  endwhile

  call setpos('.', pos_save)
  if getline('.')[getpos('.')[2]-1]==repl
    " in double quote
    call setline('.', line)
    if getpos('.')==getpos("'<")
      normal h
    else
      normal F"
  endif
  else
    " not in double quote
    call setline('.', line)
  endif
endfunction

function! s:GetOuterFunctionParenthesis()
  let pos_save = getpos('.')
  let rightup_before = pos_save
  silent! normal [(
  let rightup_p = getpos('.')
  while rightup_p != rightup_before
    if ! g:argumentobject_force_toplevel && getline('.')[getpos('.')[2]-1-1] =~ '[a-zA-Z0-9_]'
      " found a function
      break
    endif
    let rightup_before = rightup_p
    silent! normal [(
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

function! s:GetPrevCommaOrBeginArgs(arglist, offset)
  let commapos = strridx(a:arglist, ',', a:offset)
  return max([commapos+1, 0])
endfunction

function! s:GetNextCommaOrEndArgs(arglist, offset)
  let commapos = stridx(a:arglist, ',', a:offset)
  if commapos == -1
    return strlen(a:arglist)-1
  endif
  return commapos-1
endfunction

function! s:MoveToNextNonSpace()
  let oldp = getpos('.')
  let moved = 0
  """echo 'move:' . getline('.')[getpos('.')[2]-1]
  while getline('.')[getpos('.')[2]-1]==' '
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

function! s:MotionArgument(inner, visual)
  let current_c = getline('.')[getpos('.')[2]-1]
  if current_c==',' || current_c=='(' " TODO
    normal l
  endif

  " get out of "double quoted string" because [( does not take effect in it
  call <SID>GetOutOfDoubleQuote()

  let rightup      = <SID>GetOuterFunctionParenthesis()       " on (
  if getline('.')[rightup[2]-1]!='(' " TODO
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
  while stridx(arglist_sub, '(')>=0 && stridx(arglist_sub, ')')>=0 " TODO
    let arglist_sub = substitute(arglist_sub , '(\([^()]\{-}\))', '\="<".substitute(submatch(1), ",", "_", "g").">"', 'g')
    """echo 'sub single quot: ' . arglist_sub
  endwhile

  " the beginning/end of this argument
  let thisargbegin = <SID>GetPrevCommaOrBeginArgs(arglist_sub, offset)
  let thisargend   = <SID>GetNextCommaOrEndArgs(arglist_sub, offset)

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
    if thisargbegin==0 && thisargend==strlen(arglist_sub)-1
      " only single argument
      call <SID>MoveLeft(left)
    elseif thisargbegin==0
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
let g:argumentobject_force_toplevel = 0

" vim: set foldmethod=marker et ts=2 sts=2 sw=2:
