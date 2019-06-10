" Defining functions {{{1

" only having blank characters counts as empty
function! s:IsLineEmpty(line)
  return match(a:line, '[^ \t]') ==# -1
endfunction


""select the inner level independent of current mode etc
function! s:SelectInnerLevel(minindent, include_emptylines)
      if mode() !=# 'V'
        execute 'normal! V'
      endif

      while (indent(line('.') + 1) >= a:minindent) || s:IsLineEmpty(getline(line('.') + 1))
        execute 'normal! j'
        if line('.') == line('$')
          break
        endif
      endwhile

      " get top line
      if !a:include_emptylines
        while s:IsLineEmpty(getline('.'))
          execute 'normal! k'
        endwhile
      endif

      execute 'normal! o'

      while (indent(line('.') - 1) >= a:minindent) || s:IsLineEmpty(getline(line('.') - 1))
        execute 'normal! k'
        if line('.') == 1
          break
        endif
      endwhile

      if !a:include_emptylines
        while s:IsLineEmpty(getline('.')) && line('.') !=# line('$')
          execute 'normal! j'
        endwhile
      endif

      "return with cursor at bottom
      execute 'normal! o'
endfunction

" mode is either:
" - 'p': mimics *p* motion - supports counts
" - 'b': select an indentation *b*lock - supports counts
" - 't': select an indentation level plus *t*op line - support counts

" - 'l': select an entire indentation *l*evel - does not support counts
function! indent#motion(margin, mode)
  " difference between ii and ia is only the count

  " for indent paragraph motion
  " for other modes, the count means whether to include whitespace
  if a:mode == 'p' && a:margin
    let l:count = v:count1 * 2
  else
    let l:count = v:count1
  endif

  for i in range(l:count)
    if mode() ==# 'V'
      let l:linenos = range(min([line('.'), line('v')]), max([line('.'), line('v')]))
      let l:visualselection = map(copy(l:linenos), 'getline(v:val)')
      let l:lineindents = map(
            \ filter(copy(l:visualselection), 'v:val !=# ""'),
            \ 'strlen(substitute(substitute(v:val, ''\s*\zs.*\ze'', '''', ''''), ''\t'', repeat('' '', &tabstop), ''g''))')
      let l:minindent = min(l:lineindents)
    endif

    if mode() !=# 'V'
      " first `ii`/`ai`
      if !s:IsLineEmpty(getline('.'))
        " Get first viable block
        let l:minindent = indent('.')
        execute 'normal! V'

        while (!s:IsLineEmpty(getline(line('.') + 1)) && indent(line('.') + 1) >= l:minindent)
          execute 'normal! j'
        endwhile
        execute 'normal! o'

        while (!s:IsLineEmpty(getline(line('.') - 1)) && indent(line('.') - 1) >= l:minindent)
          execute 'normal! k'
        endwhile
        execute 'normal! o'

      else
        if mode() !=# 'v'
          execute 'normal! vip'
        else
          execute 'normal! ip'
        endif
      endif

    elseif len(l:lineindents) ==# 0 || s:IsLineEmpty(getline(line('.') + 1))
      " a block of empty lines
      " behave like `ip`/`ap`
      normal! ip

    else
      " select down until you reach lower indent or empty line
      while !s:IsLineEmpty(getline(line('.') + 1)) && (indent(line('.') + 1) >= l:minindent)
        execute 'normal! j'
      endwhile
    endif

    """"""""""""""""""""""""""""""""""""""""
    " special cmds
    """"""""""""""""""""""""""""""""""""""""
    if a:mode !=# 'p'
      " set minindent
      if !exists('l:minindent')
        let l:winsave = winsaveview()
        while(s:IsLineEmpty(getline('.')))
          execute 'normal! j'
        endwhile

        let l:minindent = indent(line('.'))
        call winrestview(l:winsave)
      endif

      let l:include_emptylines = a:margin
      call s:SelectInnerLevel(l:minindent, l:include_emptylines)

      "" reach up
      if a:mode ==# 'b' || a:mode ==# 't'
        " walk up and cach first lower indent level
        execute 'normal! o'

        while (v:true)
          execute 'normal! k'
          if ((indent('.') < l:minindent && !s:IsLineEmpty(getline('.'))) || line('.') ==# 1)
            break
          endif
        endwhile

        if l:include_emptylines
          " walk further up to include empty lines
          while  line('.') !=# 1 && s:IsLineEmpty(getline(line('.') - 1))
            execute 'normal! k'
          endwhile
        endif

        execute 'normal! o'
      endif

      " reach down
      if a:mode ==# 'b'

        while (v:true)
          execute 'normal! j'
          if ((indent('.') < l:minindent && !s:IsLineEmpty(getline('.'))) || line('.') ==# line('$'))
            break
          endif
        endwhile

        if l:include_emptylines
          " walk further down to include empty lines
          while line('.') !=# line('$') && s:IsLineEmpty(getline(line('.') + 1))
            execute 'normal! j'
          endwhile
        endif

      endif

    endif
  endfor
endfunction
