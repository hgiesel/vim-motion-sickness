" (each of them should be settable)
" data hello_world :: [String]  h
" var foo = "Hello world!"      e
" key": "value"                 c

if exists('g:loaded_motion_sickness_pair') || &compatible || v:version < 700
  finish
endif
let g:loaded_motion_sickness_pair = 1

" Setting delim chars {{{1
if !exists("g:sick_qe_motion_char")
  let g:sick_qe_motion_char = '\S*=\S*'
endif

if !exists("g:sick_qc_motion_char")
  let g:sick_qc_motion_char = ':'
endif

if !exists("g:sick_qh_motion_char")
  let g:sick_qh_motion_char = '::'
endif

" Setting user mappings {{{1
omap qe <plug>(Oqemotion)
vmap qe <plug>(Vqemotion)
omap Qe <plug>(OQemotion)
vmap Qe <plug>(VQemotion)

omap qc <plug>(Oqcmotion)
vmap qc <plug>(Vqcmotion)
omap Qc <plug>(OQcmotion)
vmap Qc <plug>(VQcmotion)

omap qh <plug>(Oqhmotion)
vmap qh <plug>(Vqhmotion)
omap Qh <plug>(OQhmotion)
vmap Qh <plug>(VQhmotion)

" Setting plug mappings {{{1
onoremap <silent>
      \ <plug>(Oqemotion) :<c-u>call
      \ pair#sick_qe_motion(getpos('.'), g:sick_qe_motion_char, v:false)<cr>
vnoremap <silent>
      \ <plug>(Vqemotion) :<c-u>call
      \ pair#sick_qe_motion(getpos('.'), g:sick_qe_motion_char, v:false)<cr>
onoremap <silent>
      \ <plug>(OQemotion) :<c-u>call
      \ pair#sick_qe_motion(getpos('.'), g:sick_qe_motion_char, v:true)<cr>
vnoremap <silent>
      \ <plug>(VQemotion) :<c-u>call
      \ pair#sick_qe_motion(getpos('.'), g:sick_qe_motion_char, v:true)<cr>

onoremap <silent>
      \ <plug>(Oqcmotion) :<c-u>call
      \ pair#sick_qe_motion(getpos('.'), g:sick_qc_motion_char, v:false)<cr>
vnoremap <silent>
      \ <plug>(Vqcmotion) :<c-u>call
      \ pair#sick_qe_motion(getpos('.'), g:sick_qc_motion_char, v:false)<cr>
onoremap <silent>
      \ <plug>(OQcmotion) :<c-u>call
      \ pair#sick_qe_motion(getpos('.'), g:sick_qc_motion_char, v:true)<cr>
vnoremap <silent>
      \ <plug>(VQcmotion) :<c-u>call
      \ pair#sick_qe_motion(getpos('.'), g:sick_qc_motion_char, v:true)<cr>

onoremap <silent>
      \ <plug>(Oqhmotion) :<c-u>call
      \ pair#sick_qe_motion(getpos('.'), g:sick_qh_motion_char, v:false)<cr>
vnoremap <silent>
      \ <plug>(Vqhmotion) :<c-u>call
      \ pair#sick_qe_motion(getpos('.'), g:sick_qh_motion_char, v:false)<cr>
onoremap <silent>
      \ <plug>(OQhmotion) :<c-u>call
      \ pair#sick_qe_motion(getpos('.'), g:sick_qh_motion_char, v:true)<cr>
vnoremap <silent>
      \ <plug>(VQhmotion) :<c-u>call
      \ pair#sick_qe_motion(getpos('.'), g:sick_qh_motion_char, v:true)<cr>
