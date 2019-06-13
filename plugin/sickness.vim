" MOTION SICKNESS BRACKETS:

if get(g:, 'sickness#alias#enabled', v:true)
      \ && !(get(g:, 'sickness#expression#preferred_shortcut_map', 'default') ==# 'char')
      \ && !(get(g:, 'sickness#field#preferred_shortcut_map', 'default') ==# 'char')
  call sickness#alias#add()
endif

if get(g:, 'sickness#expression#enabled', v:true)
  call sickness#expression#add(g:sickness#expression#openclosedelims)
endif

if get(g:, 'sickness#field#enabled', v:true)
  call sickness#field#add(g:sickness#field#openclosedelims, g:sickness#field#fielddelims)
endif

" MOTION SICKNESS OTHERS:

if get(g:, 'sickness#indentation#enabled', v:true)
  call sickness#indentation#add()
endif

if get(g:, 'sickness#line#enabled', v:true)
  call sickness#line#add()
endif

if get(g:, 'sickness#view#enabled', v:true)
  call sickness#view#add()
endif

if get(g:, 'sickness#symbol#enabled', v:true)
  call sickness#symbol#add(g:sickness#symbol#maps)
endif
