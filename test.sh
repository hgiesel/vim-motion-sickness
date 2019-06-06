#!/usr/bin/env bash

if [[ "$1" ]]; then
  TARGET=1
fi

tests_alias=(
  'test/bracket/alias-spec.vader'
)

tests_field=(
  'test/bracket/field-short-if-spec.vader'
  'test/bracket/field-short-af-spec.vader'
  'test/bracket/field-trailing-if-spec.vader'
  'test/bracket/field-trailing-af-spec.vader'
  'test/bracket/field-indented-if-spec.vader'
  'test/bracket/field-indented-af-spec.vader'
  'test/bracket/field-leading-if-spec.vader'
  'test/bracket/field-leading-af-spec.vader'
)

tests_expression=(
  'test/bracket/expression-general-spec.vader'
  'test/bracket/expression-whitespace-spec.vader'
  'test/bracket/expression-nested-spec.vader'
  'test/bracket/expression-multiline-trailing-spec.vader'
  'test/bracket/expression-multiline-leading-spec.vader'
  'test/bracket/expression-multiline-indented-spec.vader'
)

tests_other=(
  'test/other/indent-spec.vader'
  'test/other/symbol-spec.vader'
)

TESTS_TO_EXECUTE="tests_$TARGET"

for test_name in “${!TESTS_TO_EXECUTE}”; do
  nvim -Es -u 'test/vimrc-test.vim' -c "Vader! $test_name"
done
