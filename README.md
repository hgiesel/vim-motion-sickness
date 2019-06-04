# motion-sickness.vim ![Build Status](https://travis-ci.org/hgiesel/vim-motion-sickness.svg?branch=master) ![Build Status](https://travis-ci.org/hgiesel/vim-motion-sickness.svg?branch=devel)

This plugin adds a slew of new possible text objects. [Vader](https://github.com/junegunn/vader.vim)
ensures they all work as intended.

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

* inspired by [vim-textobj-functioncall](https://github.com/machakann/vim-textobj-functioncall)

| text object | effect                |
|-------------|-----------------------|
| `qb`        | select parentheses preceded by a word     |
| `qB`        | select braces preceded by a word          |
| `qr`        | select square brackets preceded by a word |
| `qa`        | select angle brackets preceded by a word  |
| `Qb`        | select parentheses preceded by a WORD     |
| `QB`        | select braces preceded by a WORD          |
| `Qr`        | select square brackets preceded by a WORD |
| `Qa`        | select angle brackets preceded by a WORD  |

### IQ motions

* inspired by [vim-textobj-argument](https://github.com/gaving/vim-textobj-argument)

| text object | effect                |
|-------------|-----------------------|
| `iqb`       | select comma-separated argument within parentheses                |
| `aqb`       | select comma-separated argument within parentheses with comma     |
| `iqB`       | select comma-separated argument within braces                     |
| `aqB`       | select comma-separated argument within braces with comma          |
| `iqr`       | select comma-separated argument within square brackets            |
| `aqr`       | select comma-separated argument within square brackets with comma |
| `iqa`       | select comma-separated argument within angle brackets (requires `set matchpairs+=<:>` to work) |
| `aqa`       | select comma-separated argument within angle brackets with comma (requires `set matchpairs+=<:>` to work) |
| `iQb`       | select semicolon-separated argument within parentheses                |
| `aQb`       | select semicolon-separated argument within parentheses with semicolon     |
| `iQB`       | select semicolon-separated argument within braces                     |
| `aQB`       | select semicolon-separated argument within braces with semicolon          |
| `iQr`       | select semicolon-separated argument within square brackets            |
| `aQr`       | select semicolon-separated argument within square brackets with semicolon |
| `iQa`       | select semicolon-separated argument within angle brackets (requires `set matchpairs+=<:>` to work) |
| `aQa`       | select semicolon-separated argument within angle brackets with semicolon (requires `set matchpairs+=<:>` to work) |

> ### Segment motions
> ### Pair motions

## TODO

* at the moment, none of the motions accept counts
