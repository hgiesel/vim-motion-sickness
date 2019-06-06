#!/usr/bin/env bash

if [[ "$1" ]]; then
  TARGET=1
else
  if [[ ! "$TARGET" ]]; then
    TARGET='*'
  fi
fi


declare test_name="tests/${TARGET}-spec.vader"

nvim -Es -u 'tests/vimrc-test.vim' -c "Vader! ${test_name}"
