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
      \ <plug>(OiqBmotion) :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '{', '}', ',', v:true)<cr>
vnoremap <silent>
      \ <plug>(ViqBmotion) :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '{', '}', ',', v:true)<cr>
onoremap <silent>
      \ <plug>(OiQBmotion) :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '{', '}', ';', v:true)<cr>
vnoremap <silent>
      \ <plug>(ViQBmotion) :<c-u>call
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
      \ <plug>(Oiqrmotion) :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '[', ']', ',', v:true)<cr>
vnoremap <silent>
      \ <plug>(Viqrmotion) :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '[', ']', ',', v:true)<cr>
onoremap <silent>
      \ <plug>(OiQrmotion) :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '[', ']', ';', v:true)<cr>
vnoremap <silent>
      \ <plug>(ViQrmotion) :<c-u>call
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
      \ <plug>(Oiqamotion) :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '<', '>', ',', v:true)<cr>
vnoremap <silent>
      \ <plug>(Viqamotion) :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '<', '>', ',', v:true)<cr>
onoremap <silent>
      \ <plug>(OiQamotion) :<c-u>call
      \ <sid>sick_iqb_motion(getpos('.'), '<', '>', ';', v:true)<cr>
vnoremap <silent>
      \ <plug>(ViQamotion) :<c-u>call
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
