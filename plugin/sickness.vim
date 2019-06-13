" MOTION SICKNESS BRACKETS:

if get(g:, 'sick#alias#enabled', v:true) && !(get(g:, 'sick#bracket#maps', 'default') ==# 'char')
  call sickness#alias#add()
endif

if get(g:, 'sickness#expression#enabled', v:true)
  call sickness#expression#add(g:sickness#bracket#maps)
endif

if get(g:, 'sickness#field#enabled', v:true)
  call sickness#field#add(g:sickness#bracket#maps, g:sickness#field#delimiters)
endif

" MOTION SICKNESS OTHERS:

if get(g:, 'sickness#indent#enabled', v:true)
  call sickness#indent#add()
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
