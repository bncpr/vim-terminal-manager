# vim-terminal-manager

A plugin to manage vim/neovim's :terminal emulator.

## Options

#### Default Mappings

These mappings are mapped by default (can be changed in vimrc file):

```vim
map <space>t <Plug>TerminalToggleOpen
map <leader>t <Plug>TerminalToggleFocus
```

#### Commands

```
:TermAutoInsertToggle
```

#### Default Configurations

```
let g:terminal_height = 12
let g:terminal_auto_insert_mode = 0
```
