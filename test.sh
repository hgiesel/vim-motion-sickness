#!/usr/bin/env bash

if [[ "$1" ]]; then
  TARGET="$1"
else
  if [[ ! "$TARGET" ]]; then
    TARGET='*'
  fi
fi

if [[ "$TARGET" == 'try' ]]; then
  exec nvim -u 'tests/vimrc-test.vim' <<FOO
prevline(foo, bar,
         xyz, inner5), g(hello, world)

foo ( inner1
    , inner2
    , inner3
    )

foo (
  inner1,
  inner2,
  inner3
)

nextline();
FOO
fi

declare test_name="tests/${TARGET}*-spec.vader"

if [[ "$TARGET" == '*' ]]; then
  nvim -Es -u 'tests/vimrc-test.vim' -c "Vader! ${test_name}" 2>&1 | egrep '^.*(Starting|Success).*$' | awk '1 ; (NR==1) || (NR>1 && NR%2==1) {printf"\n"}'

else
  nvim -Es -u 'tests/vimrc-test.vim' -c "Vader! ${test_name}" 2>&1
fi
