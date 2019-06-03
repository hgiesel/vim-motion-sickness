" Defining functions {{{1
function! segment#sick_qd_motion(cur_pos, char, reach, greedy)
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
