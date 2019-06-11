# motion-sickness.vim ![Build Status](https://travis-ci.org/hgiesel/vim-motion-sickness.svg?branch=master) ![Build Status](https://travis-ci.org/hgiesel/vim-motion-sickness.svg?branch=devel)

This plugin adds a slew of new possible text objects. [Vader](https://github.com/junegunn/vader.vim)
ensures they all work as intended.

Each type of text object can be disabled with `let g:sick_{type}_enabled = 0`, e.g. `let g:sick_symbol_enabled = 0`.

#### List of text objects

* **bracket text objects**:
  * [alias text objects](#alias-text-objects)
  * [expression text objects](#expression-text-objects)
  * [field text objects](#field-text-objects)

* **other text objects**:
  * [indent text objects](#indent-text-objects)
  * [line text objects](#line-text-objects)
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

**Expression text objects** have the structure "{`i`,`a`}`e`{`b`/`(`/`)`,`B`/`{`/`}`,`r`/`[`/`]`,`a`/`<`/`>`}".

An *inner expression* selects the whole bracket (like "`a<bracket>`") preceded by a WORD.
While going back a word, `motion-sickness` is smart about not going beyond opening brackets, etc. 

An *all expression* selects the whole bracket (like "`a<bracket>`") preceded by anything.
The same restrictions that apply to *inner expressions* apply here too.

The variable `g:sick_expression_maps` can be set use an alternative set of mappings.
Utilizing the fact, that `ib`, `i(`, `i)` are [the same](#alias-text-objects), you can set
them to the shorter version. Just put either of the following into your vimrc.

```vim
let g:sick_expression_maps = 'opendelim'  " uses {i,a}{(,{,[,<} for expression text objects
let g:sick_expression_maps = 'closedelim' " uses {i,a}{),},],>} for expression text objects
let g:sick_expression_maps = 'char'       " uses {i,a}{b,B,r,a} for expression text objects
```

## Field text objects

* inspired by [vim-textobj-argument](https://github.com/gaving/vim-textobj-argument)

**Field text objects** have the structure "{`i`,`a`}`f`{`b`/`(`/`)`,`B`/`{`/`}`,`r`/`[`/`]`,`a`/`<`/`>`}".

An *inner field* selects the current field, enclosed in the specific brace. Think of
arguments in function, list elements, dictionary entries, etc.

An *all field* selects an inner field, together with the field delimiter (usually a comma)

The variable `g:sick_expression_maps` can be set use an alternative set of mappings.
Utilizing the fact, that `ib`, `i(`, `i)` are [the same](#alias-text-objects), you can set
them to the shorter version. Just put either of the following into your vimrc.

```vim
let g:sick_field_maps = 'opendelim'  " uses {i,a}{(,{,[,<} for field motions
let g:sick_field_maps = 'closedelim' " uses {i,a}{),},],>} for field motions
let g:sick_field_maps = 'char'       " uses {i,a}{b,B,r,a} for field motions
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

| text object | effect                                        |
|-------------|-----------------------------------------------|
| `iip`/`aip` | Similar to `ip`/`ap`, except it does not exceed the current indentation level. Does not accept counts. Mnemonic is "inner/all indentation paragraph"|
| `iil`/`ail` | Selects the entire current indentation level excluding / including leading and trailing empty lines. Does not accept counts. Mnemonic is "inner/all indentation level".|
| `iib`/`aib` | Like `ail` and it selects one line of lower indent before and after the section. Does accept counts. Mnemonic is "inner/all indentation block". |
| `iit`/`ait` | Like `ail` and it selects one line of lower indent before the section. Does accept counts. Mnemonic is "inner/all indentation top". |

![Indent text objects cast](https://media.giphy.com/media/hSEh6Plw8e40MhPf2e/giphy.gif)

In a text like like the following, if you execute `iil` on any line within the
function definition, the line featuring `argument3` will not be selected, but will
be detected as probably belonging to the preceding line. This behavior is governed by
the `g:sick_indent_exclude_leading_indents` variable.

```c
int my_function(int argument1, int argument2,
                int argument3) { // <- will not be included in `iil` or `ail` text
                // object if you set g:sick_indent_exclude_leading_indents to 0
    line1();
    line2();
    line3();
    ...
    lineN();
}
```

## Line text objects

* inspired by [vim-textobj-line](https://github.com/kana/vim-textobj-line)

| text object  | effect                             |
|--------------|------------------------------------|
| `il`/`al`    | Select the current line including / excluding leading/trailing blank characters. Does not accept a count. |

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
