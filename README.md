php.vim
=======

An up-to-date Vim syntax for PHP.

_This project is a fork of [php.vim--Garvin][php.vim-garvin] which in turn is an update of the [php.vim][php.vim-original] script which in turn is an updated version of the php.vim syntax file distributed with Vim. **Whew!**_

Installation
------------

If you don't have a preferred installation method, [vim-plug] is quick and simple. With [vim-plug installed], add the following to your `vimrc` (if you are a NeoVim user, see the [FAQ page][neovim-faq] for help):

```vimscript
Plug 'StanAngeloff/php.vim'
```

Configuration
-------------

`php.vim` comes with sensible defaults for most use cases. Below is a list of some interesting configuration options you may tweak. Refer to the [source code][php.vim-source] for additional options.

- `g:php_syntax_extensions_enabled`, `g:php_syntax_extensions_disabled`  
  `b:php_syntax_extensions_enabled`, `b:php_syntax_extensions_disabled`

  Default: `g:php_syntax_extensions_enabled = ["bcmath", "bz2", "core", "curl", "date", "dom", "ereg", "gd", "gettext", "hash", "iconv", "json", "libxml", "mbstring", "mcrypt", "mhash", "mysql", "mysqli", "openssl", "pcre", "pdo", "pgsql", "phar", "reflection", "session", "simplexml", "soap", "sockets", "spl", "sqlite3", "standard", "tokenizer", "wddx", "xml", "xmlreader", "xmlwriter", "zip", "zlib"]`

  A list of PHP extension names (lowercase) for which highlighting of built-in functions, constants, classes and interfaces is enabled / disabled.

  If you are **not** interested in highlighting **any** built-in functions/constants/etc., set `g:php_syntax_extensions_enabled` to an empty list `[]`.

  If you are **not** interested in highlighting built-in functions/constants/etc. for a subset of PHP extensions, set `g:php_syntax_extensions_enabled` to a list of extensions you wish to disable, e.g., `["mcrypt"]`.

- `php_var_selector_is_identifier`

  Default: `0`

  Set this to a truthy value (e.g., `1`) to include the dollar sign `$` as part of the highlighting group for a PHP variable.

- `php_html_load`, `php_html_in_heredoc`, `php_html_in_nowdoc`

  Default: `1` (NOTE: setting `php_html_load` to a truthy value takes precedence and overrides both `php_html_in_heredoc` & `php_html_in_nowdoc`)

  Set to a falsy value (e.g., `0`) to disable embedding HTML in PHP. Doing so may yield significant speed-ups of syntax highlighting.

  This should not affect HTML highlighting in templating languages, such as [Blade].

- `php_sql_query`, `php_sql_heredoc`, `php_sql_nowdoc`

  Default: `1`

  Set to a falsy value (e.g., `0`) to disable SQL syntax in PHP. Doing so may yield moderate speed-ups of syntax highlighting.

### Projects of interest

`php.vim` pairs nicely with:

- [`phpfolding.vim`](https://github.com/rayburgemeestre/phpfolding.vim): _Automatic folding of PHP functions, classes, … (also folds related PhpDoc)_
- [`PHP-Indenting-for-VIm`](https://github.com/2072/PHP-Indenting-for-VIm): _The official VIm indent script for PHP_

### Overriding highlighting

Syntax highlighting can be controlled at a fine-grained level allowing you to distinguish groups by overriding defaults. For example, all code in PHP comments is highlighted as `phpComment` by default, however there are groups you can tweak, e.g., how PHPDoc `@tags` appear. There are [several groups you can choose from](syntax-groups).

Example: Overriding PHP `@tags` and `$parameters` in comments to appear as a different highlighting group, giving them distinct colouring:

```vimscript
" Put this snippet at the very end of your vimrc file.

function! PhpSyntaxOverride()
  " Put overrides in this function.
  hi! link phpDocTags  phpDefine
  hi! link phpDocParam phpType
endfunction

augroup phpSyntaxOverride
  autocmd!
  autocmd FileType php call PhpSyntaxOverride()
augroup END
```

You may optionally assign specific colouring to groups in the `PhpSyntaxOverride` function:

```vimscript
" […]

function! PhpSyntaxOverride()
  " Highlight the backslash in use, extends and implements in grey.
  hi phpUseNamespaceSeparator guifg=#808080 guibg=NONE gui=NONE
  hi phpClassNamespaceSeparator guifg=#808080 guibg=NONE gui=NONE
endfunction

" […]
```

Developing
----------

When you install `php.vim` using your preferred installation method, all the needed files are already in place.

If you have a more recent version of PHP installed locally (with all of the PHP extensions you want/need), you may use the provided `Dockerfile` to rebuild the syntax file:

```bash
docker build -t stanangeloff/php.vim .
docker run --rm -i -v "$PWD":/var/php -t stanangeloff/php.vim > /tmp/php.vim && cat /tmp/php.vim | sed 's/\x0D$//' > syntax/php.vim
docker rmi stanangeloff/php.vim
```

NOTE: The `sed` command strips out Windows line endings. If the updated syntax file fails to load and is corrupted, try loading `syntax/php.vim` in your favourite editor and ensure line endings are set to Unix.

  [php.vim-garvin]:  https://github.com/vim-scripts/php.vim--Garvin
  [php.vim-original]: http://www.vim.org/scripts/script.php?script_id=2874
  [vim-plug]: https://github.com/junegunn/vim-plug
  [vim-plug installed]: https://github.com/junegunn/vim-plug#installation
  [neovim-faq]: https://github.com/neovim/neovim/wiki/FAQ#where-should-i-put-my-config-vimrc
  [php.vim-source]: https://github.com/StanAngeloff/php.vim/blob/master/syntax/php.vim#L35
  [Blade]: https://github.com/jwalton512/vim-blade
  [syntax-groups]: https://github.com/StanAngeloff/php.vim/blob/41c36f7f/syntax/php.vim#L804
