" Defining functions {{{1
if !exists('g:indent#aI_reach_down')
  if &filetype == 'haskell' || &filetype == 'python'
    let g:indent#aI_reach_down = v:false
  else
    let g:indent#aI_reach_down = v:true
  endif
endif

" mode is either:
" - 'p': mimics p motion - supports counts
" - 'l': select an entire indentation level - does not support counts
" - 'b': select an indentation block - supports counts
function! indent#motion(margin, mode)
  " difference between ii and ia is only the count
  " of margins you go down
  if a:margin
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
      if getline('.') !=# ''
        execute 'normal! V'
        let l:minindent = indent('.')

        while (indent(line('.') + 1) >= l:minindent)
          execute 'normal! j'
        endwhile
        execute 'normal! o'

        while (indent(line('.') - 1) >= l:minindent)
          execute 'normal! k'
        endwhile
        execute 'normal! o'

      else
        execute 'normal! ip'
      endif

    elseif len(l:lineindents) ==# 0 || getline(line('.') + 1) == ''
      " a block of empty lines
      " behave like `ip`/`ap`
      normal! ip

    else
      " select down until you reach lower indent or empty line
      while (indent(line('.') + 1) >= l:minindent)
        execute 'normal! j'
      endwhile
    endif

    let l:count =- 1

    " special cmds, if they hit, they end the motion
    """""""""""""""""""""""""""""""""""" iI special command
    if a:mode == 'l'
      if mode() !=# 'V'
        execute 'normal! V'
      elseif !exists('l:minindent')
        execute 'normal! j'
        let l:minindent = indent(line('.'))
      endif

      while (indent(line('.') + 1) >= l:minindent || empty(getline(line('.') + 1)))
        execute 'normal! j'
        if line('.') == line('$')
          break
        endif
      endwhile

      while empty(getline('.'))
        execute 'normal! k'
      endwhile

      execute 'normal! o'

      while (indent(line('.') - 1) >= l:minindent || empty(getline(line('.') - 1)))
        execute 'normal! k'
        if line('.') == 1
          break
        endif
      endwhile

      while empty(getline('.')) && line('.') !=# line('$')
        execute 'normal! j'
      endwhile

      execute 'normal! o'

      " ignore v:count1
      return

    """""""""""""""""""""""""""""""""""" aI special command
    elseif a:mode == 'b'
      if mode() !=# 'V'
        execute 'normal! V'
      elseif !exists('l:minindent')
        execute 'normal! j'
        let l:minindent = indent(line('.'))
      endif

      if g:indent#aI_reach_down
        while (v:true)
          execute 'normal! j'
          if (indent('.') < l:minindent && !empty(getline('.'))) || line('.') ==# line('$')
            break
          endif
        endwhile

      else
        while (indent(line('.') + 1) >= l:minindent)
          execute 'normal! j'
          if line('.') == line('$')
            break
          endif
        endwhile
      endif

      execute 'normal! o'

      " walk up and cach first lower indent level
      while (v:true)
        execute 'normal! k'
        if ((indent('.') < l:minindent && !empty(getline('.'))) || line('.') ==# 1)
          break
        endif
      endwhile

      " walk back from from going up
      while empty(getline('.')) && !(line('.') ==# line('$'))
        execute 'normal! j'
      endwhile

      execute 'normal! o'

      " ignore v:count1
      return
    endif
  endfor
endfunction
