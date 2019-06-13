let g:sickness#bracket#default_maps =
      \ [ ['parenthesis', 'b', '(', ')']
      \ , ['brace'      , 'B', '{', '}']
      \ , ['bracket'    , 'r', '[', ']']
      \ , ['chevron'    , 'a', '<', '>']
      \ ]

let g:sickness#bracket#maps = get(g:, 'sick_matchtriples', g:sickness#bracket#default_maps)
