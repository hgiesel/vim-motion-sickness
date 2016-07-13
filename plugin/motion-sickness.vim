" Add some lines which don't do anything cause they are comments And some more
" This plugin adds a lot of motion mappings. Here's a list
"
" 1. `ir`, `ar`, `ia`, and `aa` where `r` and `a` are aliases for `[` and `<`
"    (similiar to tpopes' vim-surround plugin
"
"
" 2. `i_`, `a_` and family, which are a lot of motions that work like `ab` or
"    `aB` but with symbols
"
" 3. `qb` `qB` `qr` `qa` which are motions that select statements, e.g.
"    foo(500 + 500)
"    while you would use `ib` to select everything within the parentheses and
"    `ab` to select the whole parenthesis, you can use `qb` to use the whole
"    parenthesis and the word before it. Also works with $(( )) or similiar
"    things
"
" 4. `iqb` `aqb`, etc. is used to select parameters (or arguments) within
"    braces, very helpful for any kind of programming language
" 5. `qd` `qD` `Qd` `QD` is used to select dot statements, e.g. test().arg[50]
"
"    Planned for the future are: `qc` to select colon statements; `qw` to
"    select arrow statements (in C) and to make iqb and qb work correctly with
"    `<` characters splattered over the place

onoremap <silent> ir i[
onoremap <silent> ar a[
onoremap <silent> ia i<
onoremap <silent> aa a<
vnoremap <silent> ir i[
vnoremap <silent> ar a[
vnoremap <silent> ia i<
vnoremap <silent> aa a<


function! s:enclose_according_to(char,inner)
    let l:startpos = getpos('.')

    if a:inner
        let l:from_char = 'T'
        let l:to_char   = 't'
        let l:inc       = '1'

    else
        let l:from_char = 'F'
        let l:to_char   = 'f'
        let l:inc       = '0'
    end

    silent! execute "normal! " . l:from_char . a:char

    if getline('.')[col('.') - 1 - l:inc] !=# a:char
        call setpos('.',l:startpos)
        normal! v

    else
        let l:left_pos = getpos('.')
        silent! execute "normal! v".l:to_char.a:char
        if getline('.')[col('.') - 1 + l:inc] !=# a:char
                    \ || getpos('.') ==# l:left_pos
            normal! v
            call setpos('.',l:startpos)
            normal! v
        endif
    endif
endfunction

vnoremap <silent> i_ :<c-u>call <sid>enclose_according_to('_',1)<cr>
vnoremap <silent> a_ :<c-u>call <sid>enclose_according_to('_',0)<cr>
onoremap <silent> i_ :<c-u>call <sid>enclose_according_to('_',1)<cr>
onoremap <silent> a_ :<c-u>call <sid>enclose_according_to('_',0)<cr>

vnoremap <silent> i. :<c-u>call <sid>enclose_according_to('.',1)<cr>
vnoremap <silent> a. :<c-u>call <sid>enclose_according_to('.',0)<cr>
onoremap <silent> i. :<c-u>call <sid>enclose_according_to('.',1)<cr>
onoremap <silent> a. :<c-u>call <sid>enclose_according_to('.',0)<cr>

vnoremap <silent> i* :<c-u>call <sid>enclose_according_to('*',1)<cr>
vnoremap <silent> a* :<c-u>call <sid>enclose_according_to('*',0)<cr>
onoremap <silent> i* :<c-u>call <sid>enclose_according_to('*',1)<cr>
onoremap <silent> a* :<c-u>call <sid>enclose_according_to('*',0)<cr>

vnoremap <silent> i$ :<c-u>call <sid>enclose_according_to('$',1)<cr>
vnoremap <silent> a$ :<c-u>call <sid>enclose_according_to('$',0)<cr>
onoremap <silent> i$ :<c-u>call <sid>enclose_according_to('$',1)<cr>
onoremap <silent> a$ :<c-u>call <sid>enclose_according_to('$',0)<cr>

vnoremap <silent> i@ :<c-u>call <sid>enclose_according_to('@',1)<cr>
vnoremap <silent> a@ :<c-u>call <sid>enclose_according_to('@',0)<cr>
onoremap <silent> i@ :<c-u>call <sid>enclose_according_to('@',1)<cr>
onoremap <silent> a@ :<c-u>call <sid>enclose_according_to('@',0)<cr>

vnoremap <silent> i- :<c-u>call <sid>enclose_according_to('-',1)<cr>
vnoremap <silent> a- :<c-u>call <sid>enclose_according_to('-',0)<cr>
onoremap <silent> i- :<c-u>call <sid>enclose_according_to('-',1)<cr>
onoremap <silent> a- :<c-u>call <sid>enclose_according_to('-',0)<cr>

vnoremap <silent> i: :<c-u>call <sid>enclose_according_to(':',1)<cr>
vnoremap <silent> a: :<c-u>call <sid>enclose_according_to(':',0)<cr>
onoremap <silent> i: :<c-u>call <sid>enclose_according_to(':',1)<cr>
onoremap <silent> a: :<c-u>call <sid>enclose_according_to(':',0)<cr>

vnoremap <silent> i? :<c-u>call <sid>enclose_according_to('?',1)<cr>
vnoremap <silent> a? :<c-u>call <sid>enclose_according_to('?',0)<cr>
onoremap <silent> i? :<c-u>call <sid>enclose_according_to('?',1)<cr>
onoremap <silent> a? :<c-u>call <sid>enclose_according_to('?',0)<cr>

vnoremap <silent> i, :<c-u>call <sid>enclose_according_to(',',1)<cr>
vnoremap <silent> a, :<c-u>call <sid>enclose_according_to(',',0)<cr>
onoremap <silent> i, :<c-u>call <sid>enclose_according_to(',',1)<cr>
onoremap <silent> a, :<c-u>call <sid>enclose_according_to(',',0)<cr>

vnoremap <silent> i/ :<c-u>call <sid>enclose_according_to('/',1)<cr>
vnoremap <silent> a/ :<c-u>call <sid>enclose_according_to('/',0)<cr>
onoremap <silent> i/ :<c-u>call <sid>enclose_according_to('/',1)<cr>
onoremap <silent> a/ :<c-u>call <sid>enclose_according_to('/',0)<cr>

vnoremap <silent> i~ :<c-u>call <sid>enclose_according_to('~',1)<cr>
vnoremap <silent> a~ :<c-u>call <sid>enclose_according_to('~',0)<cr>
onoremap <silent> i~ :<c-u>call <sid>enclose_according_to('~',1)<cr>
onoremap <silent> a~ :<c-u>call <sid>enclose_according_to('~',0)<cr>

function! s:make_a_q(open_char,close_char,cWORD)
    let l:invalid   = 0
    let l:recursion = 0
    let l:finished  = 0

    while !l:invalid && !l:finished && l:recursion < 5
        let l:next_char = getline('.')[col('.') - 2]
        let l:recursion += 1

        " if there is a space or bol to the left of proposed statement, it's
        " no statement
        if l:next_char ==# ' ' || col('.') == 1
            let l:invalid = 1

        " if character right beside open_char is another closing statement
        " of any kind this one should be embraced as well
        elseif l:next_char =~# '\v[\)\]\}\>]'
            normal! h
            let l:mark_col = col('.')
            normal! %

            if l:mark_col ==# col('.')
                normal! l
            endif

        " if is enclosed two times by l:open_char, e.g. in bash $((1 + 2))
        " i don't allow q to be enclosed by two non identical characters,
        " like $[( )], cause that would be madness!
        elseif l:next_char ==# a:open_char
            if a:open_char ==# '.'
                let l:finished = 1

            else
                normal! o

                if getline('.')[col('.')] =~# a:close_char
                    normal! loh

                else
                    let l:invalid = 1
                endif
            endif

        " if character next to such an statement is a character, it is
        " probably its name
        elseif l:next_char =~ '\v[a-zA-Z0-9_]'
            if a:cWORD
                normal! B

            else
                normal! b
            endif

            let l:finished = 1

        " for common structures like `$()` `<()` `>()` `=()`
        " which are found e.g. in shell scripts or jquery
        elseif l:next_char =~# '\v[\$\<\>\=]'
            normal! h
            let l:finished = 1
        endif

    endwhile

    return l:invalid
endfunction

function! s:check_if_cursor_in_cursors(thecursor, a, b)
    " row = 1 , column = 2
    if a:thecursor[1] ># a:a[1] && a:thecursor[1] <# a:b[1]
        return 1

    elseif a:thecursor[1] ># a:a[1] && a:thecursor[1] ==# a:b[1] &&
                \ a:thecursor[2] <=# a:b[2]
        return 1

    elseif a:thecursor[1] ==# a:a[1] && a:thecursor[2] >=# a:a[2] &&
                \ a:thecursor[1] <# a:b[1]
        return 1

    elseif a:thecursor[1] ==# a:a[1] && a:thecursor[2] >=# a:a[2] &&
                \ a:thecursor[1] ==# a:b[1] && a:thecursor[2] <=# a:b[2]
        return 1
    endif

    return 0
endfunction

function! s:find_nth_char(n,char)
    if getline('.')[col('.')-1] !=# a:char
        for i in range(a:n)
            silent! execute "normal! /".a:char."\<cr>"
        endfor
    endif

    silent! execute "normal! va".a:char."o"
endfunction

function! s:qb_motion(cur_pos, open_char, close_char, cWORD)
    let l:repetitions = 1
    let l:winview = winsaveview()

    " this checks if the cursor is inside the name of the statement
    " e.g. `fo|o(55)` where `|` is the cursor
    " this will only work with 10 recursions, because this could go on forever
    while l:repetitions < 10
        call s:find_nth_char(l:repetitions,a:close_char)
        call s:make_a_q(a:open_char,a:close_char,a:cWORD)
        normal! o

        if !s:check_if_cursor_in_cursors(a:cur_pos,getpos('v'),getpos('.'))
            normal! v
            call setpos('.',a:cur_pos)
            let l:repetitions += 1

        else
            call winrestview({'topline':l:winview.topline,
                        \ 'leftcol':l:winview.leftcol})
            return 0
        endif
    endwhile

    " if the function has come this far, it is assumed that the cursor is
    " inside the braces of the statement (and not the name)
    silent! execute "normal! va".a:open_char

    " if there is no statement under your cursor, `make_a_q()` would
    " unnecessarily change your cursor position
    if mode(0) == 'v'
        silent! execute "normal! o"
        call s:make_a_q(a:open_char,a:close_char,a:cWORD)
        call winrestview({'topline':l:winview.topline,
                    \ 'leftcol':l:winview.leftcol})
    endif
endfunction

onoremap <silent> qb :<c-u>call <sid>qb_motion(getpos('.'),'(',')',0)<cr>
onoremap <silent> qB :<c-u>call <sid>qb_motion(getpos('.'),'{','}',0)<cr>
onoremap <silent> qr :<c-u>call <sid>qb_motion(getpos('.'),'[',']',0)<cr>
onoremap <silent> qa :<c-u>call <sid>qb_motion(getpos('.'),'<','>',0)<cr>
vnoremap <silent> qb :<c-u>call <sid>qb_motion(getpos('.'),'(',')',0)<cr>
vnoremap <silent> qB :<c-u>call <sid>qb_motion(getpos('.'),'{','}',0)<cr>
vnoremap <silent> qr :<c-u>call <sid>qb_motion(getpos('.'),'[',']',0)<cr>
vnoremap <silent> qa :<c-u>call <sid>qb_motion(getpos('.'),'<','>',0)<cr>

onoremap <silent> q( :<c-u>call <sid>qb_motion(getpos('.'),'(',')',0)<cr>
onoremap <silent> q{ :<c-u>call <sid>qb_motion(getpos('.'),'{','}',0)<cr>
onoremap <silent> q[ :<c-u>call <sid>qb_motion(getpos('.'),'[',']',0)<cr>
onoremap <silent> q< :<c-u>call <sid>qb_motion(getpos('.'),'<','>',0)<cr>
vnoremap <silent> q( :<c-u>call <sid>qb_motion(getpos('.'),'(',')',0)<cr>
vnoremap <silent> q{ :<c-u>call <sid>qb_motion(getpos('.'),'{','}',0)<cr>
vnoremap <silent> q[ :<c-u>call <sid>qb_motion(getpos('.'),'[',']',0)<cr>
vnoremap <silent> q< :<c-u>call <sid>qb_motion(getpos('.'),'<','>',0)<cr>

onoremap <silent> Qb :<c-u>call <sid>qb_motion(getpos('.'),'(',')',1)<cr>
onoremap <silent> QB :<c-u>call <sid>qb_motion(getpos('.'),'{','}',1)<cr>
onoremap <silent> Qr :<c-u>call <sid>qb_motion(getpos('.'),'[',']',1)<cr>
onoremap <silent> Qa :<c-u>call <sid>qb_motion(getpos('.'),'<','>',1)<cr>
vnoremap <silent> Qb :<c-u>call <sid>qb_motion(getpos('.'),'(',')',1)<cr>
vnoremap <silent> QB :<c-u>call <sid>qb_motion(getpos('.'),'{','}',1)<cr>
vnoremap <silent> Qr :<c-u>call <sid>qb_motion(getpos('.'),'[',']',1)<cr>
vnoremap <silent> Qa :<c-u>call <sid>qb_motion(getpos('.'),'<','>',1)<cr>

onoremap <silent> Q( :<c-u>call <sid>qb_motion(getpos('.'),'(',')',1)<cr>
onoremap <silent> Q{ :<c-u>call <sid>qb_motion(getpos('.'),'{','}',1)<cr>
onoremap <silent> Q[ :<c-u>call <sid>qb_motion(getpos('.'),'[',']',1)<cr>
onoremap <silent> Q< :<c-u>call <sid>qb_motion(getpos('.'),'<','>',1)<cr>
vnoremap <silent> Q( :<c-u>call <sid>qb_motion(getpos('.'),'(',')',1)<cr>
vnoremap <silent> Q{ :<c-u>call <sid>qb_motion(getpos('.'),'{','}',1)<cr>
vnoremap <silent> Q[ :<c-u>call <sid>qb_motion(getpos('.'),'[',']',1)<cr>
vnoremap <silent> Q< :<c-u>call <sid>qb_motion(getpos('.'),'<','>',1)<cr>

onoremap <silent> qb :<c-u>call <sid>qb_motion(getpos('.'),'(',')',0)<cr>
onoremap <silent> qB :<c-u>call <sid>qb_motion(getpos('.'),'{','}',0)<cr>
onoremap <silent> qr :<c-u>call <sid>qb_motion(getpos('.'),'[',']',0)<cr>
onoremap <silent> qa :<c-u>call <sid>qb_motion(getpos('.'),'<','>',0)<cr>
vnoremap <silent> qb :<c-u>call <sid>qb_motion(getpos('.'),'(',')',0)<cr>
vnoremap <silent> qB :<c-u>call <sid>qb_motion(getpos('.'),'{','}',0)<cr>
vnoremap <silent> qr :<c-u>call <sid>qb_motion(getpos('.'),'[',']',0)<cr>
vnoremap <silent> qa :<c-u>call <sid>qb_motion(getpos('.'),'<','>',0)<cr>

onoremap <silent> q( :<c-u>call <sid>qb_motion(getpos('.'),'(',')',0)<cr>
onoremap <silent> q{ :<c-u>call <sid>qb_motion(getpos('.'),'{','}',0)<cr>
onoremap <silent> q[ :<c-u>call <sid>qb_motion(getpos('.'),'[',']',0)<cr>
onoremap <silent> q< :<c-u>call <sid>qb_motion(getpos('.'),'<','>',0)<cr>
vnoremap <silent> q( :<c-u>call <sid>qb_motion(getpos('.'),'(',')',0)<cr>
vnoremap <silent> q{ :<c-u>call <sid>qb_motion(getpos('.'),'{','}',0)<cr>
vnoremap <silent> q[ :<c-u>call <sid>qb_motion(getpos('.'),'[',']',0)<cr>
vnoremap <silent> q< :<c-u>call <sid>qb_motion(getpos('.'),'<','>',0)<cr>

onoremap <silent> Qb :<c-u>call <sid>qb_motion(getpos('.'),'(',')',1)<cr>
onoremap <silent> QB :<c-u>call <sid>qb_motion(getpos('.'),'{','}',1)<cr>
onoremap <silent> Qr :<c-u>call <sid>qb_motion(getpos('.'),'[',']',1)<cr>
onoremap <silent> Qa :<c-u>call <sid>qb_motion(getpos('.'),'<','>',1)<cr>
vnoremap <silent> Qb :<c-u>call <sid>qb_motion(getpos('.'),'(',')',1)<cr>
vnoremap <silent> QB :<c-u>call <sid>qb_motion(getpos('.'),'{','}',1)<cr>
vnoremap <silent> Qr :<c-u>call <sid>qb_motion(getpos('.'),'[',']',1)<cr>
vnoremap <silent> Qa :<c-u>call <sid>qb_motion(getpos('.'),'<','>',1)<cr>

onoremap <silent> Q( :<c-u>call <sid>qb_motion(getpos('.'),'(',')',1)<cr>
onoremap <silent> Q{ :<c-u>call <sid>qb_motion(getpos('.'),'{','}',1)<cr>
onoremap <silent> Q[ :<c-u>call <sid>qb_motion(getpos('.'),'[',']',1)<cr>
onoremap <silent> Q< :<c-u>call <sid>qb_motion(getpos('.'),'<','>',1)<cr>
vnoremap <silent> Q( :<c-u>call <sid>qb_motion(getpos('.'),'(',')',1)<cr>
vnoremap <silent> Q{ :<c-u>call <sid>qb_motion(getpos('.'),'{','}',1)<cr>
vnoremap <silent> Q[ :<c-u>call <sid>qb_motion(getpos('.'),'[',']',1)<cr>
vnoremap <silent> Q< :<c-u>call <sid>qb_motion(getpos('.'),'<','>',1)<cr>

" make direction and greedy, instead of cWORD and greedy, that's too much
function! s:qd_motion(cur_pos,chars,cWORD,greedy)
    let l:invalid            = 0
    let l:finished           = 0
    let l:dot_was_found      = 0
    let l:made_an_assumption = 0
    let l:fall_back_braces   = [0,0]
    let l:invalid_chars      = '\v[ \;]'
    let l:cursor_char = getline('.')[col('.') - 1]

    if l:cursor_char =~# '\v[\(\)\[\]\{\}\<\>]'
        execute "normal! f".a:chars
        if getline('.')[col('.') - 1] !=# a:chars
            let l:invalid = 1

        else
            if s:make_a_q(a:chars,a:chars,a:cWORD) ==# 1
                let l:invalid = 1

            else
                normal! o
                let l:dot_was_found = 1
            endif
        endif

    elseif l:cursor_char =~# '\V'.a:chars
        normal! v

        if s:make_a_q(a:chars,a:chars,a:cWORD) ==# 1
            let l:invalid = 1

        else
            normal! o
            let l:dot_was_found = 1
        endif

    else
        silent! normal! viw
    endif

    if a:cWORD && !l:invalid
        silent! normal! oBo
    endif

    " plus::foo(a + minus::arg(55)).test
    while !l:invalid && !l:finished
        if col('.') !=# col('$')
            let l:next_char = getline('.')[col('.')]
        endif

        " if character to the right is alpha, it's probably identifer of the
        " next element
        if l:next_char =~# '\v[a-zA-Z_]'
            silent! normal! e

            " if character to the right is opening brace, enclose that brace
        elseif l:next_char =~# '\v[\(\{\[\<]'
            let l:a_pos = getpos('.')
            silent! normal! l%

            " it must be a broken brace, abort
            if l:a_pos ==# getpos('.')
                let l:invalid = 1
            endif

        " if the closing braces come at the start, there's a possibility,
        " the statement is inside these braces, e.g. `foo(b|ar()).test`
        " with `|` being the cursor.
        " After the first jump, there's no possibility of this anymore,
        " e.g. foo(foobar.test).test
        elseif l:next_char =~# '\v[\)\}\]\>]'
            if l:dot_was_found && !a:greedy
                let l:finished      = 1

            else
                if l:made_an_assumption ==# 0
                    let l:fall_back_braces = [getpos('v'),getpos('.')]
                endif

                let l:made_an_assumption = 1
                silent! normal! lvv%

                if a:cWORD
                    silent! normal! B

                else
                    silent! normal! b
                endif

                silent! normal! o
            endif

        " dot was found!!1
        elseif l:next_char =~# '\V'.a:chars
            if getline('.')[col('.') + 1] =~# '\v[A-Za-z_\$]'
                if l:dot_was_found && !a:greedy
                    let l:finished      = 1

                else
                    silent! normal! le
                    let l:dot_was_found = 1
                endif

                let l:made_an_assumption = 0

            else
                let l:invalid = 1
            endif

        " found a closing character or at the end of the current line
        else " l:next_char =~# l:invalid_chars || col('.') + 1 ==# col('$')
            if l:dot_was_found
                let l:finished = 1

                if l:made_an_assumption
                    normal! v
                    call setpos('.',l:fall_back_braces[0])
                    normal! v
                    call setpos('.',l:fall_back_braces[1])
                endif

            else
                let l:invalid  = 1
            endif
        endif
    endwhile

    if l:invalid
        normal! v
        call setpos('.',a:cur_pos)
    endif
endfunction

onoremap <silent> qd :<c-u>call <sid>qd_motion(getpos('.'),'.',0,0)<cr>
onoremap <silent> qD :<c-u>call <sid>qd_motion(getpos('.'),'.',0,1)<cr>
onoremap <silent> Qd :<c-u>call <sid>qd_motion(getpos('.'),'.',1,0)<cr>
onoremap <silent> QD :<c-u>call <sid>qd_motion(getpos('.'),'.',1,1)<cr>

vnoremap <silent> qd :<c-u>call <sid>qd_motion(getpos('.'),'.',0,0)<cr>
vnoremap <silent> qD :<c-u>call <sid>qd_motion(getpos('.'),'.',0,1)<cr>
vnoremap <silent> Qd :<c-u>call <sid>qd_motion(getpos('.'),'.',1,0)<cr>
vnoremap <silent> QD :<c-u>call <sid>qd_motion(getpos('.'),'.',1,1)<cr>

function! s:brace_dict_matches(brace_dict)
    if a:brace_dict['(']        ==# a:brace_dict[')'] &&
        \ a:brace_dict['[']     ==# a:brace_dict[']'] &&
        \ a:brace_dict['{']     ==# a:brace_dict['}'] &&
        \ a:brace_dict['<']     ==# a:brace_dict['>'] &&
        \ a:brace_dict['"'] % 2 ==# 0                 &&
        \ a:brace_dict["'"] % 2 ==# 0
        return 1
    endif

    return 0
endfunction

function! s:iq_motion(curpos,open_ch,close_ch,delim,inner)
    let l:finished     = 0

    " these behave special, because of the braces
    let l:brace_dict   = {'(':0,')':0,'{':0,'}':0,'[':0,']':0,
        \ '<':0,'>':0, "'":0,'"':0}
    let l:search_char = a:delim

    silent! execute "normal! va".a:open_ch
    let l:abs_endpos = getpos('.')

    if l:abs_endpos ==# a:curpos
        return 0
    endif

    normal! o
    let l:round = 0

    while !l:finished
        let l:round += 1

        let l:brace_dict['('] = 0
        let l:brace_dict[')'] = 0
        let l:brace_dict['['] = 0
        let l:brace_dict[']'] = 0
        let l:brace_dict['{'] = 0
        let l:brace_dict['}'] = 0
        let l:brace_dict['<'] = 0
        let l:brace_dict['>'] = 0
        let l:brace_dict['"'] = 0
        let l:brace_dict["'"] = 0

        let l:startpos = getpos('.')
        silent! execute "normal! vv"

        let l:found_next_delim = 0
        while !l:found_next_delim
            let l:a_char = getline('.')[col('.')]

            let l:searchpos    = getpos('.')
            let l:searchpos[2] += 1

            if l:searchpos ==# l:abs_endpos
                let l:search_char = a:close_ch
            endif

            if l:a_char ==# l:search_char &&
                        \ s:brace_dict_matches(l:brace_dict)
                let l:found_next_delim = 1

            elseif l:a_char ==# '('
                let l:brace_dict['('] += 1

            elseif l:a_char ==# ')'
                let l:brace_dict[')'] += 1

            elseif l:a_char ==# '['
                let l:brace_dict['['] += 1

            elseif l:a_char ==# ']'
                let l:brace_dict[']'] += 1

            elseif l:a_char ==# '{'
                let l:brace_dict['{'] += 1

            elseif l:a_char ==# '}'
                let l:brace_dict['}'] += 1

            " this needs to work with `->` and all the comparisons in
            " order to be functional
            " elseif l:a_char ==# '<'
            "     let l:brace_dict['<'] += 1
            " elseif l:a_char ==# '>'
            "     let l:brace_dict['>'] += 1
            elseif l:a_char ==# '"'
                let l:brace_dict['"'] += 1

            elseif l:a_char ==# "'"
                let l:brace_dict["'"] += 1
            endif

            execute "normal! 1 "
        endwhile

        let l:endpos = getpos('.')

        if s:check_if_cursor_in_cursors(a:curpos, l:startpos, l:endpos)
            let l:finished = 1
        endif
    endwhile

    if a:inner
        silent! execute "normal! ?\\v[^ \\n\\\\]\<cr>o/\\v[^ \\n\\\\]\<cr>"

    else
        if l:round ==# 1
            silent! execute "normal! o/\\v[^ \\n\\\\]\<cr>o"

        else
            silent! execute "normal! ?\\v[^ \\n\\\\]\<cr>"
        endif
    endif
endfunction

onoremap <silent> iqb :<c-u>call <sid>iq_motion(getpos('.'), '(', ')', ',', 1)<cr>
onoremap <silent> iqB :<c-u>call <sid>iq_motion(getpos('.'), '{', '}', ',', 1)<cr>
onoremap <silent> iqr :<c-u>call <sid>iq_motion(getpos('.'), '[', ']', ',', 1)<cr>
onoremap <silent> iqa :<c-u>call <sid>iq_motion(getpos('.'), '<', '>', ',', 1)<cr>

onoremap <silent> iQb :<c-u>call <sid>iq_motion(getpos('.'), '(', ')', ';', 1)<cr>
onoremap <silent> iQB :<c-u>call <sid>iq_motion(getpos('.'), '{', '}', ';', 1)<cr>
onoremap <silent> iQr :<c-u>call <sid>iq_motion(getpos('.'), '[', ']', ';', 1)<cr>
onoremap <silent> iQa :<c-u>call <sid>iq_motion(getpos('.'), '<', '>', ';', 1)<cr>

onoremap <silent> aqb :<c-u>call <sid>iq_motion(getpos('.'), '(', ')', ',', 0)<cr>
onoremap <silent> aqB :<c-u>call <sid>iq_motion(getpos('.'), '{', '}', ',', 0)<cr>
onoremap <silent> aqr :<c-u>call <sid>iq_motion(getpos('.'), '[', ']', ',', 0)<cr>
onoremap <silent> aqa :<c-u>call <sid>iq_motion(getpos('.'), '<', '>', ',', 0)<cr>

onoremap <silent> aQb :<c-u>call <sid>iq_motion(getpos('.'), '(', ')', ';', 0)<cr>
onoremap <silent> aQB :<c-u>call <sid>iq_motion(getpos('.'), '{', '}', ';', 0)<cr>
onoremap <silent> aQr :<c-u>call <sid>iq_motion(getpos('.'), '[', ']', ';', 0)<cr>
onoremap <silent> aQa :<c-u>call <sid>iq_motion(getpos('.'), '<', '>', ';', 0)<cr>

vnoremap <silent> iqb :<c-u>call <sid>iq_motion(getpos('.'), '(', ')', ',', 1)<cr>
vnoremap <silent> iqB :<c-u>call <sid>iq_motion(getpos('.'), '{', '}', ',', 1)<cr>
vnoremap <silent> iqr :<c-u>call <sid>iq_motion(getpos('.'), '[', ']', ',', 1)<cr>
vnoremap <silent> iqa :<c-u>call <sid>iq_motion(getpos('.'), '<', '>', ',', 1)<cr>

vnoremap <silent> iQb :<c-u>call <sid>iq_motion(getpos('.'), '(', ')', ';', 1)<cr>
vnoremap <silent> iQB :<c-u>call <sid>iq_motion(getpos('.'), '{', '}', ';', 1)<cr>
vnoremap <silent> iQr :<c-u>call <sid>iq_motion(getpos('.'), '[', ']', ';', 1)<cr>
vnoremap <silent> iQa :<c-u>call <sid>iq_motion(getpos('.'), '<', '>', ';', 1)<cr>

vnoremap <silent> aqb :<c-u>call <sid>iq_motion(getpos('.'), '(', ')', ',', 0)<cr>
vnoremap <silent> aqB :<c-u>call <sid>iq_motion(getpos('.'), '{', '}', ',', 0)<cr>
vnoremap <silent> aqr :<c-u>call <sid>iq_motion(getpos('.'), '[', ']', ',',0)<cr>
vnoremap <silent> aqa :<c-u>call <sid>iq_motion(getpos('.'), '<', '>', ',',0)<cr>

vnoremap <silent> aQb :<c-u>call <sid>iq_motion(getpos('.'), '(', ')', ';',0)<cr>
vnoremap <silent> aQB :<c-u>call <sid>iq_motion(getpos('.'), '{', '}', ';',0)<cr>
vnoremap <silent> aQr :<c-u>call <sid>iq_motion(getpos('.'), '[', ']', ';',0)<cr>
vnoremap <silent> aQa :<c-u>call <sid>iq_motion(getpos('.'), '<', '>', ';',0)<cr>
