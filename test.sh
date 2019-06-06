#!/usr/bin/env bash

echo "$TARGET"

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

for test_name in “${!TESTS_TO_EXECUTE}”
  TESTS_TO_EXECUTE=TESTS_PART_$1[@]
do
  ./ui_test_run_script "$test_name.feature"
done

# nvim -Es -u 'test/vimrc-test.vim' -c 'Vader! test/bracket/alias-spec.vader'

# nvim -Es -u 'test/vimrc-test.vim' -c 'Vader! test/bracket/expression-general-spec.vader'
# nvim -Es -u 'test/vimrc-test.vim' -c 'Vader! test/bracket/expression-whitespace-spec.vader'
# nvim -Es -u 'test/vimrc-test.vim' -c 'Vader! test/bracket/expression-nested-spec.vader'
# nvim -Es -u 'test/vimrc-test.vim' -c 'Vader! test/bracket/expression-multiline-trailing-spec.vader'
# nvim -Es -u 'test/vimrc-test.vim' -c 'Vader! test/bracket/expression-multiline-leading-spec.vader'
# nvim -Es -u 'test/vimrc-test.vim' -c 'Vader! test/bracket/expression-multiline-indented-spec.vader'

# nvim -Es -u 'test/vimrc-test.vim' -c 'Vader! test/bracket/field-short-if-spec.vader'
# nvim -Es -u 'test/vimrc-test.vim' -c 'Vader! test/bracket/field-short-af-spec.vader'
# nvim -Es -u 'test/vimrc-test.vim' -c 'Vader! test/bracket/field-trailing-if-spec.vader'
# nvim -Es -u 'test/vimrc-test.vim' -c 'Vader! test/bracket/field-trailing-af-spec.vader'
# nvim -Es -u 'test/vimrc-test.vim' -c 'Vader! test/bracket/field-indented-if-spec.vader'
# nvim -Es -u 'test/vimrc-test.vim' -c 'Vader! test/bracket/field-indented-af-spec.vader'
# nvim -Es -u 'test/vimrc-test.vim' -c 'Vader! test/bracket/field-leading-if-spec.vader'
# nvim -Es -u 'test/vimrc-test.vim' -c 'Vader! test/bracket/field-leading-af-spec.vader'

# nvim -Es -u 'test/vimrc-test.vim' -c 'Vader! test/other/indent-spec.vader'
# nvim -Es -u 'test/vimrc-test.vim' -c 'Vader! test/other/symbol-spec.vader'
