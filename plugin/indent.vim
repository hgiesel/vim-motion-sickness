" 7. indentation motion
" ii: select current indentation delimited by lines with one indentation less or
" empty lines
" ai: select current indentation delimited by lines with one indentation less
" (which are included) or empty lines
" iI: select current indentation delimited by lines with one indentation less
" (note that this would select the whole file on an empty line)
" aI: select current indentation delimited by lines with one indentation less
" (which are included) (note that this on an indentation of zero would select
" the whole file)

if exists('g:loaded_motion_sickness_indent') || &compatible || v:version < 700
  finish
endif
let g:loaded_motion_sickness_indent = 1

" Setting user mappings {{{1
omap ii <plug>(Oiimotion)
vmap ii <plug>(Viimotion)
omap ai <plug>(Oaimotion)
vmap ai <plug>(Vaimotion)

omap iI <plug>(OiImotion)
vmap iI <plug>(ViImotion)
omap aI <plug>(OaImotion)
vmap aI <plug>(VaImotion)

" Setting plug mappings {{{1
onoremap <silent>
      \ <plug>(Oiimotion) :<c-u>call
      \ <sid>sick_iz_motion(indent(line('.')), v:false)<cr>
onoremap <silent>
      \ <plug>(Oaimotion) :<c-u>call
      \ <sid>sick_iz_motion(indent(line('.')), v:true)<cr>
vnoremap <silent>
      \ <plug>(Viimotion) :<c-u>call
      \ <sid>sick_iz_motion(indent(line('.')), v:false)<cr>
vnoremap <silent>
      \ <plug>(Vaimotion) :<c-u>call
      \ <sid>sick_iz_motion(indent(line('.')), v:true)<cr>

onoremap <silent>
      \ <plug>(OiImotion) :<c-u>call
      \ <sid>sick_iz_motion_with_reach(indent(line('.')), v:false)<cr>
onoremap <silent>
      \ <plug>(OaImotion) :<c-u>call
      \ <sid>sick_iz_motion_with_reach(indent(line('.')), v:true)<cr>
vnoremap <silent>
      \ <plug>(ViImotion) :<c-u>call
      \ <sid>sick_iz_motion_with_reach(indent(line('.')), v:false)<cr>
vnoremap <silent>
      \ <plug>(VaImotion) :<c-u>call
      \ <sid>sick_iz_motion_with_reach(indent(line('.')), v:true)<cr>

" Defining functions {{{1
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
