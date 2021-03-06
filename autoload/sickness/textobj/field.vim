" ORIGINAL Author:  Takahiro SUZUKI <takahiro.suzuki.ja@gmDELETEMEail.com>
" Version: 1.1.1 (Vim 7.1)
" Licence: MIT Licence

" Terminology:
" - fielddelim: typically comma, might be semicolon, etc.
" - opendelim: ({[<
" - closedelim: )}]>
" - blanks: space and tab
" - field character: everything except blanks, linefeeds, and fielddelim
"   '[^ \t\n'.a:fielddelim.']'

" Making an inner field to an all field:
" Algorithm:
" (*) for head element:
" - delete elem
" - delete right till first field character
" - DONE

" (*) for middle/tail element:
" - delete elem
" - check if on right is field character before newline
"   | if not:
"     - delete left until first field character
"     - DONE
"   | if yes:
"     - delete fielddelim and blanks on right
"     - DONE

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

function! s:GetOutOfDoubleQuote() abort
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
    execute 'silent! normal ^va"'
    normal :\<ESC>\<CR>
    if getpos("'<") ==# getpos("'>")
      break
    endif
    execute 'normal gvr' . repl
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

function! s:GetDelimPos(opendelim) abort
  let l:winsave = winsaveview()
  let l:reg_save = @@

  execute 'silent! normal! va' . a:opendelim
  let l:closedelim_pos = getpos('.')

  execute "silent! normal! %"
  let l:opendelim_pos = getpos('.')

  call winrestview(l:winsave)
  return [l:opendelim_pos, l:closedelim_pos]
endfunction

function! s:GetInnerText(opendelim_pos, closedelim_pos) abort
  let l:result = []

  if a:closedelim_pos[1] < a:opendelim_pos[1]
    return l:result
  endif

  for i in range(a:opendelim_pos[1], a:closedelim_pos[1])
    if (i ==# a:opendelim_pos[1] && i ==# a:closedelim_pos[1]) " single line
      let l:theline = strcharpart(getline(i), a:opendelim_pos[2], a:closedelim_pos[2] - a:opendelim_pos[2] - 1)

    elseif (i ==# a:opendelim_pos[1]) " firstline
      let l:theline = strcharpart(getline(i), a:opendelim_pos[2])

    elseif (i ==# a:closedelim_pos[1]) " lastline
      let l:theline = strcharpart(getline(i), 0, a:closedelim_pos[2] - 1)

    else " middleline
      let l:theline = getline(i)
    endif

    call add(l:result, l:theline)
  endfor

  return l:result
endfunction

"" return [position, isheadfield]
function! s:GetPrevCommaOrBeginArgs(innertext, offset, fielddelim) abort
  let commapos_prev = max([strridx(a:innertext, a:fielddelim, a:offset) + 1, 0])

  if commapos_prev == 0
    return [commapos_prev, v:true]
  else
    return [commapos_prev, v:false]
  endif

endfunction

"" return [position, istailfield]
function! s:GetNextCommaOrEndArgs(innertext, offset, fielddelim) abort
  let l:commapos_next = stridx(a:innertext, a:fielddelim, a:offset)

  if l:commapos_next ==# -1
    return [strlen(a:innertext) - 1, v:true]
  else
    return [l:commapos_next - 1, v:false]
  endif
endfunction

function! s:MoveToNextNonSpace() abort
  let oldp = getpos('.')
  let moved = 0
  while getline('.')[getpos('.')[2]-1] ==# ' ' || 
    normal l
    if oldp == getpos('.')
      break
    endif
    let oldp = getpos('.')
    let moved += 1
  endwhile
  return moved
endfunction

function! s:Move(num) abort
  if a:num < 0
    execute 'normal ' . a:num . "\<bs>"
  elseif a:num > 0
    execute 'normal ' . a:num . ' '
  endif
endfunction

"""
" the offset means:
" you can stand on a:startpoint and `execute 'normal! '.l:offset.' '`
" you'll end up on a:pos

" now gets the text offset in the text
"""
function! s:GetPositionOffset(startpoint, pos) abort
  let l:offset = 0

  if a:pos[1] < a:startpoint[1] || (a:pos[1] == a:startpoint[1] && a:pos[2] < a:startpoint[2])
    " echomsg 'startpoint behind'
    return [-1, -1]
  endif

  for i in range(a:startpoint[1], a:pos[1])
    if i ==# a:startpoint[1]
      if i ==# a:pos[1]
        let l:offset += (a:pos[2] - a:startpoint[2])
      else
        let l:offset += strchars(getline(i)) - a:startpoint[2]
      end
    elseif i < a:pos[1]
      let l:offset += strchars(getline(i))
    else
      let l:offset += a:pos[2]
    endif
  endfor

  let l:offsetInInnerText = l:offset - ((a:startpoint[1] - a:pos[1]) + 1)

  return [l:offset, l:offsetInInnerText]
endfunction

function! sickness#textobj#field#motion(all, visual, opendelim, closedelim, fielddelim) abort
  " echomsg mode() -> either "n" or "v"
  let winsave = winsaveview()
  let modesave = mode()
  let before_pos = getpos('.')
  let before_posv = getpos('v')

  if modesave == 'v'
    normal! 
  endif

  if a:closedelim ==# ']'
    let l:closedelim_mod = '\'.a:closedelim
  else
    let l:closedelim_mod = a:closedelim
  endif

  if a:opendelim ==# '['
    let l:opendelim_mod = '\'.a:opendelim
  else
    let l:opendelim_mod = a:opendelim
  endif

  " Avoid dealing with ambiguity on called field on fielddelim
  let current_c = strcharpart(getline('.'), col('.') - 1, 1)
  if current_c ==# a:opendelim || current_c ==# a:fielddelim
    normal 1 
  endif

  let l:current_pos = getpos('.')

  " get out of "double quoted string" because [( does not take effect in it
  call s:GetOutOfDoubleQuote()

  let [l:opendelim_pos, l:closedelim_pos] = s:GetDelimPos(a:opendelim)
  let l:innertext_orig = s:GetInnerText(l:opendelim_pos, l:closedelim_pos)

  if empty(l:innertext_orig)
    silent normal! 
    call winrestview(winsave)
    if modesave == 'v'
        call setpos('.', before_posv)
        silent normal! v
        call setpos('.', before_pos)
    endif
    return
  endif

  let l:innertext = join(l:innertext_orig, "\n")

  " replace all parentheses and commas inside them to '_'
  let l:innertext = substitute(l:innertext, "'".'\([^'."'".']\{-}\)'."'", '\="(".substitute(submatch(1), ".", "_", "g").")"', 'g') " replace '..' => (__)
  let l:innertext = substitute(l:innertext, '\[\([^'."'".']\{-}\)\]', '\="(".substitute(submatch(1), ".", "_", "g").")"', 'g')     " replace [..] => (__)
  let l:innertext = substitute(l:innertext, '<\([^'."'".']\{-}\)>', '\="(".substitute(submatch(1), ".", "_", "g").")"', 'g')       " replace <..> => (__I
  let l:innertext = substitute(l:innertext, '"\([^'."'".']\{-}\)"', '(\1)', 'g') " replace ''..'' => (..)

  " replaces commas:
  while stridx(l:innertext, a:opendelim) >= 0
        \ && stridx(l:innertext, a:closedelim) >= 0
    let l:innertext = substitute(l:innertext, '(\([^()]\{-}\))', '\="<".substitute(submatch(1), ",", "_", "g").">"', 'g')
  endwhile

  let [l:offsetJump, l:offset] = s:GetPositionOffset(l:opendelim_pos, l:current_pos)

  if l:offsetJump <=# 0
    silent normal! 
    call winrestview(winsave)
    if modesave == 'v'
        call setpos('.', before_posv)
        silent normal! v
        call setpos('.', before_pos)
    endif
    return
  endif

  " the beginning/end of this argument they don't work
  let [l:fieldbegin, l:isheadfield] = s:GetPrevCommaOrBeginArgs(l:innertext, l:offset, a:fielddelim)
  let [l:fieldend, l:istailfield]   = s:GetNextCommaOrEndArgs(l:innertext, l:offset, a:fielddelim)

  let l:fieldbeginJump = l:fieldbegin - (l:offset - l:offsetJump) " - (l:current_pos[1] - l:opendelim_pos[1])
  let l:fieldendJump   = l:fieldend - (l:offset - l:offsetJump) " - (l:closedelim_pos[1] - l:current_pos[1])

  " echo l:innertext_orig
  " Deal with one off errors
  if match(l:innertext_orig[0], '[^ \t\n]') ==# -1
    " echo 'empty firstline'
    let l:fieldbeginJump += 1
  endif

  if match(l:innertext_orig[-1], '[^ \t\n]') ==# -1
    " echo 'empty lastline'
    let l:fieldendJump -= 1

    " deal with trailing symbol ambiguity
    if !l:istailfield && match(l:innertext_orig[-1], '[^ \t\n]') ==# -1
      let l:fieldendJump += 1
    endif
  endif

  " TODO Note that after this, opening delimiter indented field still have a one off error
  " in a middle argument on the second line, however this should not affect anything

  normal! 

"   """" Positions
"   echo '========================================='
"   echo 'innertext "'.string(l:innertext).'"'
"   echo 'opendelim_pos: "'.string(l:opendelim_pos).'"'
"   echo 'closedelim_pos: "'.string(l:closedelim_pos).'"'
"   echo '========================================='

"   """" Offsets in l:innertext
"   echo 'fieldbegin: "'.string(l:fieldbegin).'" "'.l:innertext[l:fieldbegin].'"'
"   echo 'offset: "'.string(l:offset).'" "'.l:innertext[l:offset].'"'
"   echo 'fieldend: "'.string(l:fieldend).'" "'.l:innertext[l:fieldend].'"'
"   echo '========================================='

"   """" Offsets in terms of moving with space/backspace
"   echo 'fieldbeginJump: "'.string(l:fieldbeginJump).'"'
"   echo 'offsetJump: "'.string(l:offsetJump).'"'
"   echo 'fieldendJump: "'.string(l:fieldendJump).'"'
"   echo '========================================='

  """ GET START OF INNER FIELD
  call setpos('.', l:opendelim_pos)

  " start 1 space before field, so the search
  " starts in the first character of the field
  if ! l:isheadfield " (l:fieldbeginJump) ># 0
    execute 'normal! '.(l:fieldbeginJump).' '
  endif

  call search('[^ \t\n'.a:fielddelim.l:opendelim_mod.']')
  let l:startpos = getpos('.')

  """ GET END OF INNER FIELD
  call setpos('.', l:opendelim_pos)
  execute 'normal! '.(l:fieldendJump + 1).' '

  call search('[^ \t\n'.a:fielddelim.']', 'b')
  let l:endpos = getpos('.')

  """ SET FIELD

  " if field is empty and you're inner, you startpos will be behind endpos
  if (l:startpos[1] ># l:endpos[1]) ||
        \ (l:startpos[1] ==# l:endpos[1] && l:startpos[2] ># l:endpos[2])

    if a:all " you'll still be able delete the fielddelim
      let l:startpos = l:current_pos
      let l:endpos = l:current_pos
    else
      silent normal! 
      call winrestview(winsave)
      if modesave == 'v'
        call setpos('.', before_posv)
        silent normal! v
        call setpos('.', before_pos)
      endif
      return
    endif
  endif

  let l:innerparen = v:false

  if a:all
    " (*) for single element:
    " - delete elem
    " - check if elem on same line as opendelim, but not as closedelim
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

    if l:isheadfield && l:istailfield
      " " leading symbol style behaves a bit different than i<delim>

      " echo 'single elem'
      " trailing symbol style, leading symbol style
      if (l:opendelim_pos[1] ==# l:startpos[1]) &&
            \ (l:endpos[1] !=# l:closedelim_pos[1])
        call setpos('.', l:startpos)
        " echo 'single elem1'

        call search('[^ \t\n'.a:fielddelim.']', 'Wb')
        execute "normal! 1 "
        let l:startpos = getpos('.')

        " leading symbol style
        if l:opendelim_pos[2] == l:closedelim_pos[2]
          call setpos('.', l:opendelim_pos)
          execute "normal! 1 "
          let l:startpos = getpos('.')
          execute "normal! $"
          let l:endpos = getpos('.')

        else
          call setpos('.', l:endpos)
          call search('[^ \t\n'.a:fielddelim.']', 'W')
          execute "normal! 1\<bs>"
          let l:endpos = getpos('.')
        endif
      else
        " echo 'single elem2'
        call setpos('.', l:startpos)
        call search('[^ \t\n'.a:fielddelim.']', 'Wb')
        execute "normal! 1 "
        let l:startpos = getpos('.')

        call setpos('.', l:endpos)
        call search('[^ \t\n'.a:fielddelim.']', 'W')
        execute "normal! 1\<bs>"
        let l:endpos = getpos('.')

        let l:innerparen = v:true
      endif

      " " (*) for head element:
      " " - delete elem
      " " - delete right till first field character
      " " - DONE
    elseif l:isheadfield
      " echo 'head elem'
      call setpos('.', l:endpos)
      call search('[^ \t\n'.a:fielddelim.']', 'W')

      execute "normal! 1\<bs>"
      let l:endpos = getpos('.')

      " check if maybe actually single field
      " in trailing symbol style with trailing comma
      call search('[^ \t\n]', 'W')
      if getline('.')[col('.') - 1] == a:closedelim
        let l:innerparen = v:true
      endif

      " (*) for middle/tail element:
      " - delete elem
      " - check if on right is field character before you reach closedelim or eol
      "   | if yes (short style OR opening-delim style, you don't want to delete the "gap"):
      "     - delete right until first field character
      "     - DONE
      "   | if not:
      "     - check if on fielddelim is on the left (for leading)
      "       | if yes
      "         - delete left till fielddelim (including)
      "         - delete right till fielddelim or closeparen (excluding)
      "       | if not
      "         - delete left until first field character
      "         - DONE
    else
      call setpos('.', l:endpos)

      let l:idx = match(getline('.'), '[^ \t\n'.a:fielddelim.']', col('.'))
      let l:maybeclosedelim = getline('.')[l:idx]

      if l:idx != -1 && l:maybeclosedelim != a:closedelim
        " echo 'idx: "'.l:idx.'"'
        " echo 'maybecldel: "'.l:maybeclosedelim.'"'
        " there is a field on the right
        " (e.g. short style, or delimiter intended style)
        call search('[^ \t\n'.a:fielddelim.']', 'W')
        execute "normal! 1\<bs>"
        let l:endpos = getpos('.')

      else
        call setpos('.', l:startpos)
        call search(a:fielddelim, 'Wb')

        if getpos('.')[1] ==# l:startpos[1]
          " leading symbol style
          let l:startpos = getpos('.')
          call setpos('.', l:endpos)
          call search('['.a:fielddelim.l:closedelim_mod.']', 'W')
          execute "normal! 1\<bs>"
          let l:endpos = getpos('.')

        else
          " trailing symbol style
          call search('[^ \t\n'.a:fielddelim.']', 'Wb')
          execute "normal! 1 "
          let l:startpos = getpos('.')
        endif

      endif
    end
  endif

  if l:innerparen
    execute "normal! vi".a:opendelim
  else
    call setpos('.', l:startpos)
    normal! v
    call setpos('.', l:endpos)
  endif
endfunction
