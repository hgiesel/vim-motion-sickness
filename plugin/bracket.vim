" BRACKET MOTIONS
if exists('g:loaded_sick_bracket') || &compatible || v:version < 700
  finish
endif
let g:loaded_sick_bracket = 1

" Setting user mappings {{{1
if !exists('g:sick_matchtriples')
  let g:sick_matchtriples = [
        \ ['b', '(', ')'],
        \ ['B', '{', '}'],
        \ ['r', '[', ']'],
        \ ['a', '<', '>']
        \ ]
endif

" Alias remappings {{{1
if
      \ !(exists('g:sick_expression_maps') && g:sick_expression_maps == 'char') && 
      \ !(exists('g:sick_field_maps') && g:sick_field_maps == 'char')
  onoremap <silent> ir i[
  vnoremap <silent> ir i[
  onoremap <silent> ar a[
  vnoremap <silent> ar a[

  onoremap <silent> ia i<
  vnoremap <silent> ia i<
  onoremap <silent> aa a<
  vnoremap <silent> aa a<
endif

" Fields function {{{1
function Field_maps_add(matchtriples)
  for l:triple in a:matchtriples
    if !exists('g:sick_field_maps') " use prefix
      execute 'omap if'.l:triple[0].' <plug>(Oif'.l:triple[0].'motion)'
      execute 'vmap if'.l:triple[0].' <plug>(Vif'.l:triple[0].'motion)'
      execute 'omap af'.l:triple[0].' <plug>(Oaf'.l:triple[0].'motion)'
      execute 'vmap af'.l:triple[0].' <plug>(Vaf'.l:triple[0].'motion)'

      execute 'omap if'.l:triple[1].' <plug>(Oif'.l:triple[0].'motion)'
      execute 'vmap if'.l:triple[1].' <plug>(Vif'.l:triple[0].'motion)'
      execute 'omap af'.l:triple[1].' <plug>(Oaf'.l:triple[0].'motion)'
      execute 'vmap af'.l:triple[1].' <plug>(Vaf'.l:triple[0].'motion)'

      execute 'omap if'.l:triple[2].' <plug>(Oif'.l:triple[0].'motion)'
      execute 'vmap if'.l:triple[2].' <plug>(Vif'.l:triple[0].'motion)'
      execute 'omap af'.l:triple[2].' <plug>(Oaf'.l:triple[0].'motion)'
      execute 'vmap af'.l:triple[2].' <plug>(Vaf'.l:triple[0].'motion)'

      if exists('g:sick_field_extra_delimiter')
        for l:pair in g:sick_field_extra_delimiter
          execute 'omap if'.l:pair[1].l:triple[0].' <plug>(Oif'.l:pair[0].l:triple[0].'motion)'
          execute 'vmap if'.l:pair[1].l:triple[0].' <plug>(Vif'.l:pair[0].l:triple[0].'motion)'
          execute 'omap af'.l:pair[1].l:triple[0].' <plug>(Oaf'.l:pair[0].l:triple[0].'motion)'
          execute 'vmap af'.l:pair[1].l:triple[0].' <plug>(Vaf'.l:pair[0].l:triple[0].'motion)'

          execute 'omap if'.l:pair[1].l:triple[1].' <plug>(Oif'.l:pair[0].l:triple[0].'motion)'
          execute 'vmap if'.l:pair[1].l:triple[1].' <plug>(Vif'.l:pair[0].l:triple[0].'motion)'
          execute 'omap af'.l:pair[1].l:triple[1].' <plug>(Oaf'.l:pair[0].l:triple[0].'motion)'
          execute 'vmap af'.l:pair[1].l:triple[1].' <plug>(Vaf'.l:pair[0].l:triple[0].'motion)'

          execute 'omap if'.l:pair[1].l:triple[2].' <plug>(Oif'.l:pair[0].l:triple[0].'motion)'
          execute 'vmap if'.l:pair[1].l:triple[2].' <plug>(Vif'.l:pair[0].l:triple[0].'motion)'
          execute 'omap af'.l:pair[1].l:triple[2].' <plug>(Oaf'.l:pair[0].l:triple[0].'motion)'
          execute 'vmap af'.l:pair[1].l:triple[2].' <plug>(Vaf'.l:pair[0].l:triple[0].'motion)'
        endfor
      endif

    else " g:sick_field_maps is defined
      if g:sick_field_maps ==# 'char'
        let l:theindex = 0
      elseif g:sick_field_maps ==# 'opendelim'
        let l:theindex = 1
      else " g:sick_field_maps ==# 'closedelim'
        let l:theindex = 2
      endif

      execute 'omap i'.l:triple[l:theindex].' <plug>(Oif'.l:triple[0].'motion)'
      execute 'vmap i'.l:triple[l:theindex].' <plug>(Vif'.l:triple[0].'motion)'
      execute 'omap a'.l:triple[l:theindex].' <plug>(Oaf'.l:triple[0].'motion)'
      execute 'vmap a'.l:triple[l:theindex].' <plug>(Vaf'.l:triple[0].'motion)'

      if exists('g:sick_field_extra_delimiter')
        for l:pair in g:sick_field_extra_deliter
          execute 'omap if'.l:pair[1].l:triple[l:theindex].' <plug>(Oif'.l:pair[0].l:triple[0].'motion)'
          execute 'vmap if'.l:pair[1].l:triple[l:theindex].' <plug>(Vif'.l:pair[0].l:triple[0].'motion)'
          execute 'omap af'.l:pair[1].l:triple[l:theindex].' <plug>(Oaf'.l:pair[0].l:triple[0].'motion)'
          execute 'vmap af'.l:pair[1].l:triple[l:theindex].' <plug>(Vaf'.l:pair[0].l:triple[0].'motion)'
        endfor
      endif
    endif

    execute "onoremap <silent> <plug>(Oif".l:triple[0]."motion) :<c-u>call field#motion(1, 0, '".l:triple[1]."', '".l:triple[2]."', ',')<cr>"
    execute "vnoremap <silent> <plug>(Vif".l:triple[0]."motion) <esc>:<c-u>call field#motion(1, 1, '".l:triple[1]."', '".l:triple[2]."', ',')<cr>"
    execute "onoremap <silent> <plug>(Oaf".l:triple[0]."motion) :<c-u>call field#motion(0, 0, '".l:triple[1]."', '".l:triple[2]."', ',')<cr>"
    execute "vnoremap <silent> <plug>(Vaf".l:triple[0]."motion) <esc>:<c-u>call field#motion(0, 1, '".l:triple[1]."', '".l:triple[2]."', ',')<cr>"

    if exists('g:sick_field_extra_delimiter')
      for l:pair in g:sick_field_extra_deliter
        execute "onoremap <silent> <plug>(Oif".l:pair[0].l:triple[0]."motion) :<c-u>call field#motion(1, 0, '".l:triple[1]."', '".l:triple[2]."', '".l:pair[1]."')<cr>"
        execute "vnoremap <silent> <plug>(Vif".l:pair[0].l:triple[0]."motion) <esc>:<c-u>call field#motion(1, 1, '".l:triple[1]."', '".l:triple[2]."', '".l:pair[1]."')<cr>"
        execute "onoremap <silent> <plug>(Oaf".l:pair[0].l:triple[0]."motion) :<c-u>call field#motion(0, 0, '".l:triple[1]."', '".l:triple[2]."', '".l:pair[1]."')<cr>"
        execute "vnoremap <silent> <plug>(Vaf".l:pair[0].l:triple[0]."motion) <esc>:<c-u>call field#motion(0, 1, '".l:triple[1]."', '".l:triple[2]."', '".l:pair[1]."')<cr>"
      endfor
    endif
  endfor
endfunction

" Expression function {{{1
function Expression_maps_add(matchtriples)
  for l:triple in a:matchtriples
    if !exists('g:sick_expression_maps') " use prefix
      execute 'omap ie'.l:triple[0].' <plug>(Oie'.l:triple[0].'motion)'
      execute 'vmap ie'.l:triple[0].' <plug>(Vie'.l:triple[0].'motion)'
      execute 'omap ae'.l:triple[0].' <plug>(Oae'.l:triple[0].'motion)'
      execute 'vmap ae'.l:triple[0].' <plug>(Vae'.l:triple[0].'motion)'

      execute 'omap ie'.l:triple[1].' <plug>(Oie'.l:triple[0].'motion)'
      execute 'vmap ie'.l:triple[1].' <plug>(Vie'.l:triple[0].'motion)'
      execute 'omap ae'.l:triple[1].' <plug>(Oae'.l:triple[0].'motion)'
      execute 'vmap ae'.l:triple[1].' <plug>(Vae'.l:triple[0].'motion)'

      execute 'omap ie'.l:triple[2].' <plug>(Oie'.l:triple[0].'motion)'
      execute 'vmap ie'.l:triple[2].' <plug>(Vie'.l:triple[0].'motion)'
      execute 'omap ae'.l:triple[2].' <plug>(Oae'.l:triple[0].'motion)'
      execute 'vmap ae'.l:triple[2].' <plug>(Vae'.l:triple[0].'motion)'

    else
      if g:sick_expression_maps ==# 'char'
        let l:theindex = 0
      elseif g:sick_expression_maps ==# 'opendelim'
        let l:theindex = 1
      else " g:sick_expression_maps ==# 'closedelim'
        let l:theindex = 2
      endif

      execute 'omap i'.l:triple[l:theindex].' <plug>(Oie'.l:triple[0].'motion)'
      execute 'vmap i'.l:triple[l:theindex].' <plug>(Vie'.l:triple[0].'motion)'
      execute 'omap a'.l:triple[l:theindex].' <plug>(Oae'.l:triple[0].'motion)'
      execute 'vmap a'.l:triple[l:theindex].' <plug>(Vae'.l:triple[0].'motion)'
    endif

    execute "onoremap <silent> <plug>(Oie".l:triple[0]."motion) :<c-u>call expression#motion(getpos('.'), '".l:triple[1]."', '".l:triple[2]."', 'W')<cr>"
    execute "vnoremap <silent> <plug>(Vie".l:triple[0]."motion) <esc>:<c-u>call expression#motion(getpos('.'), '".l:triple[1]."', '".l:triple[2]."', 'W')<cr>"
    execute "onoremap <silent> <plug>(Oae".l:triple[0]."motion) :<c-u>call expression#motion(getpos('.'), '".l:triple[1]."', '".l:triple[2]."', 'f')<cr>"
    execute "vnoremap <silent> <plug>(Vae".l:triple[0]."motion) <esc>:<c-u>call expression#motion(getpos('.'), '".l:triple[1]."', '".l:triple[2]."', 'f')<cr>"
  endfor
endfunction

" Function calls {{{1
call Field_maps_add(g:sick_matchtriples)
call Expression_maps_add(g:sick_matchtriples)
