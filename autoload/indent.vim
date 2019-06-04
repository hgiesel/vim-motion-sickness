" Defining functions {{{1
function indent#sick_iz_motion(cur_indent, margin)
  if getline(line('.')) == ''
    echomsg 'This action is not allowed on an empty line'
    return ''
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

  return ''
endfunction

function indent#sick_iz_motion_with_reach(cur_indent, margin)
  if indent(line('.')) == 0
    echomsg 'This action is not allowed on a line with zero indent'
    return ''
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

  return ''
endfunction
