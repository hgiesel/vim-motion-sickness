" INDENTATION AND LINE MOTION
if exists('g:loaded_motion_sickness_indent') || &compatible || v:version < 700
  finish
endif
let g:loaded_motion_sickness_indent = 1

if get(g:, 'sick_field_enabled', v:true)
  " Indentation Setting user mappings {{{1
  if get(g:, 'sick_indent_default_mappings', v:true)
    omap iip <plug>(Oiipmotion)
    vmap iip <plug>(Viipmotion)
    omap aip <plug>(Oaipmotion)
    vmap aip <plug>(Vaipmotion)

    omap iil <plug>(Oiilmotion)
    vmap iil <plug>(Viilmotion)
    omap ail <plug>(Oailmotion)
    vmap ail <plug>(Vailmotion)

    omap iib <plug>(Oiibmotion)
    vmap iib <plug>(Viibmotion)
    omap aib <plug>(Oaibmotion)
    vmap aib <plug>(Vaibmotion)

    omap iit <plug>(Oiitmotion)
    vmap iit <plug>(Viitmotion)
    omap ait <plug>(Oaitmotion)
    vmap ait <plug>(Vaitmotion)
  endif

  " Indentation Setting plug mappings {{{1
  onoremap <silent> <plug>(Oiipmotion) <cmd>call indent#motion(v:false, 'p')<cr>
  vnoremap <silent> <plug>(Viipmotion) <cmd>call indent#motion(v:false, 'p')<cr>
  onoremap <silent> <plug>(Oaipmotion) <cmd>call indent#motion(v:true, 'p')<cr>
  vnoremap <silent> <plug>(Vaipmotion) <cmd>call indent#motion(v:true, 'p')<cr>

  onoremap <silent> <plug>(Oiilmotion) <cmd>call indent#motion(v:false, 'l')<cr>
  vnoremap <silent> <plug>(Viilmotion) <cmd>call indent#motion(v:false, 'l')<cr>
  onoremap <silent> <plug>(Oailmotion) <cmd>call indent#motion(v:true, 'l')<cr>
  vnoremap <silent> <plug>(Vailmotion) <cmd>call indent#motion(v:true, 'l')<cr>

  onoremap <silent> <plug>(Oiibmotion) <cmd>call indent#motion(v:false, 'b')<cr>
  vnoremap <silent> <plug>(Viibmotion) <cmd>call indent#motion(v:false, 'b')<cr>
  onoremap <silent> <plug>(Oaibmotion) <cmd>call indent#motion(v:true, 'b')<cr>
  vnoremap <silent> <plug>(Vaibmotion) <cmd>call indent#motion(v:true, 'b')<cr>

  onoremap <silent> <plug>(Oiitmotion) <cmd>call indent#motion(v:false, 't')<cr>
  vnoremap <silent> <plug>(Viitmotion) <cmd>call indent#motion(v:false, 't')<cr>
  onoremap <silent> <plug>(Oaitmotion) <cmd>call indent#motion(v:true, 't')<cr>
  vnoremap <silent> <plug>(Vaitmotion) <cmd>call indent#motion(v:true, 't')<cr>
endif

" Line Setting user mappings {{{1
if get(g:, 'sick_line_enabled', v:true)
  if get(g:, 'sick_line_default_mappings', v:true)
    omap il <plug>(Oilmotion)
    vmap il <plug>(Vilmotion)
    omap al <plug>(Oalmotion)
    vmap al <plug>(Valmotion)
  endif

  " Line Setting plug mappings {{{1
  onoremap <silent> <plug>(Oilmotion) <cmd>call line#motion('i')<cr>
  vnoremap <silent> <plug>(Vilmotion) <cmd>call line#motion('i')<cr>
  onoremap <silent> <plug>(Oalmotion) <cmd>call line#motion('a')<cr>
  vnoremap <silent> <plug>(Valmotion) <cmd>call line#motion('a')<cr>
endif

if get(g:, 'sick_view_enabled', v:true)
  " Line Setting user mappings {{{1
  if get(g:, 'sick_view_default_mappings', v:true)
    omap iv <plug>(Oivmotion)
    vmap iv <plug>(Vivmotion)
    omap av <plug>(Oavmotion)
    vmap av <plug>(Vavmotion)
  endif

  " Line Setting plug mappings {{{1
  onoremap <silent> <plug>(Oivmotion) <cmd>call view#motion('i')<cr>
  vnoremap <silent> <plug>(Vivmotion) <cmd>call view#motion('i')<cr>
  onoremap <silent> <plug>(Oavmotion) <cmd>call view#motion('a')<cr>
  vnoremap <silent> <plug>(Vavmotion) <cmd>call view#motion('a')<cr>
endif
