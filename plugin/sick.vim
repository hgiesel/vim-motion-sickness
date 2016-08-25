" This plugin adds a lot of motion mappings. Here's a list
" 1.
" `ir`, `ar`, `ia`, and `aa` where `r` and `a` are aliases for `[` and `<`
" (similiar to tpopes' vim-surround plugin
" Symbol aliases

" 2.
" `i_`, `a_` and family, which are a lot of motions that work like `ab` or
" `aB` but with symbols

" 3.
" `qb` `qB` `qr` `qa` which are motions that select statements, e.g.
" foo(500 + 500))o)o
" while you would use `ib` to select everything within the parentheses and
" `ab` to select the whole parenthesis, you can use `qb` to use the whole
" parenthesis and the word before it. Also works with $(( )) or similiar
" things

" 4.
" `iqb` `aqb`, etc. is used to select parameters (or arguments) within
" braces, very helpful for any kind of programming language

" 5.
" Planned for the future are:
" a. `qd` `qD` `Qd` `QD` is used to select dot statements, e.g. test().arg[50]
" (default: `.`)
" q works how far it should go left
" d works how far it should go right
" b. `qn` to select namespace statements std::cout (default: `:`)
" c. `qw` select arrow statements (in C: ->) with `<` characters splattered over
" the place (default: `->`)

" 6.
" a. `qe`, `Qe` to select equal statements
" b. `qc` to select colon (key: value) statements
" c. `qh` to select haskell statements

" 7.
" iz: select current indentation delimited by lines with one indentation less or
" empty lines
" az: select current indentation delimited by lines with one indentation less
" (which are included) or empty lines

" iZ: select current indentation delimited by lines with one indentation less
" (note that this would select the whole file on an empty line)
" aZ: select current indentation delimited by lines with one indentation less
" (which are included) (note that this on an indentation of zero would select
" the whole file)

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
omap <silent> ir i[
vmap <silent> ir i[
omap <silent> ar a[
vmap <silent> ar a[

omap <silent> ia i<
vmap <silent> ia i<
omap <silent> aa a<
vmap <silent> aa a<
" }}}1

" Symbol Motion {{{1
omap i* <plug>OIAsteriskSmotion
vmap i* <plug>VIAsteriskSmotion
omap a* <plug>OAAsteriskSmotion
vmap a* <plug>VAAsteriskSmotion

omap i_ <plug>OIUnderscoreSmotion
vmap i_ <plug>VIUnderscoreSmotion
omap a_ <plug>OAUnderscoreSmotion
vmap a_ <plug>VAUnderscoreSmotion

omap i- <plug>OIDashSmotion
vmap i- <plug>VIDashSmotion
omap a- <plug>OADashSmotion
vmap a- <plug>VADashSmotion

omap i: <plug>OIColonSmotion
vmap i: <plug>VIColonSmotion
omap a: <plug>OAColonSmotion
vmap a: <plug>VAColonSmotion

omap i@ <plug>OIAtSmotion
vmap i@ <plug>VIAtSmotion
omap a@ <plug>OAAtSmotion
vmap a@ <plug>VAAtSmotion

omap i! <plug>OIBangSmotion
vmap i! <plug>VIBangSmotion
omap a! <plug>OABangSmotion
vmap a! <plug>VABangSmotion

omap i? <plug>OIQuestionSmotion
vmap i? <plug>VIQuestionSmotion
omap a? <plug>OAQuestionSmotion
vmap a? <plug>VAQuestionSmotion

omap i/ <plug>OISlashSmotion
vmap i/ <plug>VISlashSmotion
omap a/ <plug>OASlashSmotion
vmap a/ <plug>VASlashSmotion

omap i% <plug>OIPercentSmotion
vmap i% <plug>VIPercentSmotion
omap a% <plug>OAPercentSmotion
vmap a% <plug>VAPercentSmotion

omap i<bar> <plug>OIPipeSmotion
vmap i<bar> <plug>VIPipeSmotion
omap a<bar> <plug>OAPipeSmotion
vmap a<bar> <plug>VAPipeSmotion

onoremap <silent> <plug>OIAsteriskSmotion
      \ :<c-u>call <sid>sick_symbol_motion(v:false, '*', 'o')<cr>
vnoremap <silent> <plug>VIAsteriskSmotion
      \ :<c-u>call <sid>sick_symbol_motion(v:false, '*', 'v')<cr>
onoremap <silent> <plug>OAAsteriskSmotion
      \ :<c-u>call <sid>sick_symbol_motion(v:true, '*', 'o')<cr>
vnoremap <silent> <plug>VAAsteriskSmotion
      \ :<c-u>call <sid>sick_symbol_motion(v:true, '*', 'v')<cr>

onoremap <silent> <plug>OIUnderscoreSmotion
      \ :<c-u>call <sid>sick_symbol_motion(v:false, '_', 'o')<cr>
vnoremap <silent> <plug>VIUnderscoreSmotion
      \ :<c-u>call <sid>sick_symbol_motion(v:false, '_', 'v')<cr>
onoremap <silent> <plug>OAUnderscoreSmotion
      \ :<c-u>call <sid>sick_symbol_motion(v:true, '_', 'o')<cr>
vnoremap <silent> <plug>VAUnderscoreSmotion
      \ :<c-u>call <sid>sick_symbol_motion(v:true, '_', 'v')<cr>

onoremap <silent> <plug>OIDashSmotion
      \ :<c-u>call <sid>sick_symbol_motion(v:false, '-', 'o')<cr>
vnoremap <silent> <plug>VIDashSmotion
      \ :<c-u>call <sid>sick_symbol_motion(v:false, '-', 'v')<cr>
onoremap <silent> <plug>OADashSmotion
      \ :<c-u>call <sid>sick_symbol_motion(v:true, '-', 'o')<cr>
vnoremap <silent> <plug>VADashSmotion
      \ :<c-u>call <sid>sick_symbol_motion(v:true, '-', 'v')<cr>

onoremap <silent> <plug>OIColonSmotion
      \ :<c-u>call <sid>sick_symbol_motion(v:false, ':', 'o')<cr>
vnoremap <silent> <plug>VIColonSmotion
      \ :<c-u>call <sid>sick_symbol_motion(v:false, ':', 'v')<cr>
onoremap <silent> <plug>OAColonSmotion
      \ :<c-u>call <sid>sick_symbol_motion(v:true, ':', 'o')<cr>
vnoremap <silent> <plug>VAColonSmotion
      \ :<c-u>call <sid>sick_symbol_motion(v:true, ':', 'v')<cr>

onoremap <silent> <plug>OIAtSmotion
      \ :<c-u>call <sid>sick_symbol_motion(v:false, '@', 'o')<cr>
vnoremap <silent> <plug>VIAtSmotion
      \ :<c-u>call <sid>sick_symbol_motion(v:false, '@', 'v')<cr>
onoremap <silent> <plug>OAAtSmotion
      \ :<c-u>call <sid>sick_symbol_motion(v:true, '@', 'o')<cr>
vnoremap <silent> <plug>VAAtSmotion
      \ :<c-u>call <sid>sick_symbol_motion(v:true, '@', 'v')<cr>

onoremap <silent> <plug>OIBangSmotion
      \ :<c-u>call <sid>sick_symbol_motion(v:false, '!', 'o')<cr>
vnoremap <silent> <plug>VIBangSmotion
      \ :<c-u>call <sid>sick_symbol_motion(v:false, '!', 'v')<cr>
onoremap <silent> <plug>OABangSmotion
      \ :<c-u>call <sid>sick_symbol_motion(v:true, '!', 'o')<cr>
vnoremap <silent> <plug>VABangSmotion
      \ :<c-u>call <sid>sick_symbol_motion(v:true, '!', 'v')<cr>

onoremap <silent> <plug>OIQuestionSmotion
      \ :<c-u>call <sid>sick_symbol_motion(v:false, '?', 'o')<cr>
vnoremap <silent> <plug>VIQuestionSmotion
      \ :<c-u>call <sid>sick_symbol_motion(v:false, '?', 'v')<cr>
onoremap <silent> <plug>OAQuestionSmotion
      \ :<c-u>call <sid>sick_symbol_motion(v:true, '?', 'o')<cr>
vnoremap <silent> <plug>VAQuestionSmotion
      \ :<c-u>call <sid>sick_symbol_motion(v:true, '?', 'v')<cr>

onoremap <silent> <plug>OISlashSmotion
      \ :<c-u>call <sid>sick_symbol_motion(v:false, '/', 'o')<cr>
vnoremap <silent> <plug>VISlashSmotion
      \ :<c-u>call <sid>sick_symbol_motion(v:false, '/', 'v')<cr>
onoremap <silent> <plug>OASlashSmotion
      \ :<c-u>call <sid>sick_symbol_motion(v:true, '/', 'o')<cr>
vnoremap <silent> <plug>VASlashSmotion
      \ :<c-u>call <sid>sick_symbol_motion(v:true, '/', 'v')<cr>

onoremap <silent> <plug>OIPercentSmotion
      \ :<c-u>call <sid>sick_symbol_motion(v:false, '%', 'o')<cr>
vnoremap <silent> <plug>VIPercentSmotion
      \ :<c-u>call <sid>sick_symbol_motion(v:false, '%', 'v')<cr>
onoremap <silent> <plug>OAPercentSmotion
      \ :<c-u>call <sid>sick_symbol_motion(v:true, '%', 'o')<cr>
vnoremap <silent> <plug>VAPercentSmotion
      \ :<c-u>call <sid>sick_symbol_motion(v:true, '%', 'v')<cr>

onoremap <silent> <plug>OIPipeSmotion
      \ :<c-u>call <sid>sick_symbol_motion(v:false, '<bar>', 'o')<cr>
vnoremap <silent> <plug>VIPipeSmotion
      \ :<c-u>call <sid>sick_symbol_motion(v:false, '<bar>', 'v')<cr>
onoremap <silent> <plug>OAPipeSmotion
      \ :<c-u>call <sid>sick_symbol_motion(v:true, '<bar>', 'o')<cr>
vnoremap <silent> <plug>VAPipeSmotion
      \ :<c-u>call <sid>sick_symbol_motion(v:true, '<bar>', 'v')<cr>

function! s:sick_symbol_motion(wrap, symbol, mode)
  let l:start_col = col('.')
  let l:valid     = v:true

  " A
  " Find opening col to the left
  silent! execute 'normal! F' . a:symbol

  if col('.') ==# l:start_col
    " Find opening col to the right
    silent! execute 'normal! f' . a:symbol

    if col('.') ==# l:start_col
      " There is no open_col
      let l:valid = v:false
    end
  endif

  " B
  " Find closing col
  if l:valid
    if !a:wrap
      " Go one right in order to be inside symbols
      execute "normal! l"

      " If you use di<symbol> inside symbol, it won't delete anything
      if getline('.')[l:start_col - 1] == getline('.')[l:start_col]
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
    " Note: This is not like the normal linewise operators behave, but is very useful
    if a:mode ==# 'v'
      execute 'normal! ' . col("'>") . '|'
    endif

    execute 'normal! f' . a:symbol
    if col('.') ==# l:open_col
      " If no close_pol found
      let l:valid = v:false
    end

    " if no wrap, go once to the right
    if l:valid && !a:wrap
      execute "normal! h"
    endif
  endif

  " C
  " Cleanup if invalid
  if !l:valid
    execute 'normal! v' . l:start_col . '|'
    if a:mode ==# 'v'
      execute 'normal! v'
    endif
  endif
endfunction
" }}}1

" qb Motion {{{1
omap qb <plug>Oqbmotion
vmap qb <plug>Vqbmotion
omap Qb <plug>OQbmotion
vmap Qb <plug>VQbmotion

omap qB <plug>OqBmotion
vmap qB <plug>VqBmotion
omap QB <plug>OQBmotion
vmap QB <plug>VQBmotion

omap qr <plug>Oqrmotion
vmap qr <plug>Vqrmotion
omap Qr <plug>OQrmotion
vmap Qr <plug>VQrmotion

omap qa <plug>Oqamotion
vmap qa <plug>Vqamotion
omap Qa <plug>OQamotion
vmap Qa <plug>VQamotion

onoremap <silent> <plug>Oqbmotion
      \ :<c-u>call <sid>sick_qb_motion(getpos('.'), '(', ')', v:false)<cr>
vnoremap <silent> <plug>Vqbmotion
      \ :<c-u>call <sid>sick_qb_motion(getpos('.'), '(', ')', v:false)<cr>
onoremap <silent> <plug>OQbmotion
      \ :<c-u>call <sid>sick_qb_motion(getpos('.'), '(', ')', v:true)<cr>
vnoremap <silent> <plug>VQbmotion
      \ :<c-u>call <sid>sick_qb_motion(getpos('.'), '(', ')', v:true)<cr>

onoremap <silent> <plug>OqBmotion
      \ :<c-u>call <sid>sick_qb_motion(getpos('.'), '{', '}', v:false)<cr>
vnoremap <silent> <plug>VqBmotion
      \ :<c-u>call <sid>sick_qb_motion(getpos('.'), '{', '}', v:false)<cr>
onoremap <silent> <plug>OQBmotion
      \ :<c-u>call <sid>sick_qb_motion(getpos('.'), '{', '}', v:true)<cr>
vnoremap <silent> <plug>VQBmotion
      \ :<c-u>call <sid>sick_qb_motion(getpos('.'), '{', '}', v:true)<cr>

onoremap <silent> <plug>Oqrmotion
      \ :<c-u>call <sid>sick_qb_motion(getpos('.'), '[', ']', v:false)<cr>
vnoremap <silent> <plug>Vqrmotion
      \ :<c-u>call <sid>sick_qb_motion(getpos('.'), '[', ']', v:false)<cr>
onoremap <silent> <plug>OQrmotion
      \ :<c-u>call <sid>sick_qb_motion(getpos('.'), '[', ']', v:true)<cr>
vnoremap <silent> <plug>VQrmotion
      \ :<c-u>call <sid>sick_qb_motion(getpos('.'), '[', ']', v:true)<cr>

onoremap <silent> <plug>Oqamotion
      \ :<c-u>call <sid>sick_qb_motion(getpos('.'), '<', '>', v:false)<cr>
vnoremap <silent> <plug>Vqamotion
      \ :<c-u>call <sid>sick_qb_motion(getpos('.'), '<', '>', v:false)<cr>
onoremap <silent> <plug>OQamotion
      \ :<c-u>call <sid>sick_qb_motion(getpos('.'), '<', '>', v:true)<cr>
vnoremap <silent> <plug>VQamotion
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
omap iqb <plug>Oiqbmotion
vmap iqb <plug>Viqbmotion
omap iQb <plug>OiQbmotion
vmap iQb <plug>ViQbmotion

omap aqb <plug>Oaqbmotion
vmap aqb <plug>Vaqbmotion
omap aQb <plug>OaQbmotion
vmap aQb <plug>VaQbmotion

omap iqB <plug>OiqBmotion
vmap iqB <plug>ViqBmotion
omap iQB <plug>OiQBmotion
vmap iQB <plug>ViQBmotion

omap aqB <plug>OaqVmotion
vmap aqB <plug>VaqVmotion
omap aQB <plug>OaQVmotion
vmap aQB <plug>VaQVmotion

omap iqr <plug>Oiqrmotion
vmap iqr <plug>Viqrmotion
omap iQr <plug>OiQrmotion
vmap iQr <plug>ViQrmotion

omap aqr <plug>Oaqrmotion
vmap aqr <plug>Vaqrmotion
omap aQr <plug>OaQrmotion
vmap aQr <plug>VaQrmotion

omap iqa <plug>Oiqamotion
vmap iqa <plug>Viqamotion
omap iQa <plug>OiQamotion
vmap iQa <plug>ViQamotion

omap aqa <plug>Oaqamotion
vmap aqa <plug>Vaqamotion
omap aQa <plug>OaQamotion
vmap aQa <plug>VaQamotion

onoremap <silent> <plug>Oiqbmotion :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '(', ')', ',', v:false)<cr>
vnoremap <silent> <plug>Viqbmotion :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '(', ')', ',', v:false)<cr>
onoremap <silent> <plug>OiQbmotion :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '(', ')', ';', v:false)<cr>
vnoremap <silent> <plug>ViQbmotion :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '(', ')', ';', v:false)<cr>

onoremap <silent> <plug>Oiqbmotion :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '(', ')', ',', v:true)<cr>
vnoremap <silent> <plug>Viqbmotion :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '(', ')', ',', v:true)<cr>
onoremap <silent> <plug>OiQbmotion :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '(', ')', ';', v:true)<cr>
vnoremap <silent> <plug>ViQbmotion :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '(', ')', ';', v:true)<cr>

onoremap <silent> <plug>OiqBmotion :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '{', '}', ',', v:false)<cr>
vnoremap <silent> <plug>ViqBmotion :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '{', '}', ',', v:false)<cr>
onoremap <silent> <plug>OiQBmotion :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '{', '}', ';', v:false)<cr>
vnoremap <silent> <plug>ViQBmotion :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '{', '}', ';', v:false)<cr>

onoremap <silent> <plug>OiqBmotion :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '{', '}', ',', v:true)<cr>
vnoremap <silent> <plug>ViqBmotion :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '{', '}', ',', v:true)<cr>
onoremap <silent> <plug>OiQBmotion :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '{', '}', ';', v:true)<cr>
vnoremap <silent> <plug>ViQBmotion :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '{', '}', ';', v:true)<cr>

onoremap <silent> <plug>Oiqrmotion :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '[', ']', ',', v:false)<cr>
vnoremap <silent> <plug>Viqrmotion :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '[', ']', ',', v:false)<cr>
onoremap <silent> <plug>OiQrmotion :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '[', ']', ';', v:false)<cr>
vnoremap <silent> <plug>ViQrmotion :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '[', ']', ';', v:false)<cr>

onoremap <silent> <plug>Oiqrmotion :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '[', ']', ',', v:true)<cr>
vnoremap <silent> <plug>Viqrmotion :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '[', ']', ',', v:true)<cr>
onoremap <silent> <plug>OiQrmotion :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '[', ']', ';', v:true)<cr>
vnoremap <silent> <plug>ViQrmotion :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '[', ']', ';', v:true)<cr>

onoremap <silent> <plug>Oiqamotion :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '<', '>', ',', v:false)<cr>
vnoremap <silent> <plug>Viqamotion :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '<', '>', ',', v:false)<cr>
onoremap <silent> <plug>OiQamotion :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '<', '>', ';', v:false)<cr>
vnoremap <silent> <plug>ViQamotion :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '<', '>', ';', v:false)<cr>

onoremap <silent> <plug>Oiqamotion :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '<', '>', ',', v:true)<cr>
vnoremap <silent> <plug>Viqamotion :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '<', '>', ',', v:true)<cr>
onoremap <silent> <plug>OiQamotion :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '<', '>', ';', v:true)<cr>
vnoremap <silent> <plug>ViQamotion :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '<', '>', ';', v:true)<cr>

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
" }}}1

" qd Motion {{{1
" make direction and greedy, instead of reach and greedy, that's too much
omap qd <plug>Oqdmotion
vmap qd <plug>Vqdmotion
omap qD <plug>OqDmotion
vmap qD <plug>VqDmotion

omap Qd <plug>OQdmotion
vmap Qd <plug>VQdmotion
omap QD <plug>OQDmotion
vmap QD <plug>VQDmotion

omap qw <plug>Oqwmotion
vmap qw <plug>Vqwmotion
omap qW <plug>OqWmotion
vmap qW <plug>VqWmotion

omap Qw <plug>OQwmotion
vmap Qw <plug>VQwmotion
omap QW <plug>OQWmotion
vmap QW <plug>VQWmotion

omap qn <plug>Oqnmotion
vmap qn <plug>Vqnmotion
omap qN <plug>OqNmotion
vmap qN <plug>VqNmotion

omap Qn <plug>OQnmotion
vmap Qn <plug>VQnmotion
omap QN <plug>OQNmotion
vmap QN <plug>VQNmotion

if !exists("g:sick_qd_motion_char")
  let g:sick_qd_motion_char = '\.'
endif

if !exists("g:sick_qw_motion_char")
  let g:sick_qw_motion_char = '->'
endif

if !exists("g:sick_qn_motion_char")
  let g:sick_qn_motion_char = ':'
endif

onoremap <silent> <plug>Oqdmotion :<c-u>call
      \ <sid>sick_qd_motion(getpos('.'), g:sick_qd_motion_char, v:false, v:false)<cr>
vnoremap <silent> <plug>Vqdmotion :<c-u>call
      \ <sid>sick_qd_motion(getpos('.'), g:sick_qd_motion_char, v:false, v:false)<cr>
onoremap <silent> <plug>OqDmotion :<c-u>call
      \ <sid>sick_qd_motion(getpos('.'), g:sick_qd_motion_char, v:false, v:true)<cr>
vnoremap <silent> <plug>VqDmotion :<c-u>call
      \ <sid>sick_qd_motion(getpos('.'), g:sick_qd_motion_char, v:false, v:true)<cr>
onoremap <silent> <plug>OQdmotion :<c-u>call
      \ <sid>sick_qd_motion(getpos('.'), g:sick_qd_motion_char, v:true, v:false)<cr>
vnoremap <silent> <plug>VQdmotion :<c-u>call
      \ <sid>sick_qd_motion(getpos('.'), g:sick_qd_motion_char, v:true, v:false)<cr>
onoremap <silent> <plug>OQDmotion :<c-u>call
      \ <sid>sick_qd_motion(getpos('.'), g:sick_qd_motion_char, v:true, v:true)<cr>
vnoremap <silent> <plug>VQDmotion :<c-u>call
      \ <sid>sick_qd_motion(getpos('.'), g:sick_qd_motion_char, v:true, v:true)<cr>

onoremap <silent> <plug>Oqwmotion :<c-u>call
      \ <sid>sick_qd_motion(getpos('.'), g:sick_qw_motion_char, v:false, v:false)<cr>
vnoremap <silent> <plug>Vqwmotion :<c-u>call
      \ <sid>sick_qd_motion(getpos('.'), g:sick_qw_motion_char, v:false, v:false)<cr>
onoremap <silent> <plug>OqWmotion :<c-u>call
      \ <sid>sick_qd_motion(getpos('.'), g:sick_qw_motion_char, v:false, v:true)<cr>
vnoremap <silent> <plug>VqWmotion :<c-u>call
      \ <sid>sick_qd_motion(getpos('.'), g:sick_qw_motion_char, v:false, v:true)<cr>
onoremap <silent> <plug>OQwmotion :<c-u>call
      \ <sid>sick_qd_motion(getpos('.'), g:sick_qw_motion_char, v:true, v:false)<cr>
vnoremap <silent> <plug>VQwmotion :<c-u>call
      \ <sid>sick_qd_motion(getpos('.'), g:sick_qw_motion_char, v:true, v:false)<cr>
onoremap <silent> <plug>OQWmotion :<c-u>call
      \ <sid>sick_qd_motion(getpos('.'), g:sick_qw_motion_char, v:true, v:true)<cr>
vnoremap <silent> <plug>VQWmotion :<c-u>call
      \ <sid>sick_qd_motion(getpos('.'), g:sick_qw_motion_char, v:true, v:true)<cr>

onoremap <silent> <plug>Oqnmotion :<c-u>call
      \ <sid>sick_qd_motion(getpos('.'), g:sick_qn_motion_char, v:false, v:false)<cr>
vnoremap <silent> <plug>Vqnmotion :<c-u>call
      \ <sid>sick_qd_motion(getpos('.'), g:sick_qn_motion_char, v:false, v:false)<cr>
onoremap <silent> <plug>OqNmotion :<c-u>call
      \ <sid>sick_qd_motion(getpos('.'), g:sick_qn_motion_char, v:false, v:true)<cr>
vnoremap <silent> <plug>VqNmotion :<c-u>call
      \ <sid>sick_qd_motion(getpos('.'), g:sick_qn_motion_char, v:false, v:true)<cr>
onoremap <silent> <plug>OQnmotion :<c-u>call
      \ <sid>sick_qd_motion(getpos('.'), g:sick_qn_motion_char, v:true, v:false)<cr>
vnoremap <silent> <plug>VQnmotion :<c-u>call
      \ <sid>sick_qd_motion(getpos('.'), g:sick_qn_motion_char, v:true, v:false)<cr>
onoremap <silent> <plug>OQNmotion :<c-u>call
      \ <sid>sick_qd_motion(getpos('.'), g:sick_qn_motion_char, v:true, v:true)<cr>
vnoremap <silent> <plug>VQNmotion :<c-u>call
      \ <sid>sick_qd_motion(getpos('.'), g:sick_qn_motion_char, v:true, v:true)<cr>

function! s:sick_qd_motion(cur_pos, char, reach, greedy)
  let l:invalid        = v:false
  let l:finished       = v:false
  let l:left_finished  = v:false
  let l:right_finished = v:false
  let l:start_pos      = getpos('.')

  call search(a:char, 'c', line('.'))

  " Invalid if no a:char is found
  if getline('.')[col('.') - 1] !~ a:char
    let l:invalid = v:true
  endif

  " Work through conditions that can occur on the left side
  while !l:left_finished && !l:invalid
    normal! h
    let l:cur_char = getline('.')[col('.') - 1]

    if l:cur_char =~ "[\])}>]"
      normal %

    elseif l:cur_char =~ "'"
      normal F'
      let l:left_finished = v:true
    elseif l:cur_char =~ '"'
      normal F"
      let l:left_finished = v:true
    elseif l:cur_char =~ "`"
      normal F`
      let l:left_finished = v:true

    elseif l:cur_char =~ "[a-zA-Z_0-9]"
      if a:reach
        normal! B
      else
        normal! b
      endif
      let l:char_found = v:true

    else
      let l:invalid = v:true
    endif
  endwhile

  " Start selection and go back to origin
  normal! lv
  call setpos('.', l:start_pos)

  " Right part
  if a:greedy
    while !l:right_finished && !l:invalid
      normal! l
      let l:cur_char = getline('.')[col('.') - 1]

      if l:cur_char =~ "[\[({<]"
        normal %
      elseif l:cur_char =~ "[a-zA-Z_0-9]"
        normal! e
      else
        normal! 1 
        let l:right_finished = v:true
      endif

    endwhile
  else
    normal! le
  endif
endfunction

" (each of them should be settable)
" foo(abc).def.ghi   d
" abc->def->ghi w
" abc:def:ghi   n

" (each of them should be settable)
" data hello_world :: [String]  h
" var foo = "Hello world!"      e
" key": "value"                 c

" }}}1

" qe Motion {{{1
omap qe <plug>Oqemotion
vmap qe <plug>Vqemotion
omap Qe <plug>OQemotion
vmap Qe <plug>VQemotion

omap qc <plug>Oqcmotion
vmap qc <plug>Vqcmotion
omap Qc <plug>OQcmotion
vmap Qc <plug>VQcmotion

omap qh <plug>Oqhmotion
vmap qh <plug>Vqhmotion
omap Qh <plug>OQhmotion
vmap Qh <plug>VQhmotion

if !exists("g:sick_qe_motion_char")
  let g:sick_qe_motion_char = '\S*=\S*'
endif

if !exists("g:sick_qc_motion_char")
  let g:sick_qc_motion_char = ':'
endif

if !exists("g:sick_qh_motion_char")
  let g:sick_qh_motion_char = '::'
endif

onoremap <silent> <plug>Oqemotion :<c-u>call
      \ <sid>sick_qe_motion(getpos('.'), g:sick_qe_motion_char, v:false)<cr>
vnoremap <silent> <plug>Vqemotion :<c-u>call
      \ <sid>sick_qe_motion(getpos('.'), g:sick_qe_motion_char, v:false)<cr>
onoremap <silent> <plug>OQemotion :<c-u>call
      \ <sid>sick_qe_motion(getpos('.'), g:sick_qe_motion_char, v:true)<cr>
vnoremap <silent> <plug>VQemotion :<c-u>call
      \ <sid>sick_qe_motion(getpos('.'), g:sick_qe_motion_char, v:true)<cr>

onoremap <silent> <plug>Oqcmotion :<c-u>call
      \ <sid>sick_qe_motion(getpos('.'), g:sick_qc_motion_char, v:false)<cr>
vnoremap <silent> <plug>Vqcmotion :<c-u>call
      \ <sid>sick_qe_motion(getpos('.'), g:sick_qc_motion_char, v:false)<cr>
onoremap <silent> <plug>OQcmotion :<c-u>call
      \ <sid>sick_qe_motion(getpos('.'), g:sick_qc_motion_char, v:true)<cr>
vnoremap <silent> <plug>VQcmotion :<c-u>call
      \ <sid>sick_qe_motion(getpos('.'), g:sick_qc_motion_char, v:true)<cr>

onoremap <silent> <plug>Oqhmotion :<c-u>call
      \ <sid>sick_qe_motion(getpos('.'), g:sick_qh_motion_char, v:false)<cr>
vnoremap <silent> <plug>Vqhmotion :<c-u>call
      \ <sid>sick_qe_motion(getpos('.'), g:sick_qh_motion_char, v:false)<cr>
onoremap <silent> <plug>OQhmotion :<c-u>call
      \ <sid>sick_qe_motion(getpos('.'), g:sick_qh_motion_char, v:true)<cr>
vnoremap <silent> <plug>VQhmotion :<c-u>call
      \ <sid>sick_qe_motion(getpos('.'), g:sick_qh_motion_char, v:true)<cr>

function! s:sick_qe_motion(cur_pos, char, front)
  let l:invalid = v:false
  let l:cur_col = line('.')
  normal! 0

  " find char
  if search(a:char) != l:cur_col
    let l:invalid = v:true
  endif

  if !l:invalid
    " select chars in front or after chars,
    " depending on argument
    if a:front
      call search('\S', 'b')
      normal! v^
    else
      call search(a:char, 'ce')
      call search('\S')
      normal! v$
    endif

  else
    call setpos(a:cur_pos)
  endif
endfunction
" }}}

" iz motion {{{1
omap iz <plug>Oizmotion
vmap iz <plug>Vizmotion
omap az <plug>Oazmotion
vmap az <plug>Vazmotion

omap iZ <plug>OiZmotion
vmap iZ <plug>ViZmotion
omap aZ <plug>OaZmotion
vmap aZ <plug>VaZmotion

onoremap <silent> <plug>Oizmotion :<c-u>call
      \ <sid>sick_iz_motion(indent(line('.')), v:false)<cr>
onoremap <silent> <plug>Oazmotion :<c-u>call
      \ <sid>sick_iz_motion(indent(line('.')), v:true)<cr>
vnoremap <silent> <plug>Vizmotion :<c-u>call
      \ <sid>sick_iz_motion(indent(line('.')), v:false)<cr>
vnoremap <silent> <plug>Vazmotion :<c-u>call
      \ <sid>sick_iz_motion(indent(line('.')), v:true)<cr>

onoremap <silent> <plug>OiZmotion :<c-u>call
      \ <sid>sick_iz_motion_with_reach(indent(line('.')), v:false)<cr>
onoremap <silent> <plug>OaZmotion :<c-u>call
      \ <sid>sick_iz_motion_with_reach(indent(line('.')), v:true)<cr>
vnoremap <silent> <plug>ViZmotion :<c-u>call
      \ <sid>sick_iz_motion_with_reach(indent(line('.')), v:false)<cr>
vnoremap <silent> <plug>VaZmotion :<c-u>call
      \ <sid>sick_iz_motion_with_reach(indent(line('.')), v:true)<cr>

function s:sick_iz_motion(cur_indent, margin)
  if getline(line('.')) == ''
    echomsg 'This action is not allowed on an empty line'
    return -1
  endif

  while a:cur_indent <= indent(line('.') - 1) && getline(line('.') - 1) != ''
    normal! k
  endwhile

  if a:margin && getline(line('.') - 1) != ''
    normal! kVj
  else
    normal! V
  endif

  while a:cur_indent <= indent(line('.') + 1) && getline(line('.') + 1) != ''
    normal! j
  endwhile

  if a:margin && getline(line('.') + 1) != ''
    normal! j
  endif
endfunction

function s:sick_iz_motion_with_reach(cur_indent, margin)
  if indent(line('.')) == 0
    echomsg 'This action is not allowed on a line with zero indent'
    return -1
  endif

  while a:cur_indent <= indent(line('.') - 1) || getline(line('.') - 1) == ''
    normal! k
  endwhile

  if a:margin
    normal! kVj
  else
    normal! V
  endif

  while a:cur_indent <= indent(line('.') + 1) || getline(line('.') + 1) == ''
    normal! j
  endwhile

  if a:margin
    normal! j
  endif
endfunction
" }}}
