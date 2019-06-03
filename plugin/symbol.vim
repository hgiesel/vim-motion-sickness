" Symbols
"
" `i_`, `a_` and family, which are a lot of motions that work like `ab` or
" `aB` but with symbols
""""

if exists('g:loaded_motion_sickness_symbol') || &compatible || v:version < 700
  finish
endif
let g:loaded_motion_sickness_symbol = 1

" Setting user mappings {{{1
omap i* <plug>(OIAsteriskSmotion)
vmap i* <plug>(VIAsteriskSmotion)
omap a* <plug>(OAAsteriskSmotion)
vmap a* <plug>(VAAsteriskSmotion)

omap i_ <plug>(OIUnderscoreSmotion)
vmap i_ <plug>(VIUnderscoreSmotion)
omap a_ <plug>(OAUnderscoreSmotion)
vmap a_ <plug>(VAUnderscoreSmotion)

omap i- <plug>(OIDashSmotion)
vmap i- <plug>(VIDashSmotion)
omap a- <plug>(OADashSmotion)
vmap a- <plug>(VADashSmotion)

omap i: <plug>(OIColonSmotion)
vmap i: <plug>(VIColonSmotion)
omap a: <plug>(OAColonSmotion)
vmap a: <plug>(VAColonSmotion)

omap i@ <plug>(OIAtSmotion)
vmap i@ <plug>(VIAtSmotion)
omap a@ <plug>(OAAtSmotion)
vmap a@ <plug>(VAAtSmotion)

omap i! <plug>(OIBangSmotion)
vmap i! <plug>(VIBangSmotion)
omap a! <plug>(OABangSmotion)
vmap a! <plug>(VABangSmotion)

omap i? <plug>(OIQuestionSmotion)
vmap i? <plug>(VIQuestionSmotion)
omap a? <plug>(OAQuestionSmotion)
vmap a? <plug>(VAQuestionSmotion)

omap i/ <plug>(OISlashSmotion)
vmap i/ <plug>(VISlashSmotion)
omap a/ <plug>(OASlashSmotion)
vmap a/ <plug>(VASlashSmotion)

omap i% <plug>(OIPercentSmotion)
vmap i% <plug>(VIPercentSmotion)
omap a% <plug>(OAPercentSmotion)
vmap a% <plug>(VAPercentSmotion)

omap i<bar> <plug>(OIPipeSmotion)
vmap i<bar> <plug>(VIPipeSmotion)
omap a<bar> <plug>(OAPipeSmotion)
vmap a<bar> <plug>(VAPipeSmotion)

" Setting plug mappings {{{1
onoremap <silent>
      \ <plug>(OIAsteriskSmotion)
      \ :<c-u>call <sid>sick_symbol_motion(v:false, '*', 'o')<cr>
vnoremap <silent>
      \ <plug>(VIAsteriskSmotion)
      \ :<c-u>call <sid>sick_symbol_motion(v:false, '*', 'v')<cr>

onoremap <silent>
      \ <plug>(OAAsteriskSmotion)
      \ :<c-u>call <sid>sick_symbol_motion(v:true, '*', 'o')<cr>

vnoremap <silent>
      \ <plug>(VAAsteriskSmotion)
      \ :<c-u>call <sid>sick_symbol_motion(v:true, '*', 'v')<cr>

onoremap <silent>
      \ <plug>(OIUnderscoreSmotion)
      \ :<c-u>call <sid>sick_symbol_motion(v:false, '_', 'o')<cr>
vnoremap <silent>
      \ <plug>(VIUnderscoreSmotion)
      \ :<c-u>call <sid>sick_symbol_motion(v:false, '_', 'v')<cr>
onoremap <silent>
      \ <plug>(OAUnderscoreSmotion)
      \ :<c-u>call <sid>sick_symbol_motion(v:true, '_', 'o')<cr>
vnoremap <silent>
      \ <plug>(VAUnderscoreSmotion)
      \ :<c-u>call <sid>sick_symbol_motion(v:true, '_', 'v')<cr>

onoremap <silent>
      \ <plug>(OIDashSmotion)
      \ :<c-u>call <sid>sick_symbol_motion(v:false, '-', 'o')<cr>
vnoremap <silent>
      \ <plug>(VIDashSmotion)
      \ :<c-u>call <sid>sick_symbol_motion(v:false, '-', 'v')<cr>
onoremap <silent>
      \ <plug>(OADashSmotion)
      \ :<c-u>call <sid>sick_symbol_motion(v:true, '-', 'o')<cr>
vnoremap <silent>
      \ <plug>(VADashSmotion)
      \ :<c-u>call <sid>sick_symbol_motion(v:true, '-', 'v')<cr>

onoremap <silent>
      \ <plug>(OIColonSmotion)
      \ :<c-u>call <sid>sick_symbol_motion(v:false, ':', 'o')<cr>
vnoremap <silent>
      \ <plug>(VIColonSmotion)
      \ :<c-u>call <sid>sick_symbol_motion(v:false, ':', 'v')<cr>
onoremap <silent>
      \ <plug>(OAColonSmotion)
      \ :<c-u>call <sid>sick_symbol_motion(v:true, ':', 'o')<cr>
vnoremap <silent>
      \ <plug>(VAColonSmotion)
      \ :<c-u>call <sid>sick_symbol_motion(v:true, ':', 'v')<cr>

onoremap <silent>
      \ <plug>(OIAtSmotion)
      \ :<c-u>call <sid>sick_symbol_motion(v:false, '@', 'o')<cr>
vnoremap <silent>
      \ <plug>(VIAtSmotion)
      \ :<c-u>call <sid>sick_symbol_motion(v:false, '@', 'v')<cr>
onoremap <silent>
      \ <plug>(OAAtSmotion)
      \ :<c-u>call <sid>sick_symbol_motion(v:true, '@', 'o')<cr>
vnoremap <silent>
      \ <plug>(VAAtSmotion)
      \ :<c-u>call <sid>sick_symbol_motion(v:true, '@', 'v')<cr>

onoremap <silent>
      \ <plug>(OIBangSmotion)
      \ :<c-u>call <sid>sick_symbol_motion(v:false, '!', 'o')<cr>
vnoremap <silent>
      \ <plug>(VIBangSmotion)
      \ :<c-u>call <sid>sick_symbol_motion(v:false, '!', 'v')<cr>
onoremap <silent>
      \ <plug>(OABangSmotion)
      \ :<c-u>call <sid>sick_symbol_motion(v:true, '!', 'o')<cr>
vnoremap <silent>
      \ <plug>(VABangSmotion)
      \ :<c-u>call <sid>sick_symbol_motion(v:true, '!', 'v')<cr>

onoremap <silent>
      \ <plug>(OIQuestionSmotion)
      \ :<c-u>call <sid>sick_symbol_motion(v:false, '?', 'o')<cr>
vnoremap <silent>
      \ <plug>(VIQuestionSmotion)
      \ :<c-u>call <sid>sick_symbol_motion(v:false, '?', 'v')<cr>
onoremap <silent>
      \ <plug>(OAQuestionSmotion)
      \ :<c-u>call <sid>sick_symbol_motion(v:true, '?', 'o')<cr>
vnoremap <silent>
      \ <plug>(VAQuestionSmotion)
      \ :<c-u>call <sid>sick_symbol_motion(v:true, '?', 'v')<cr>

onoremap <silent>
      \ <plug>(OISlashSmotion)
      \ :<c-u>call <sid>sick_symbol_motion(v:false, '/', 'o')<cr>
vnoremap <silent>
      \ <plug>(VISlashSmotion)
      \ :<c-u>call <sid>sick_symbol_motion(v:false, '/', 'v')<cr>
onoremap <silent>
      \ <plug>(OASlashSmotion)
      \ :<c-u>call <sid>sick_symbol_motion(v:true, '/', 'o')<cr>
vnoremap <silent>
      \ <plug>(VASlashSmotion)
      \ :<c-u>call <sid>sick_symbol_motion(v:true, '/', 'v')<cr>

onoremap <silent>
      \ <plug>(OIPercentSmotion)
      \ :<c-u>call <sid>sick_symbol_motion(v:false, '%', 'o')<cr>
vnoremap <silent>
      \ <plug>(VIPercentSmotion)
      \ :<c-u>call <sid>sick_symbol_motion(v:false, '%', 'v')<cr>
onoremap <silent>
      \ <plug>(OAPercentSmotion)
      \ :<c-u>call <sid>sick_symbol_motion(v:true, '%', 'o')<cr>
vnoremap <silent>
      \ <plug>(VAPercentSmotion)
      \ :<c-u>call <sid>sick_symbol_motion(v:true, '%', 'v')<cr>

onoremap <silent>
      \ <plug>(OIPipeSmotion)
      \ :<c-u>call <sid>sick_symbol_motion(v:false, '<bar>', 'o')<cr>
vnoremap <silent>
      \ <plug>(VIPipeSmotion)
      \ :<c-u>call <sid>sick_symbol_motion(v:false, '<bar>', 'v')<cr>
onoremap <silent>
      \ <plug>(OAPipeSmotion)
      \ :<c-u>call <sid>sick_symbol_motion(v:true, '<bar>', 'o')<cr>
vnoremap <silent>
      \ <plug>(VAPipeSmotion)
      \ :<c-u>call <sid>sick_symbol_motion(v:true, '<bar>', 'v')<cr>

" Defining functinos {{{1
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