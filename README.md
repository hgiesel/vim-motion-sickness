# motion-sickness.vim ![Build Status](https://travis-ci.org/hgiesel/vim-motion-sickness.svg?branch=master)

This plugin adds a slew of new possible text objects.

## List of text object

### Alias motions

* inspired by [Tim Pope's vim-surround](https://github.com/tpope/vim-surround)

| text object  | effect                |
|--------------|-----------------------|
| `ir`/`ar`    | aliases for `i[`/`a[` |
| `ia`/`aa`    | aliases for `i<`/`a<` |

### Symbol motions

| text object  | effect                            |
|--------------|-----------------------------------|
| `i*`/`a*`    | similar to `i"`/`a"`, but for `*` |
| `i_`/`a_`    | similar to `i"`/`a"`, but for `_` |
| `i-`/`a-`    | similar to `i"`/`a"`, but for `-` |
| `i:`/`a:`    | similar to `i"`/`a"`, but for `:` |
| `i@`/`a@`    | similar to `i"`/`a"`, but for `@` |
| `i!`/`a!`    | similar to `i"`/`a"`, but for `!` |
| `i?`/`a?`    | similar to `i"`/`a"`, but for `?` |
| `i/`/`a/`    | similar to `i"`/`a"`, but for `/` |
| `i%`/`a%`    | similar to `i"`/`a"`, but for `%` |
| `i|`/`a|`    | similar to `i"`/`a"`, but for `|` |

### Indent motions

* inspired by [vim-indent-object](https://github.com/michaeljsmith/vim-indent-object)

| text object | effect                |
|-------------|-----------------------|
| `ii`        | select current indent level and above |
| `ai`        | select current indent level and above, and first line of one indent level below |
| `iI`        | select current indent leven and above going beyond empty lines |
| `aI`        | select current indent level and above, and first line of one indent level below going beyond empty lines |

### Q motions

### IQ motions

> ### Segment motions
> ### Pair motions
