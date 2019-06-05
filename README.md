# motion-sickness.vim ![Build Status](https://travis-ci.org/hgiesel/vim-motion-sickness.svg?branch=master) ![Build Status](https://travis-ci.org/hgiesel/vim-motion-sickness.svg?branch=devel)

This plugin adds a slew of new possible text objects. [Vader](https://github.com/junegunn/vader.vim)
ensures they all work as intended.

#### List of text objects

* alias motions
* expression motions
* field motions

* indent motions
* symbol motions

## Alias motions

* inspired by [Tim Pope's vim-surround](https://github.com/tpope/vim-surround)

| text object  | effect                |
|--------------|-----------------------|
| `ir`/`ar`    | aliases for `i[`/`a[` |
| `ia`/`aa`    | aliases for `i<`/`a<` |

## Expression motions

* inspired by [vim-textobj-functioncall](https://github.com/machakann/vim-textobj-functioncall)

| text object | effect                                        |
|-------------|-----------------------------------------------|
| `ieb`        | parentheses preceded by a WORD         |
| `ieB`        | braces preceded by a WORD              |
| `ier`        | square brackets preceded by a WORD     |
| `iea`        | angle brackets preceded by a WORD      |

| `aeb`        | parentheses preceded by anything     |
| `aeB`        | braces preceded by anything          |
| `aer`        | square brackets preceded by anything |
| `aea`        | angle brackets preceded by anything  |

* these are way more powerful than might be first visible

## Field motions

* inspired by [vim-textobj-argument](https://github.com/gaving/vim-textobj-argument)

| text object | effect                                                                |
|-------------|-----------------------------------------------------------------------|
| `ifb`       | comma-delimited field within parentheses                |
| `ifB`       | comma-delimited field within braces                     |
| `ifr`       | comma-delimited field within square brackets            |
| `ifa`       | comma-delimited field within angle brackets (requires `set matchpairs+=<:>` to work) |

* 

| `afb`       | select comma-separated argument within parentheses with comma     |
| `afB`       | select comma-separated argument within braces with comma          |
| `afr`       | select comma-separated argument within square brackets with comma |
| `afa`       | select comma-separated argument within angle brackets with comma (requires `set matchpairs+=<:>` to work) |

| `if;b`       | select semicolon-separated argument within parentheses                |
| `if;B`       | select semicolon-separated argument within braces                     |
| `if;r`       | select semicolon-separated argument within square brackets            |
| `if;a`       | select semicolon-separated argument within angle brackets (requires `set matchpairs+=<:>` to work) |

| `af;b`       | select semicolon-separated argument within parentheses with semicolon     |
| `af;B`       | select semicolon-separated argument within braces with semicolon          |
| `af;r`       | select semicolon-separated argument within square brackets with semicolon |
| `af;a`       | select semicolon-separated argument within angle brackets with semicolon (requires `set matchpairs+=<:>` to work) |

* 4 types of list styles are supported, or in other words, are checked against to make sure the motions behave as expected:

<table>
    <thead>
        <tr>
            <th>list style</th>
            <th>example</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>short style</td>
            <td>
                <pre><code>foo(arg1, arg2, arg3)</code></pre>
            </td>
        </tr>
        <tr>
            <td>delimiter-indented style</td>
            <td>
                <pre><code>foo_function(arg1, arg2,
             arg3)</code></pre>
            </td>
        </tr>
        <tr>
            <td>trailing-symbol style</td>
            <td>
                <pre><code>foo_function(
    arg1,
    arg2,
    arg3
)</code></pre>
            </td>
        </tr>
        <tr>
            <td>leading-symbol style</td>
            <td>
                <pre><code>foo( arg1
   , arg2
   , arg2
   , arg3
   )</code></pre>
            </td>
        </tr>
    </tbody>
</table> 

> ## Segment motions
> ## Pair motions

## Indent motions

* inspired by [vim-indent-object](https://github.com/michaeljsmith/vim-indent-object)

| text object | effect                                        |
|-------------|-----------------------------------------------|
| `ii`        | select current indent level and above         |
| `ai`        | select current indent level and above, and first line of one indent level below |
| `iI`        | select current indent leven and above going beyond empty lines |
| `aI`        | select current indent level and above, and first line of one indent level below going beyond empty lines |

* these were built to imitate `ip`/`ap` on some level, but also offer many more uses
* `aI` can extends either only to the top, or to the bottom as well
  * defined in the global variable `g:aI_reach_down` , which can be `v:true`, or `v:false`
  * in languages which are indent heavy, like Python or Haskell, reach down is discouraged

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

## TODO

* at the moment, none of the motions accept counts
