" EXPRESSION motions

if exists('g:loaded_sick_expression') || &compatible || v:version < 700
  finish
endif
let g:loaded_sick_expression = 1

" Setting user mappings {{{1
if !exists('g:sick_expression_maps')
  let g:sick_expression_maps = 'e-prefix'
endif

" Option 1: e prefix ieb/ieB/ier/iea {{{1
if g:sick_field_maps == 'e-prefix'
  omap ieb <plug>(Oiebmotion)
  vmap ieb <plug>(Viebmotion)
  omap aeb <plug>(Oaebmotion)
  vmap aeb <plug>(Vaebmotion)

  omap ier <plug>(Oiermotion)
  vmap ier <plug>(Viermotion)
  omap aer <plug>(Oaermotion)
  vmap aer <plug>(Vaermotion)

  omap ieB <plug>(OieBmotion)
  vmap ieB <plug>(VieBmotion)
  omap aeB <plug>(OaeBmotion)
  vmap aeB <plug>(VaeBmotion)

  omap iea <plug>(Oieamotion)
  vmap iea <plug>(Vieamotion)
  omap aea <plug>(Oaeamotion)
  vmap aea <plug>(Vaeamotion)

  omap ie( <plug>(Oiebmotion)
  vmap ie( <plug>(Viebmotion)
  omap ae( <plug>(Oaebmotion)
  vmap ae( <plug>(Vaebmotion)

  omap ie[ <plug>(Oiermotion)
  vmap ie[ <plug>(Viermotion)
  omap ae[ <plug>(Oaermotion)
  vmap ae[ <plug>(Vaermotion)

  omap ie{ <plug>(OieBmotion)
  vmap ie{ <plug>(VieBmotion)
  omap ae{ <plug>(OaeBmotion)
  vmap ae{ <plug>(VaeBmotion)

  omap ie< <plug>(Oieamotion)
  vmap ie< <plug>(Vieamotion)
  omap ae< <plug>(Oaeamotion)
  vmap ae< <plug>(Vaeamotion)

  omap ie) <plug>(Oiebmotion)
  vmap ie) <plug>(Viebmotion)
  omap ae) <plug>(Oaebmotion)
  vmap ae) <plug>(Vaebmotion)

  omap ie] <plug>(Oiermotion)
  vmap ie] <plug>(Viermotion)
  omap ae] <plug>(Oaermotion)
  vmap ae] <plug>(Vaermotion)

  omap ie} <plug>(OieBmotion)
  vmap ie} <plug>(VieBmotion)
  omap ae} <plug>(OaeBmotion)
  vmap ae} <plug>(VaeBmotion)

  omap ie> <plug>(Oieamotion)
  vmap ie> <plug>(Vieamotion)
  omap ae> <plug>(Oaeamotion)
  vmap ae> <plug>(Vaeamotion)

" Option 2: character ib/iB/ir/ia {{{1
elseif g:sick_expression_maps == 'char'
  omap ib <plug>(Oiebmotion)
  vmap ib <plug>(Viebmotion)
  omap ab <plug>(Oaebmotion)
  vmap ab <plug>(Vaebmotion)

  omap iB <plug>(OieBmotion)
  vmap iB <plug>(VieBmotion)
  omap aB <plug>(OaeBmotion)
  vmap aB <plug>(VaeBmotion)

  omap ir <plug>(Oiermotion)
  vmap ir <plug>(Viermotion)
  omap ar <plug>(Oaermotion)
  vmap ar <plug>(Vaermotion)

  omap ia <plug>(Oieamotion)
  vmap ia <plug>(Vieamotion)
  omap aa <plug>(Obeamotion)
  vmap aa <plug>(Vbeamotion)

" Option 3: open delims i(/i{/i[/i< {{{1
elseif g:sick_expression_maps == 'opendelim'
  omap i( <plug>(Oiebmotion)
  vmap i( <plug>(Viebmotion)
  omap a( <plug>(Oaebmotion)
  vmap a( <plug>(Vaebmotion)

  omap i{ <plug>(OieBmotion)
  vmap i{ <plug>(VieBmotion)
  omap a{ <plug>(OaeBmotion)
  vmap a{ <plug>(VaeBmotion)

  omap i[ <plug>(Oiermotion)
  vmap i[ <plug>(Viermotion)
  omap a[ <plug>(Oaermotion)
  vmap a[ <plug>(Vaermotion)

  omap i< <plug>(Oieamotion)
  vmap i< <plug>(Vieamotion)
  omap a< <plug>(Oaeamotion)
  vmap a< <plug>(Vaeamotion)

" Option 4: close delims i)/i}/i]/i> {{{1
elseif g:sick_expression_maps == 'closedelim'
  omap i) <plug>(Oiebmotion)
  vmap i) <plug>(Viebmotion)
  omap a) <plug>(Oaebmotion)
  vmap a) <plug>(Vaebmotion)

  omap i} <plug>(OieBmotion)
  vmap i} <plug>(VieBmotion)
  omap a} <plug>(OaeBmotion)
  vmap a} <plug>(VaeBmotion)

  omap i] <plug>(Oiermotion)
  vmap i] <plug>(Viermotion)
  omap a] <plug>(Oaermotion)
  vmap a] <plug>(Vaermotion)

  omap i> <plug>(Oieamotion)
  vmap i> <plug>(Vieamotion)
  omap I> <plug>(Oaeamotion)
  vmap I> <plug>(Vaeamotion)
endif

" Setting plug mappings {{{1
onoremap <silent>
      \ <plug>(Oiebmotion)
      \ :<c-u>call expression#motion(getpos('.'), '(', ')', 'W')<cr>
vnoremap <silent>
      \ <plug>(Viebmotion)
      \ <esc>:<c-u>call expression#motion(getpos('.'), '(', ')', 'W')<cr>
onoremap <silent>
      \ <plug>(Oaebmotion)
      \ :<c-u>call expression#motion(getpos('.'), '(', ')', 'f')<cr>
vnoremap <silent>
      \ <plug>(Vaebmotion)
      \ <esc>:<c-u>call expression#motion(getpos('.'), '(', ')', 'f')<cr>

onoremap <silent>
      \ <plug>(OieBmotion)
      \ :<c-u>call expression#motion(getpos('.'), '{', '}', 'W')<cr>
vnoremap <silent>
      \ <plug>(VieBmotion)
      \ <esc>:<c-u>call expression#motion(getpos('.'), '{', '}', 'W')<cr>
onoremap <silent>
      \ <plug>(OaeBmotion)
      \ :<c-u>call expression#motion(getpos('.'), '{', '}', 'f')<cr>
vnoremap <silent>
      \ <plug>(VaeBmotion)
      \ <esc>:<c-u>call expression#motion(getpos('.'), '{', '}', 'f')<cr>

onoremap <silent>
      \ <plug>(Oiermotion)
      \ :<c-u>call expression#motion(getpos('.'), '[', ']', 'W')<cr>
vnoremap <silent>
      \ <plug>(Viermotion)
      \ <esc>:<c-u>call expression#motion(getpos('.'), '[', ']', 'W')<cr>
onoremap <silent>
      \ <plug>(Oaermotion)
      \ :<c-u>call expression#motion(getpos('.'), '[', ']', 'f')<cr>
vnoremap <silent>
      \ <plug>(Vaermotion)
      \ <esc>:<c-u>call expression#motion(getpos('.'), '[', ']', 'f')<cr>

onoremap <silent>
      \ <plug>(Oieamotion)
      \ :<c-u>call expression#motion(getpos('.'), '<', '>', 'W')<cr>
vnoremap <silent>
      \ <plug>(Vieamotion)
      \ <esc>:<c-u>call expression#motion(getpos('.'), '<', '>', 'W')<cr>
onoremap <silent>
      \ <plug>(Oaeamotion)
      \ :<c-u>call expression#motion(getpos('.'), '<', '>', 'f')<cr>
vnoremap <silent>
      \ <plug>(Vaeamotion)
      \ <esc>:<c-u>call expression#motion(getpos('.'), '<', '>', 'f')<cr>
