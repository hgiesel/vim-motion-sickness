" Segment motions (qd, qw, qn)
" make direction and greedy, instead of reach and greedy, that's too much
" a. `qd` `qD` `Qd` `QD` is used to select dot statements, e.g. test().arg[50]
" (default: `.`)
" q works how far it should go left
" d works how far it should go right

" Planned for the future are:
" b. `qn` to select namespace statements std::cout (default: `:`)
" c. `qw` select arrow statements (in C: ->) with `<` characters splattered over
" the place (default: `->`)

" (each of them should be settable)
" foo(abc).def.ghi   d
" abc->def->ghi w
" abc:def:ghi   n

if exists('g:loaded_motion_sickness_segment') || &compatible || v:version < 700
  finish
endif
let g:loaded_motion_sickness_segment = 1

" Setting delim chars {{{1
if !exists("g:sick_qd_motion_char")
  let g:sick_qd_motion_char = '\.'
endif

if !exists("g:sick_qw_motion_char")
  let g:sick_qw_motion_char = '->'
endif

if !exists("g:sick_qn_motion_char")
  let g:sick_qn_motion_char = ':'
endif

" Setting user mappings {{{1
omap qd <plug>(Oqdmotion)
vmap qd <plug>(Vqdmotion)
omap qD <plug>(OqDmotion)
vmap qD <plug>(VqDmotion)

omap Qd <plug>(OQdmotion)
vmap Qd <plug>(VQdmotion)
omap QD <plug>(OQDmotion)
vmap QD <plug>(VQDmotion)

omap qw <plug>(Oqwmotion)
vmap qw <plug>(Vqwmotion)
omap qW <plug>(OqWmotion)
vmap qW <plug>(VqWmotion)

omap Qw <plug>(OQwmotion)
vmap Qw <plug>(VQwmotion)
omap QW <plug>(OQWmotion)
vmap QW <plug>(VQWmotion)

omap qn <plug>(Oqnmotion)
vmap qn <plug>(Vqnmotion)
omap qN <plug>(OqNmotion)
vmap qN <plug>(VqNmotion)

omap Qn <plug>(OQnmotion)
vmap Qn <plug>(VQnmotion)
omap QN <plug>(OQNmotion)
vmap QN <plug>(VQNmotion)

" Setting plug mappings {{{1
onoremap <silent>
      \ <plug>(Oqdmotion) :<c-u>call
      \ segment#sick_qd_motion(getpos('.'), g:sick_qd_motion_char, v:false, v:false)<cr>
vnoremap <silent>
      \ <plug>(Vqdmotion) :<c-u>call
      \ segment#sick_qd_motion(getpos('.'), g:sick_qd_motion_char, v:false, v:false)<cr>
onoremap <silent>
      \ <plug>(OqDmotion) :<c-u>call
      \ segment#sick_qd_motion(getpos('.'), g:sick_qd_motion_char, v:false, v:true)<cr>
vnoremap <silent>
      \ <plug>(VqDmotion) :<c-u>call
      \ segment#sick_qd_motion(getpos('.'), g:sick_qd_motion_char, v:false, v:true)<cr>

onoremap <silent>
      \ <plug>(OQdmotion) :<c-u>call
      \ segment#sick_qd_motion(getpos('.'), g:sick_qd_motion_char, v:true, v:false)<cr>
vnoremap <silent>
      \ <plug>(VQdmotion) :<c-u>call
      \ segment#sick_qd_motion(getpos('.'), g:sick_qd_motion_char, v:true, v:false)<cr>
onoremap <silent>
      \ <plug>(OQDmotion) :<c-u>call
      \ segment#sick_qd_motion(getpos('.'), g:sick_qd_motion_char, v:true, v:true)<cr>
vnoremap <silent>
      \ <plug>(VQDmotion) :<c-u>call
      \ segment#sick_qd_motion(getpos('.'), g:sick_qd_motion_char, v:true, v:true)<cr>

onoremap <silent>
      \ <plug>(Oqwmotion) :<c-u>call
      \ segment#sick_qd_motion(getpos('.'), g:sick_qw_motion_char, v:false, v:false)<cr>
vnoremap <silent>
      \ <plug>(Vqwmotion) :<c-u>call
      \ segment#sick_qd_motion(getpos('.'), g:sick_qw_motion_char, v:false, v:false)<cr>
onoremap <silent>
      \ <plug>(OqWmotion) :<c-u>call
      \ segment#sick_qd_motion(getpos('.'), g:sick_qw_motion_char, v:false, v:true)<cr>
vnoremap <silent>
      \ <plug>(VqWmotion) :<c-u>call
      \ segment#sick_qd_motion(getpos('.'), g:sick_qw_motion_char, v:false, v:true)<cr>

onoremap <silent>
      \ <plug>(OQwmotion) :<c-u>call
      \ segment#sick_qd_motion(getpos('.'), g:sick_qw_motion_char, v:true, v:false)<cr>
vnoremap <silent>
      \ <plug>(VQwmotion) :<c-u>call
      \ segment#sick_qd_motion(getpos('.'), g:sick_qw_motion_char, v:true, v:false)<cr>
onoremap <silent>
      \ <plug>(OQWmotion) :<c-u>call
      \ segment#sick_qd_motion(getpos('.'), g:sick_qw_motion_char, v:true, v:true)<cr>
vnoremap <silent>
      \ <plug>(VQWmotion) :<c-u>call
      \ segment#sick_qd_motion(getpos('.'), g:sick_qw_motion_char, v:true, v:true)<cr>

onoremap <silent>
      \ <plug>(Oqnmotion) :<c-u>call
      \ segment#sick_qd_motion(getpos('.'), g:sick_qn_motion_char, v:false, v:false)<cr>
vnoremap <silent>
      \ <plug>(Vqnmotion) :<c-u>call
      \ segment#sick_qd_motion(getpos('.'), g:sick_qn_motion_char, v:false, v:false)<cr>
onoremap <silent>
      \ <plug>(OqNmotion) :<c-u>call
      \ segment#sick_qd_motion(getpos('.'), g:sick_qn_motion_char, v:false, v:true)<cr>
vnoremap <silent>
      \ <plug>(VqNmotion) :<c-u>call
      \ segment#sick_qd_motion(getpos('.'), g:sick_qn_motion_char, v:false, v:true)<cr>

onoremap <silent>
      \ <plug>(OQnmotion) :<c-u>call
      \ segment#sick_qd_motion(getpos('.'), g:sick_qn_motion_char, v:true, v:false)<cr>
vnoremap <silent>
      \ <plug>(VQnmotion) :<c-u>call
      \ segment#sick_qd_motion(getpos('.'), g:sick_qn_motion_char, v:true, v:false)<cr>
onoremap <silent>
      \ <plug>(OQNmotion) :<c-u>call
      \ segment#sick_qd_motion(getpos('.'), g:sick_qn_motion_char, v:true, v:true)<cr>
vnoremap <silent>
      \ <plug>(VQNmotion) :<c-u>call
      \ segment#sick_qd_motion(getpos('.'), g:sick_qn_motion_char, v:true, v:true)<cr>
