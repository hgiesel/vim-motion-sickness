# motion-sickness.vim ![Build Status](https://travis-ci.org/hgiesel/vim-motion-sickness.svg?branch=master) ![Build Status](https://travis-ci.org/hgiesel/vim-motion-sickness.svg?branch=devel)

This plugin adds a slew of new possible text objects. [Vader](https://github.com/junegunn/vader.vim)
ensures they all work as intended.

#### List of text objects

* **bracket motions**:
  * [alias motions](#alias-motions)
  * [expression motions](#expression-motions)
  * [field motions](#field-motions)

* **other motions**:
  * [indent motions](#indent-motions)
  * [line motions](#line-motions)
  * [symbol motions](#symbol-motions)

## Alias motions

* inspired by [Tim Pope's vim-surround](https://github.com/tpope/vim-surround)

| text object  | effect                |
|--------------|-----------------------|
| `ir`/`ar`    | aliases for `i[`/`a[` |
| `ia`/`aa`    | aliases for `i<`/`a<` |

* with these added, you have three full sets of motions for the common brackets:

|              |  parentheses | braces    | square brackets | angle brackets |
|--------------|--------------|-----------|-----------------|----------------|
| *char*       | `ib`/`ab`    | `iB`/`aB` | `ir`/`ar`       | `ia`/`aa`      |
| *opendelim*  | `i(`/`a(`    | `i{`/`a{` | `i[`/`a[`       | `i<`/`a<`      |
| *closedelim* | `i)`/`a)`    | `i}`/`a}` | `i]`/`a]`       | `i>`/`a>`      |

* these motions are exactly equal in functionality
  * this fact is important for the upcoming [expression motions](#expression-motions) and [field motions](#field-motions)

## Expression motions

* inspired by [vim-textobj-functioncall](https://github.com/machakann/vim-textobj-functioncall)

**Expression motions** have the structure "{`i`,`a`}`e`{`b`/`(`/`)`,`B`/`{`/`}`,`r`/`[`/`]`,`a`/`<`/`>`}".

An *inner expression* selects the whole bracket ("`a`{`b`,`B`,`r`,`a`}") preceded by a WORD.
While going back a word, `motion-sickness` is smart about not going beyond opening brackets, etc. 

An *all expression* selects the whole bracket ("`a`{`b`,`B`,`r`,`a`}") preceded by anything.
The same restrictions that apply to *inner expressions* apply here too.

The variable `g:sick_expression_maps` can be set use an alternative set of mappings.
Utilizing the fact, that `ib`, `i(`, `i)` are [the same](#alias-motions), you can set
them to the shorter version. Just put this into your vimrc.

```vim
let g:sick_expression_maps = 'opendelim'  " uses {i,a}{(,{,[,<} for expression motions
let g:sick_expression_maps = 'closedelim' " uses {i,a}{),},],>} for expression motions
let g:sick_expression_maps = 'char'       " uses {i,a}{b,B,r,a} for expression motions
```

## Field motions

* inspired by [vim-textobj-argument](https://github.com/gaving/vim-textobj-argument)

**Field motions** have the structure "{`i`,`a`}`f`{`b`/`(`/`)`,`B`/`{`/`}`,`r`/`[`/`]`,`a`/`<`/`>`}".

An *inner field* selects the current field, enclosed in the specific brace. Think of
arguments in function, list elements, dictionary entries, etc.

An *all field* selects an inner field, together with the field delimiter (usually a comma)

The variable `g:sick_expression_maps` can be set use an alternative set of mappings.
Utilizing the fact, that `ib`, `i(`, `i)` are [the same](#alias-motions), you can set
them to the shorter version. Just put this into your vimrc.

```vim
let g:sick_field_maps = 'opendelim'  " uses {i,a}{(,{,[,<} for expression motions
let g:sick_field_maps = 'closedelim' " uses {i,a}{),},],>} for expression motions
let g:sick_field_maps = 'char'       " uses {i,a}{b,B,r,a} for expression motions
```

4 types of list styles are supported.
In other words, these are basis for the unit tests, and for the algorithm governing
these motions.

#### short style

```c
foo(arg1, arg2, arg3)
```

#### delimiter-indented style

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

The following gif showcases some examples of expression and field motions:

![expression motions cast](https://media.giphy.com/media/dApCdA2gycwomwrIGO/giphy.gif)

## Indent motions


* inspired by [vim-indent-object](https://github.com/michaeljsmith/vim-indent-object)

| text object | effect                                        |
|-------------|-----------------------------------------------|
| `iip`/`aip` | similar to `ip`/`ap`, except it does not exceed the current indentation level |
| `iil`/`ail` | selects the entire current indentation level excluding / including leading and trailing empty lines |
| `iib`/`aib` | like `ail` and it selects one line of lower indent before and after the section |
| `iit`/`ait` | like `ail` and it selects one line of lower indent before the section |

![Indent motions cast](https://media.giphy.com/media/hSEh6Plw8e40MhPf2e/giphy.gif)

## Line motions

* inspired by [vim-textobj-line](https://github.com/kana/vim-textobj-line)

| text object  | effect                             |
|--------------|------------------------------------|
| `il`/`al`    | select the current line including / excluding leading/trailing blank characters |

## Symbol motions

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

> ## Segment motions
> ## Pair motions
