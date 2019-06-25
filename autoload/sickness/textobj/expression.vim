" Defining functions {{{1
function! sickness#textobj#expression#motion(opendelim, closedelim, reach) abort
  let l:curpos  = getpos('.')
  let l:winsave = winsaveview()

  let l:count = v:count

  normal! 

  if getline('.')[col('.') - 1] !=# a:opendelim
        \ && getline('.')[col('.') - 1] !=# a:closedelim
    execute 'normal! f'.a:opendelim
  endif

  execute 'normal! va'.a:opendelim
  let l:closedelim_pos = getpos('.')
  execute 'normal! o'
  let l:opendelim_pos = getpos('.')

  if l:opendelim_pos[2] ==# 1 || l:opendelim_pos ==# l:closedelim_pos
    " No expression starts on the first col OR No match is found by a<delim>
    normal! 
    call setpos('.', l:curpos)
    call winrestview(l:winsave)
    return
  endif

  if len(getline(l:closedelim_pos[1])) !=# l:closedelim_pos[2]
    let l:onecharbefore = getline(l:opendelim_pos[1])[l:opendelim_pos[2] - 2]
    let l:onecharafter  = getline(l:closedelim_pos[1])[l:closedelim_pos[2]]

    if l:onecharbefore ==# a:opendelim && l:onecharafter ==# a:closedelim
      execute "normal! \<bs>o o"
    endif
  endif

  if l:count ==# 0 && a:reach ==# 'b'
    let l:count = 1
    execute 'normal! '.l:count.a:reach
  elseif l:count ==# 0 && a:reach ==# 'B'
    execute 'normal! ^'
  else
    execute 'normal! '.l:count.a:reach
  endif

  " skip while you have non contained delim characters
  while !s:MatchOpenCloseDelims(s:GetInnerText(getpos('.'), l:opendelim_pos))
    normal! 1 
  endwhile

  " skip while you have blank characters
  while index([' ', '	'], getline('.')[col('.') - 1]) !=# -1
    normal! 1 
  endwhile

  let l:beginpos = getpos('.')
  if !s:PosLiesWithin(l:beginpos, l:closedelim_pos, l:curpos)
    normal! 
    call setpos('.', l:curpos)
    call winrestview(l:winsave)
    return
  endif

  normal! o
endfunction

function! s:PosLiesWithin(beginpos, endpos, middlepos) abort
  if a:beginpos[1] > a:middlepos[1] || a:middlepos[1] > a:endpos[1]
    return v:false
  elseif a:beginpos[1] == a:middlepos[1] && a:beginpos[2] > a:middlepos[2]
    return v:false
  elseif a:middlepos[1] == a:endpos[1] && a:middlepos[2] > a:endpos[2]
    return v:false
  endif

  return v:true
endfunction

function! s:MatchOpenCloseDelims(innertext) abort
  " substitute ' < ' and ' > ' from text because I assume
  " them to be comparison operators
  let l:innertext_joined = substitute(join(a:innertext), '\(\s\)[<>]\(\s\)', '\1\2', 'g')

  for l:openclosedelim in g:sickness#expression#openclosedelims
    if count(l:innertext_joined, l:openclosedelim[2]) !=# count(l:innertext_joined, l:openclosedelim[3])
      return v:false
    endif
  endfor

  return v:true
endfunction

function! s:GetInnerText(opendelim_pos, closedelim_pos) abort
  " works different from sickness#textobj#field because
  " it includes the very first character of the selection
  let l:result = []

  if a:closedelim_pos[1] < a:opendelim_pos[1]
    return l:result
  endif

  for i in range(a:opendelim_pos[1], a:closedelim_pos[1])
    if (i ==# a:opendelim_pos[1] && i ==# a:closedelim_pos[1]) " single line
      let l:theline = strcharpart(getline(i), a:opendelim_pos[2] - 1, a:closedelim_pos[2] - a:opendelim_pos[2])

    elseif (i ==# a:opendelim_pos[1]) " firstline
      let l:theline = strcharpart(getline(i), a:opendelim_pos[2] - 1)

    elseif (i ==# a:closedelim_pos[1]) " lastline
      let l:theline = strcharpart(getline(i), 0, a:closedelim_pos[2] - 1)

    else " middleline
      let l:theline = getline(i)
    endif

    call add(l:result, l:theline)
  endfor

  return l:result
endfunction
