" Q-motions
" `qb` `qB` `qr` `qa` which are motions that select statements, e.g.
" foo(500 + 500))o)o
" while you would use `ib` to select everything within the parentheses and
" `ab` to select the whole parenthesis, you can use `qb` to use the whole
" parenthesis and the word before it. Also works with $(( )) or similiar
" things

if exists('g:loaded_motion_sickness_qmotion') || &compatible || v:version < 700
  finish
endif
let g:loaded_motion_sickness_qmotion = 1

" Setting user mappings {{{1
omap qb <plug>(Oqbmotion)
vmap qb <plug>(Vqbmotion)
omap Qb <plug>(OQbmotion)
vmap Qb <plug>(VQbmotion)

omap qB <plug>(OqBmotion)
vmap qB <plug>(VqBmotion)
omap QB <plug>(OQBmotion)
vmap QB <plug>(VQBmotion)

omap qr <plug>(Oqrmotion)
vmap qr <plug>(Vqrmotion)
omap Qr <plug>(OQrmotion)
vmap Qr <plug>(VQrmotion)

omap qa <plug>(Oqamotion)
vmap qa <plug>(Vqamotion)
omap Qa <plug>(OQamotion)
vmap Qa <plug>(VQamotion)

" Setting plug mappings {{{1
onoremap <silent>
      \ <plug>(Oqbmotion)
      \ :<c-u>call <sid>sick_qb_motion(getpos('.'), '(', ')', v:false)<cr>
vnoremap <silent>
      \ <plug>(Vqbmotion)
      \ :<c-u>call <sid>sick_qb_motion(getpos('.'), '(', ')', v:false)<cr>
onoremap <silent>
      \ <plug>(OQbmotion)
      \ :<c-u>call <sid>sick_qb_motion(getpos('.'), '(', ')', v:true)<cr>
vnoremap <silent>
      \ <plug>(VQbmotion)
      \ :<c-u>call <sid>sick_qb_motion(getpos('.'), '(', ')', v:true)<cr>

onoremap <silent>
      \ <plug>(OqBmotion)
      \ :<c-u>call <sid>sick_qb_motion(getpos('.'), '{', '}', v:false)<cr>
vnoremap <silent>
      \ <plug>(VqBmotion)
      \ :<c-u>call <sid>sick_qb_motion(getpos('.'), '{', '}', v:false)<cr>
onoremap <silent>
      \ <plug>(OQBmotion)
      \ :<c-u>call <sid>sick_qb_motion(getpos('.'), '{', '}', v:true)<cr>
vnoremap <silent>
      \ <plug>(VQBmotion)
      \ :<c-u>call <sid>sick_qb_motion(getpos('.'), '{', '}', v:true)<cr>

onoremap <silent>
      \ <plug>(Oqrmotion)
      \ :<c-u>call <sid>sick_qb_motion(getpos('.'), '[', ']', v:false)<cr>
vnoremap <silent>
      \ <plug>(Vqrmotion)
      \ :<c-u>call <sid>sick_qb_motion(getpos('.'), '[', ']', v:false)<cr>
onoremap <silent>
      \ <plug>(OQrmotion)
      \ :<c-u>call <sid>sick_qb_motion(getpos('.'), '[', ']', v:true)<cr>
vnoremap <silent>
      \ <plug>(VQrmotion)
      \ :<c-u>call <sid>sick_qb_motion(getpos('.'), '[', ']', v:true)<cr>

onoremap <silent>
      \ <plug>(Oqamotion)
      \ :<c-u>call <sid>sick_qb_motion(getpos('.'), '<', '>', v:false)<cr>
vnoremap <silent>
      \ <plug>(Vqamotion)
      \ :<c-u>call <sid>sick_qb_motion(getpos('.'), '<', '>', v:false)<cr>
onoremap <silent>
      \ <plug>(OQamotion)
      \ :<c-u>call <sid>sick_qb_motion(getpos('.'), '<', '>', v:true)<cr>
vnoremap <silent>
      \ <plug>(VQamotion)
      \ :<c-u>call <sid>sick_qb_motion(getpos('.'), '<', '>', v:true)<cr>

" Defining functions {{{1
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

" like C {{{2
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
