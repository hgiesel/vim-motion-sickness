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
      \ :<c-u>call symbol#sick_symbol_motion(v:false, '*', 'o')<cr>
vnoremap <silent>
      \ <plug>(VIAsteriskSmotion)
      \ :<c-u>call symbol#sick_symbol_motion(v:false, '*', 'v')<cr>

onoremap <silent>
      \ <plug>(OAAsteriskSmotion)
      \ :<c-u>call symbol#sick_symbol_motion(v:true, '*', 'o')<cr>
vnoremap <silent>
      \ <plug>(VAAsteriskSmotion)
      \ :<c-u>call symbol#sick_symbol_motion(v:true, '*', 'v')<cr>

onoremap <silent>
      \ <plug>(OIUnderscoreSmotion)
      \ :<c-u>call symbol#sick_symbol_motion(v:false, '_', 'o')<cr>
vnoremap <silent>
      \ <plug>(VIUnderscoreSmotion)
      \ :<c-u>call symbol#sick_symbol_motion(v:false, '_', 'v')<cr>
onoremap <silent>
      \ <plug>(OAUnderscoreSmotion)
      \ :<c-u>call symbol#sick_symbol_motion(v:true, '_', 'o')<cr>
vnoremap <silent>
      \ <plug>(VAUnderscoreSmotion)
      \ :<c-u>call symbol#sick_symbol_motion(v:true, '_', 'v')<cr>

onoremap <silent>
      \ <plug>(OIDashSmotion)
      \ :<c-u>call symbol#sick_symbol_motion(v:false, '-', 'o')<cr>
vnoremap <silent>
      \ <plug>(VIDashSmotion)
      \ :<c-u>call symbol#sick_symbol_motion(v:false, '-', 'v')<cr>
onoremap <silent>
      \ <plug>(OADashSmotion)
      \ :<c-u>call symbol#sick_symbol_motion(v:true, '-', 'o')<cr>
vnoremap <silent>
      \ <plug>(VADashSmotion)
      \ :<c-u>call symbol#sick_symbol_motion(v:true, '-', 'v')<cr>

onoremap <silent>
      \ <plug>(OIColonSmotion)
      \ :<c-u>call symbol#sick_symbol_motion(v:false, ':', 'o')<cr>
vnoremap <silent>
      \ <plug>(VIColonSmotion)
      \ :<c-u>call symbol#sick_symbol_motion(v:false, ':', 'v')<cr>
onoremap <silent>
      \ <plug>(OAColonSmotion)
      \ :<c-u>call symbol#sick_symbol_motion(v:true, ':', 'o')<cr>
vnoremap <silent>
      \ <plug>(VAColonSmotion)
      \ :<c-u>call symbol#sick_symbol_motion(v:true, ':', 'v')<cr>

onoremap <silent>
      \ <plug>(OIAtSmotion)
      \ :<c-u>call symbol#sick_symbol_motion(v:false, '@', 'o')<cr>
vnoremap <silent>
      \ <plug>(VIAtSmotion)
      \ :<c-u>call symbol#sick_symbol_motion(v:false, '@', 'v')<cr>
onoremap <silent>
      \ <plug>(OAAtSmotion)
      \ :<c-u>call symbol#sick_symbol_motion(v:true, '@', 'o')<cr>
vnoremap <silent>
      \ <plug>(VAAtSmotion)
      \ :<c-u>call symbol#sick_symbol_motion(v:true, '@', 'v')<cr>

onoremap <silent>
      \ <plug>(OIBangSmotion)
      \ :<c-u>call symbol#sick_symbol_motion(v:false, '!', 'o')<cr>
vnoremap <silent>
      \ <plug>(VIBangSmotion)
      \ :<c-u>call symbol#sick_symbol_motion(v:false, '!', 'v')<cr>
onoremap <silent>
      \ <plug>(OABangSmotion)
      \ :<c-u>call symbol#sick_symbol_motion(v:true, '!', 'o')<cr>
vnoremap <silent>
      \ <plug>(VABangSmotion)
      \ :<c-u>call symbol#sick_symbol_motion(v:true, '!', 'v')<cr>

onoremap <silent>
      \ <plug>(OIQuestionSmotion)
      \ :<c-u>call symbol#sick_symbol_motion(v:false, '?', 'o')<cr>
vnoremap <silent>
      \ <plug>(VIQuestionSmotion)
      \ :<c-u>call symbol#sick_symbol_motion(v:false, '?', 'v')<cr>
onoremap <silent>
      \ <plug>(OAQuestionSmotion)
      \ :<c-u>call symbol#sick_symbol_motion(v:true, '?', 'o')<cr>
vnoremap <silent>
      \ <plug>(VAQuestionSmotion)
      \ :<c-u>call symbol#sick_symbol_motion(v:true, '?', 'v')<cr>

onoremap <silent>
      \ <plug>(OISlashSmotion)
      \ :<c-u>call symbol#sick_symbol_motion(v:false, '/', 'o')<cr>
vnoremap <silent>
      \ <plug>(VISlashSmotion)
      \ :<c-u>call symbol#sick_symbol_motion(v:false, '/', 'v')<cr>
onoremap <silent>
      \ <plug>(OASlashSmotion)
      \ :<c-u>call symbol#sick_symbol_motion(v:true, '/', 'o')<cr>
vnoremap <silent>
      \ <plug>(VASlashSmotion)
      \ :<c-u>call symbol#sick_symbol_motion(v:true, '/', 'v')<cr>

onoremap <silent>
      \ <plug>(OIPercentSmotion)
      \ :<c-u>call symbol#sick_symbol_motion(v:false, '%', 'o')<cr>
vnoremap <silent>
      \ <plug>(VIPercentSmotion)
      \ :<c-u>call symbol#sick_symbol_motion(v:false, '%', 'v')<cr>
onoremap <silent>
      \ <plug>(OAPercentSmotion)
      \ :<c-u>call symbol#sick_symbol_motion(v:true, '%', 'o')<cr>
vnoremap <silent>
      \ <plug>(VAPercentSmotion)
      \ :<c-u>call symbol#sick_symbol_motion(v:true, '%', 'v')<cr>

onoremap <silent>
      \ <plug>(OIPipeSmotion)
      \ :<c-u>call symbol#sick_symbol_motion(v:false, '<bar>', 'o')<cr>
vnoremap <silent>
      \ <plug>(VIPipeSmotion)
      \ :<c-u>call symbol#sick_symbol_motion(v:false, '<bar>', 'v')<cr>
onoremap <silent>
      \ <plug>(OAPipeSmotion)
      \ :<c-u>call symbol#sick_symbol_motion(v:true, '<bar>', 'o')<cr>
vnoremap <silent>
      \ <plug>(VAPipeSmotion)
      \ :<c-u>call symbol#sick_symbol_motion(v:true, '<bar>', 'v')<cr>
