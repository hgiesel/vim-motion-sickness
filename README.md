# motion-sickness.vim ![Build Status](https://travis-ci.org/hgiesel/vim-motion-sickness.svg?branch=master) ![Build Status](https://travis-ci.org/hgiesel/vim-motion-sickness.svg?branch=devel)

This plugin adds a slew of new possible text objects.

## List of text object

### Alias motions

* inspired by [Tim Pope's vim-surround](https://github.com/tpope/vim-surround)

| text object  | effect                |
|--------------|-----------------------|
| `ir`/`ar`    | aliases for `i[`/`a[` |
| `ia`/`aa`    | aliases for `i<`/`a<` |

### Symbol motions

| text object  | effect                             |
|--------------|------------------------------------|
| `i*`/`a*`    | similar to `i"`/`a"`, but for `*`  |
| `i_`/`a_`    | similar to `i"`/`a"`, but for `_`  |
| `i-`/`a-`    | similar to `i"`/`a"`, but for `-`  |
| `i:`/`a:`    | similar to `i"`/`a"`, but for `:`  |
| `i@`/`a@`    | similar to `i"`/`a"`, but for `@`  |
| `i!`/`a!`    | similar to `i"`/`a"`, but for `!`  |
| `i?`/`a?`    | similar to `i"`/`a"`, but for `?`  |
| `i/`/`a/`    | similar to `i"`/`a"`, but for `/`  |
| `i%`/`a%`    | similar to `i"`/`a"`, but for `%`  |
| `i\|`/`a\|`  | similar to `i"`/`a"`, but for `\|` |

### Indent motions

* inspired by [vim-indent-object](https://github.com/michaeljsmith/vim-indent-object)

| text object | effect                |
|-------------|-----------------------|
| `ii`        | select current indent level and above |
| `ai`        | select current indent level and above, and first line of one indent level below |
| `iI`        | select current indent leven and above going beyond empty lines |
| `aI`        | select current indent level and above, and first line of one indent level below going beyond empty lines |

### Q motions

| text object | effect                |
|-------------|-----------------------|
| `qb`        | select parentheses preceded by a word     |
| `Qb`        | select parentheses preceded by a WORD     |
| `qB`        | select braces preceded by a word          |
| `QB`        | select braces preceded by a WORD          |
| `qr`        | select square brackets preceded by a word |
| `Qr`        | select square brackets preceded by a WORD |
| `qa`        | select angle brackets preceded by a word  |
| `Qa`        | select angle brackets preceded by a WORD  |

### IQ motions

| text object | effect                |
|-------------|-----------------------|
| `iqb`       | select argument within parentheses                |
| `aqb`       | select argument within parentheses with comma     |
| `iqB`       | select argument within braces                     |
| `aqB`       | select argument within braces with comma          |
| `iqr`       | select argument within square brackets            |
| `aqr`       | select argument within square brackets with comma |
| `iqa`       | select argument within angle brackets (requires `set matchpairs+=<:>` to work) |
| `aqa`       | select argument within angle brackets with comma (requires `set matchpairs+=<:>` to work) |

> ### Segment motions
> ### Pair motions

## TODO

* at the moment, none of the motions accept counts
