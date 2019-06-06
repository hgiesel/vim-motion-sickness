#!/usr/bin/env bash

if [[ "$1" ]]; then
  TARGET=1
else
  if [[ ! "$TARGET" ]]; then
    TARGET='*'
  fi
fi

nvim -Es -u 'test/vimrc-test.vim' -c "Vader! test/${test_name}-spec.vader"
