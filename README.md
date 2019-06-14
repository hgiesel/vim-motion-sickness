# motion-sickness.nvim ![Build Status](https://travis-ci.org/hgiesel/vim-motion-sickness.svg?branch=master) ![Build Status](https://travis-ci.org/hgiesel/vim-motion-sickness.svg?branch=devel)

This plugin adds a slew of new possible text objects. [Vader](https://github.com/junegunn/vader.vim)
ensures they all work as intended. Only Neovim is supported at the moment.

Each type of text object can be disabled with `let g:sickness#{type}_enabled = 0`, e.g.:

```vim
let g:sickness#symbol#enabled = 0
let g:sickness#view#enabled = 0
```

If you only want the `<plug>` metakeys and want to define the mappings yourself, set
`let g:sickness#{type}#use_default_maps = 0`, e.g.:

```vim
let g:sickness#symbol#use_default_maps = 0
let g:sickness#view#use_default_maps = 0
```

#### List of text objects

* **bracket text objects**:
  * [alias text objects](#alias-text-objects)
  * [expression text objects](#expression-text-objects)
  * [field text objects](#field-text-objects)

* **other text objects**:
  * [indentation text objects](#indent-text-objects)
  * [line text objects](#line-text-objects)
  * [view text objects](#view-text-objects)
  * [symbol text objects](#symbol-text-objects)

## Alias text objects

* inspired by [Tim Pope's vim-surround](https://github.com/tpope/vim-surround)

| text object  | effect                |
|--------------|-----------------------|
| `ir`/`ar`    | Aliases for `i[`/`a[` |
| `ia`/`aa`    | Aliases for `i<`/`a<` |

* with these added, you have three full sets of text objects for the common brackets:

|              |  parentheses | braces    | square brackets | angle brackets |
|--------------|--------------|-----------|-----------------|----------------|
| *char*       | `ib`/`ab`    | `iB`/`aB` | `ir`/`ar`       | `ia`/`aa`      |
| *opendelim*  | `i(`/`a(`    | `i{`/`a{` | `i[`/`a[`       | `i<`/`a<`      |
| *closedelim* | `i)`/`a)`    | `i}`/`a}` | `i]`/`a]`       | `i>`/`a>`      |

* these text objects are exactly equal in functionality
  * this fact is important for the upcoming [expression text objects](#expression-text-objects) and [field text objects](#field-text-objects)

## Expression text objects

* inspired by [vim-textobj-functioncall](https://github.com/machakann/vim-textobj-functioncall)

Expression text objects are a generalization of *function calls*, *function definitions*, *arrays*, *C++ templates*, and more.
The general expression of an expression text object is `[text][opendelim][text][closedelim]`.
All of the following follow this criteria:

```c
function_call(argument1, argument2, argument3)
let dict = { "key1": value1, "key2", value2 }
let a = ["hello", "world"]
Array<int> val = new Array<int>
```

**Expression text objects** have the structure "{`[ia]`}`e`{`[b()]`/`[B{}]`/`[r[\]]`/`[a<>]`}".

`ie*` selects the whole bracket (like "`a<bracket>`") preceded by `[count]` [words](https://stackoverflow.com/questions/22931032/vim-word-vs-word).

`ae*` selects the whole bracket (like "`a<bracket>`") preceded by `[count]` [WORDs](https://stackoverflow.com/questions/22931032/vim-word-vs-word).
However, if you don't supply a count, it will not default to "1 WORD" but rather it
will jump to the start of the line.

With both `ie*` and `ae*`, `motion-sickness` will be smart not to include partial brackets, etc.

The variable `g:sickness#expression#preferred_shortcut_map` can be set use an alternative set of mappings.
Utilizing the fact, that `ib`, `i(`, `i)` are [the same](#alias-text-objects), you can set
them to the shorter version. Just put either of the following into your vimrc.

```vim
let g:sickness#expression#preferred_shortcut_map = 'opendelim'  " uses {i,a}{(,{,[,<} for expression text objects
let g:sickness#expression#preferred_shortcut_map = 'closedelim' " uses {i,a}{),},],>} for expression text objects
let g:sickness#expression#preferred_shortcut_map = 'char'       " uses {i,a}{b,B,r,a} for expression text objects

" or if you want to set your own mappings
let g:sickness#expression#use_default_maps = 0

omap ieb <plug>(textobj-sickness-expression-parenthesis-i)
xmap ieb <plug>(textobj-sickness-expression-parenthesis-i)
omap aeb <plug>(textobj-sickness-expression-parenthesis-a)
xmap aeb <plug>(textobj-sickness-expression-parenthesis-a)

omap ieB <plug>(textobj-sickness-expression-brace-i)
xmap ieB <plug>(textobj-sickness-expression-brace-i)
omap aeB <plug>(textobj-sickness-expression-brace-a)
xmap aeB <plug>(textobj-sickness-expression-brace-a)

omap ier <plug>(textobj-sickness-expression-bracket-i)
xmap ier <plug>(textobj-sickness-expression-bracket-i)
omap aer <plug>(textobj-sickness-expression-bracket-a)
xmap aer <plug>(textobj-sickness-expression-bracket-a)

omap iea <plug>(textobj-sickness-expression-chevron-i)
xmap iea <plug>(textobj-sickness-expression-chevron-i)
omap aea <plug>(textobj-sickness-expression-chevron-a)
xmap aea <plug>(textobj-sickness-expression-chevron-a)
```

## Field text objects

* inspired by [vim-textobj-argument](https://github.com/gaving/vim-textobj-argument)

**Field text objects** have the structure "{`i`,`a`}`f`{`b`/`(`/`)`,`B`/`{`/`}`,`r`/`[`/`]`,`a`/`<`/`>`}".

An *inner field* selects the current field, enclosed in the specific brace. Think of
arguments in function, list elements, dictionary entries, etc.

An *all field* selects an inner field, together with the field delimiter (usually a comma)

The variable `g:sickness#expression#maps` can be set use an alternative set of mappings.
Utilizing the fact, that `ib`, `i(`, `i)` are [the same](#alias-text-objects), you can set
them to the shorter version. Just put either of the following into your vimrc.

```vim
let g:sickness#field#preferred_shortcut_map = 'opendelim'  " uses {i,a}{(,{,[,<} for field motions
let g:sickness#field#preferred_shortcut_map = 'closedelim' " uses {i,a}{),},],>} for field motions
let g:sickness#field#preferred_shortcut_map = 'char'       " uses {i,a}{b,B,r,a} for field motions

" or if you want to set it entirely yourself
let g:sickness#field#use_default_maps = 0

omap ifb <plug>(textobj-sickness-field-parenthesis-i)
vmap ifb <plug>(textobj-sickness-field-parenthesis-i)
omap afb <plug>(textobj-sickness-field-parenthesis-a)
vmap afb <plug>(textobj-sickness-field-parenthesis-a)

omap ifB <plug>(textobj-sickness-field-brace-i)
vmap ifB <plug>(textobj-sickness-field-brace-i)
omap afB <plug>(textobj-sickness-field-brace-a)
vmap afB <plug>(textobj-sickness-field-brace-a)

omap ifr <plug>(textobj-sickness-field-bracket-i)
vmap ifr <plug>(textobj-sickness-field-bracket-i)
omap afr <plug>(textobj-sickness-field-bracket-a)
vmap afr <plug>(textobj-sickness-field-bracket-a)

omap ifa <plug>(textobj-sickness-field-chevron-i)
vmap ifa <plug>(textobj-sickness-field-chevron-i)
omap afa <plug>(textobj-sickness-field-chevron-a)
vmap afa <plug>(textobj-sickness-field-chevron-a)
```

4 types of list styles are supported.
In other words, these are basis for the unit tests, and for the algorithm governing
these text objects.

#### short style

```c
foo(arg1, arg2, arg3)
```

#### opening delimiter-indented style

```c
foo_function(arg1, arg2,
             arg3, another_arg)
```

#### trailing-symbol style

```c
foo_function(
    arg1,
    arg2,
    arg3
)
```

#### leading-symbol style

```c
Foo ( arg1
    , arg2
    , arg2
    , arg3
    )
```

The following gif showcases some examples of expression and field text objects:

![expression text objects cast](https://media.giphy.com/media/dApCdA2gycwomwrIGO/giphy.gif)

## Indent text objects

* inspired by [vim-indent-object](https://github.com/michaeljsmith/vim-indent-object)

These text objects are meant to support the `ip` and `ap` text objects for selecting
paragraphs. `ip` and `ap` simply disregard indentation.

| text object  | effect                                        |
|--------------|-----------------------------------------------|
| `iip`/`aip`  | Similar to `ip`/`ap`, except it does not exceed the current indentation level. Does accept counts. Mnemonic is "inner/all indentation paragraph"|
| `iil`/`ail`  | Selects the entire current indentation level excluding / including leading and trailing empty lines. Does not accept counts. Mnemonic is "inner/all indentation level".|
| `iib`/`aib`  | Like `ail` and it selects one line of lower indent before and after the section. Does accept counts. Mnemonic is "inner/all indentation block". |
| `iit`/`ait`  | Like `ail` and it selects one line of lower indent before the section. Does accept counts. Mnemonic is "inner/all indentation top". |

![Indent text objects cast](https://media.giphy.com/media/hSEh6Plw8e40MhPf2e/giphy.gif)

In a text like like the following, if you execute `iil` on any line within the
function definition, the line featuring `argument3` will not be selected, but will
be detected as probably belonging to the preceding line. This behavior is governed by
the `g:sickness#indentation#exclude_leading_indents` variable.

```c
int my_function(int argument1, int argument2,
                int argument3) { // <- will not be included in `iil` or `ail` text object
                                 // if you set g:sickness#indentation#excluse_leading_indents to 0
    line1();
    line2();
    line3();
    ...
    lineN();
}
```

If you wish to set the indent mappings yourself, you can do so:

```vim
let g:sickness#indentation#use_default_maps = 0

omap iip <plug>(textobj-sickness-indentation-paragraph-i)
vmap iip <plug>(textobj-sickness-indentation-paragraph-i)
omap aip <plug>(textobj-sickness-indentation-paragraph-a)
vmap aip <plug>(textobj-sickness-indentation-paragraph-a)

omap iil <plug>(textobj-sickness-indentation-level-i)
vmap iil <plug>(textobj-sickness-indentation-level-i)
omap ail <plug>(textobj-sickness-indentation-level-a)
vmap ail <plug>(textobj-sickness-indentation-level-a)

omap iib <plug>(textobj-sickness-indentation-block-i)
vmap iib <plug>(textobj-sickness-indentation-block-i)
omap aib <plug>(textobj-sickness-indentation-block-a)
vmap aib <plug>(textobj-sickness-indentation-block-a)

omap iit <plug>(textobj-sickness-indentation-top-i)
vmap iit <plug>(textobj-sickness-indentation-top-i)
omap ait <plug>(textobj-sickness-indentation-top-a)
vmap ait <plug>(textobj-sickness-indentation-top-a)
```

## Line text objects

* inspired by [vim-textobj-line](https://github.com/kana/vim-textobj-line)

| text object  | effect                             |
|--------------|------------------------------------|
| `il`         | Select the current line excluding leading/trailing blank characters. From `^` to `g_`. Does not accept a count. |
| `al`         | Select the current line including leading/trailing blank characters. From `0` to `$`. Does not accept a count. |

If you wish to set the mappings yourself, you can do so:

```vim
let g:sickness#line#use_default_maps = 0

omap il <plug>(textobj-sickness-line-i)
xmap il <plug>(textobj-sickness-line-i)
omap al <plug>(textobj-sickness-line-a)
xmap al <plug>(textobj-sickness-line-a)
```

## View text objects

| text object  | effect                             |
|--------------|------------------------------------|
| `iv`         | Selects the currently visible window (from `H` to `L`). Does not accept a count |
| `av`         | Selects the entire buffer (from `gg` to `G`). Does not accept a count. |

If you wish to set the mappings yourself, you can do so:

```vim
let g:sickness#view#use_default_maps = 0

omap iv <plug>(textobj-sickness-view-i)
xmap iv <plug>(textobj-sickness-view-i)
omap av <plug>(textobj-sickness-view-a)
xmap av <plug>(textobj-sickness-view-a)
```

## Symbol text objects

| text object  | effect                             |
|--------------|------------------------------------|
| `i*`/`a*`    | Similar to `i"`/`a"`, but for `*`  |
| `i_`/`a_`    | Similar to `i"`/`a"`, but for `_`  |
| `i-`/`a-`    | Similar to `i"`/`a"`, but for `-`  |
| `i:`/`a:`    | Similar to `i"`/`a"`, but for `:`  |
| `i@`/`a@`    | Similar to `i"`/`a"`, but for `@`  |
| `i!`/`a!`    | Similar to `i"`/`a"`, but for `!`  |
| `i?`/`a?`    | Similar to `i"`/`a"`, but for `?`  |
| `i/`/`a/`    | Similar to `i"`/`a"`, but for `/`  |
| `i%`/`a%`    | Similar to `i"`/`a"`, but for `%`  |
| `i\|`/`a\|`  | Similar to `i"`/`a"`, but for `\|` |
