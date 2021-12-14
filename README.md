# coc-custom_elements

This is workaround for [Docs improvement/Quesion: How the ‘custom tag’ supposed to work? · Issue #45 · neoclide/coc-html](https://github.com/neoclide/coc-html/issues/45).

In your session `*.x.vim` file (see [Build-in sessions tips](https://github.com/jaandrle/vim-mini_sessions#build-in-sessions-tips)) or in command line use:

```vim
call coc#source#custom_elements#AddSource(__path__)
```

…now in your *html*/*javascript* files the HTML custom elements competitons are available.
There is also function for updating tags `coc#source#custom_elements#Update()` and function
for opening source file `coc#source#custom_elements#OpenSource(__order_of_add__)`.

## Instalation
vim8:
```bash
mkdir -p ~/.vim/pack/coc-custom_elements/start
cd ~/.vim/pack/coc-custom_elements/start
git clone https://github.com/jaandrle/coc-custom_elements
```
