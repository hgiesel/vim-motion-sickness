" Defining functinos {{{1
function! symbol#sick_symbol_motion(wrap, symbol, mode)
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
