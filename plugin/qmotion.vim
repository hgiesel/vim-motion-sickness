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

if !exists('g:sick_expression_maps')
  g:sick_expression_maps = 'opendelim'
endif

" Option 1: character ib/iB/ir/ia {{{2
if g:sick_expression_maps == 'char'
  omap ib <plug>(Oibmotion)
  vmap ib <plug>(Vibmotion)
  omap ab <plug>(Oabmotion)
  vmap ab <plug>(Vabmotion)

  omap iB <plug>(OiBmotion)
  vmap iB <plug>(ViBmotion)
  omap aB <plug>(OaBmotion)
  vmap aB <plug>(VaBmotion)

  omap ir <plug>(Oirmotion)
  vmap ir <plug>(Virmotion)
  omap ar <plug>(Oarmotion)
  vmap ar <plug>(Varmotion)

  omap ia <plug>(Oiamotion)
  vmap ia <plug>(Viamotion)
  omap aa <plug>(Obamotion)
  vmap aa <plug>(Vbamotion)

  " Option 1: open delims i(/i{/i[/i< {{{2
elseif g:sick_expression_maps == 'opendelim'
  omap i( <plug>(Oibmotion)
  vmap i( <plug>(Vibmotion)
  omap a( <plug>(Oabmotion)
  vmap a( <plug>(Vabmotion)

  omap i{ <plug>(OiBmotion)
  vmap i{ <plug>(ViBmotion)
  omap a{ <plug>(OaBmotion)
  vmap a{ <plug>(VaBmotion)

  omap i[ <plug>(Oirmotion)
  vmap i[ <plug>(Virmotion)
  omap a[ <plug>(Oarmotion)
  vmap a[ <plug>(Varmotion)

  omap i< <plug>(Oiamotion)
  vmap i< <plug>(Viamotion)
  omap a< <plug>(Oaamotion)
  vmap a< <plug>(Vaamotion)

  " Option 3: close delims i)/i}/i]/i> {{{2
elseif g:sick_expression_maps == 'closedelim'
  omap i) <plug>(Oibmotion)
  vmap i) <plug>(Vibmotion)
  omap a) <plug>(Oabmotion)
  vmap a) <plug>(Vabmotion)

  omap i} <plug>(OiBmotion)
  vmap i} <plug>(ViBmotion)
  omap a} <plug>(OaBmotion)
  vmap a} <plug>(VaBmotion)

  omap i] <plug>(Oirmotion)
  vmap i] <plug>(Virmotion)
  omap a] <plug>(Oarmotion)
  vmap a] <plug>(Varmotion)

  omap i> <plug>(Oiamotion)
  vmap i> <plug>(Viamotion)
  omap I> <plug>(Oaamotion)
  vmap I> <plug>(Vaamotion)
endif

" Setting plug mappings {{{1
onoremap <silent>
      \ <plug>(Oibmotion)
      \ :<c-u>call qmotion#sick_qb_motion(getpos('.'), '(', ')', 'W')<cr>
vnoremap <silent>
      \ <plug>(Vibmotion)
      \ <esc>:<c-u>call qmotion#sick_qb_motion(getpos('.'), '(', ')', 'W')<cr>
onoremap <silent>
      \ <plug>(Oabmotion)
      \ :<c-u>call qmotion#sick_qb_motion(getpos('.'), '(', ')', 'f')<cr>
vnoremap <silent>
      \ <plug>(Vabmotion)
      \ <esc>:<c-u>call qmotion#sick_qb_motion(getpos('.'), '(', ')', 'f')<cr>

onoremap <silent>
      \ <plug>(OiBmotion)
      \ :<c-u>call qmotion#sick_qb_motion(getpos('.'), '{', '}', 'W')<cr>
vnoremap <silent>
      \ <plug>(ViBmotion)
      \ <esc>:<c-u>call qmotion#sick_qb_motion(getpos('.'), '{', '}', 'W')<cr>
onoremap <silent>
      \ <plug>(OaBmotion)
      \ :<c-u>call qmotion#sick_qb_motion(getpos('.'), '{', '}', 'f')<cr>
vnoremap <silent>
      \ <plug>(VaBmotion)
      \ <esc>:<c-u>call qmotion#sick_qb_motion(getpos('.'), '{', '}', 'f')<cr>

onoremap <silent>
      \ <plug>(Oirmotion)
      \ :<c-u>call qmotion#sick_qb_motion(getpos('.'), '[', ']', 'W')<cr>
vnoremap <silent>
      \ <plug>(Virmotion)
      \ <esc>:<c-u>call qmotion#sick_qb_motion(getpos('.'), '[', ']', 'W')<cr>
onoremap <silent>
      \ <plug>(Oarmotion)
      \ :<c-u>call qmotion#sick_qb_motion(getpos('.'), '[', ']', 'f')<cr>
vnoremap <silent>
      \ <plug>(Varmotion)
      \ <esc>:<c-u>call qmotion#sick_qb_motion(getpos('.'), '[', ']', 'f')<cr>

onoremap <silent>
      \ <plug>(Oiamotion)
      \ :<c-u>call qmotion#sick_qb_motion(getpos('.'), '<', '>', 'W')<cr>
vnoremap <silent>
      \ <plug>(Viamotion)
      \ <esc>:<c-u>call qmotion#sick_qb_motion(getpos('.'), '<', '>', 'W')<cr>
onoremap <silent>
      \ <plug>(Oaamotion)
      \ :<c-u>call qmotion#sick_qb_motion(getpos('.'), '<', '>', 'f')<cr>
vnoremap <silent>
      \ <plug>(Vaamotion)
      \ <esc>:<c-u>call qmotion#sick_qb_motion(getpos('.'), '<', '>', 'f')<cr>
