# Neovim configuration

These are my files to set up Neovim as something near to an IDE.
 Meaby needs more improvements, but it got the basics things:

- Better ui.
- Autocompletion and snippets support.
- LSP support for: Java, Lua, JS, TS, HTML, CSS, Bash, Python and Markdown.
- Basic debug adapter support for: Java, JS, TS, Bash and Python.
- Format and linter on save.
- Code actions for some languages.
- Installer for LSP (Language Server Protocol) and DAP (Debug Adapter Protocol).
- A fancy file explorer.
- Previewer for markdown files.
- Etc.

This configuration was thinked to work on Artix Linux.
 If you use another SO, it may not work well.

## Table of contents

1. [Requirements](#requirements)
2. [Firs time](#first-time)
3. [Debug Adapter](#some-explanations-about-debug-adapter)
4. [Keybindings](#about-the-keybindings)
5. [Plugins](#list-of-plugins)

## Requirements

- [Neovim 0.8+][1].
- [Nerd Font][2].
- [Tar][3].
- [Curl][4].
- [Git][5].
- [GCC][6].
- [Ripgrep][7].
- [fd][8].
- [Chafa][9].
- [Imagemagick][10].
- [Wget][11].
- Unzip, gzip.
- [npm][12].
- [Python 3.9+][13].
- [JDK-17][14].
- [Glow][15].

If you don't have the version 0.8 of Neovim, a lot of plugins won't even start.
 Besides, everything is set up with Lua and some functions that were implemented
 on Neovim 0.8+.

The Nerd Font it's required for be able to see correctly the icons and ui improved
 by the installed plugins.

Tar, curl, git, gcc, wget, unzip, gzip and npm are packages needed to be able to
 install some LSP's, DAP's and parsers for Neovim.

Glow it's a tool for see a preview of markdown files on the editor.
 Finally, JDK-17 and Python are necessary for the LSPs of those languages.

Once installed all those tools, you just have to copy this folder at `$HOME/.config/`
 directory.

## First time

At the first time that you open Neovim after the installation, it will start
 the installation of plugins, LSPs and DAPs. After that, you should run `:Mason`
 on cmd of Neovim. It will open the window of Mason installer. These are the
 things you must install:

- Beautysh.
- Black.
- Checkstyle.
- Djlint.
- Eslint_d.
- Flake8.
- Google-java-format.
- Markdownlint.
- Prettier.
- Shellcheck.
- Stylelint.
- Stylua.

Those are formatters and linters for the supported languages.

## Some explanations about debug adapter

I really don't use that often those debuggers, since I'm still learning
 to program. I just used a little bit the python, bash and java debugger.
 For the first two languages, you launch the debugger with just pressing `<F4>`
 after setting a breakpoint. But with Java, after the language server is
 loaded and set the breakpoint, you must run `:JdtUpdateDebugConfig`
 (the keybinding for this: `<leader>dj`) and then you press `<F4>`.

If you need a more specific feature of the debugger, go to [nvim-dap][16]
 or run `:h dap.txt`.

In case that the debug adapter of Java doesn't start or throws some kind
 of error, may you should try to install by yourself [java-debug][17] and
 [vscode-java-test][18].

If the debug adapter of Python doesn't work, install debugpy as follows:

```bash
mkdir .virtualenvs
cd .virtualenvs
python3 -m venv debugpy
debugpy/bin/python -m pip install debugpy
```

Then, go to the file on `~/.config/nvim/lua/dap-config/init.lua` and comment
 the line where debugpy is called from mason (with `gcc`) and uncomment the line
 where it is called from `~/.virtualenvs/` (with `gcc` again).

The next changes that I'll do to this config, may include some improvements
 for the debugger.

## About the keybindings

To see the keybindings, use the command `:WhichKey`. Scroll down whith
 `Ctrl+d` and up with `Ctrl+u`.

WhichKey will show you some keys that may confuse you. Here some
 explanations:

- `<leader>` it's a special key on Neovim. I configured this key as `<Space>`.
- Some keybindings are set as `<M-anyOtherKey>`, but it really means `Alt+other-key`,
 instead of `Mayus+other-key`.
- In the keybindings set as `<C-anyOtherKey>`, the "C" stands for the `<Ctrl>` key.
- Not only shows keymappings that I set up, also it shows you the mappings integrated
 on Neovim (yank, delete, marks, etc).

## List of plugins

Meaby you already know all about Neovim and just want to know about the plugins
 that I use on this config. Here's the list of those plugins:

- Plugin manager: [lazy.nvim][19].
- Tree-sitter support and basic functionality based on it:
  - [nvim-treesitter][20].
  - [nvim-treesitter-refactor][21].
  - [nvim-ts-autotag][22].
  - [twilight][23].
  - [rainbow-delimiters][24].
  - [nvim-ts-context-commentstring][25].
- Fuzzy finder:
  - [telescope][26].
  - [telescope-media-files][27].
  - [telescope-ui-select][28].
  - [telescope-fzf-native][29].
  - [telescope-dap][30].
- LSP support:
  - [mason][31].
  - [mason-lspconfig][32].
  - [mason-nvim-dap][33].
  - [nvim-lspconfig][34].
  - [nvim-jdtls][35].
- Linter: [nvim-lint][36].
- Formatter: [formatter][37].
- DAP support:
  - [nvim-dap][38].
  - [nvim-dap-python][39].
  - [nvim-dap-ui][40].
  - [nvim-dap-virtual-text][41].
  - [nvim-dap-repl-highlights][42].
- Snippets: [LuaSnip][43] and [friendly-snippets][44].
- Autocompletion support:
  - [nvim-cmp][45].
  - [lspkind][46].
  - [cmp_luasnip][47].
  - [cmp-nvim-lsp][48].
  - [cmp-buffer][49].
  - [cmp-path][50].
  - [cmp-cmdline][51].
  - [cmp-treesitter][52].
  - [cmp-nvim-lua][53].
  - [cmp-under-comparator][54].
- Colorscheme: [nightfox][55].
- Notifications:
  - [notify][56].
  - [lsp-notify][57].
- Statusline: [feline][58].
- Tabs & buffers: [bufferline][59].
- Git integration: [gitsigns][60].
- Comments support: [Comment][61].
- Easy motion: [leap][62].
- Repeat some actions with ".": [vim-repeat][63].
- Autopair: [autopairs][64].
- Terminal on Neovim: [toggleterm][65].
- Clipboard for Neovim: [neoclip][66].
- Improvement to the manage of marks on Neovim: [marks][67].
- Greeter for Neovim: [alpha][68].
- Viewer of .md files on Neovim: [glow][69].
- Popup window of keybindings: [Which-key][70].
- File explorer:
  - [nvim-tree][71].
  - [mini.base16][72].
  - [nvim-lsp-file-operations][73].
- Support for icons: [nvim-web-devicons][74].

[1]: https://github.com/neovim/neovim
[2]: https://github.com/ryanoasis/nerd-fonts#option-8-arch-community-repository
[3]: https://www.gnu.org/software/tar/
[4]: https://curl.se/
[5]: https://git-scm.com/
[6]: https://gcc.gnu.org/
[7]: https://github.com/BurntSushi/ripgrep
[8]: https://github.com/sharkdp/fd
[9]: https://hpjansson.org/chafa/
[10]: https://imagemagick.org/index.php
[11]: https://www.gnu.org/software/wget/
[12]: https://www.npmjs.com/
[13]: https://www.python.org/
[14]: https://www.oracle.com/java/technologies/javase/jdk17-archive-downloads.html
[15]: https://github.com/charmbracelet/glow
[16]: https://github.com/mfussenegger/nvim-dap
[17]: https://github.com/microsoft/java-debug.git
[18]: https://github.com/microsoft/vscode-java-test.git
[19]: https://github.com/folke/lazy.nvim
[20]: https://github.com/nvim-treesitter/nvim-treesitter
[21]: https://github.com/nvim-treesitter/nvim-treesitter-refactor
[22]: https://github.com/windwp/nvim-ts-autotag
[23]: https://github.com/folke/twilight.nvim
[24]: https://gitlab.com/HiPhish/rainbow-delimiters.nvim
[25]: https://github.com/JoosepAlviste/nvim-ts-context-commentstring
[26]: https://github.com/nvim-telescope/telescope.nvim
[27]: https://github.com/nvim-telescope/telescope-media-files.nvim
[28]: https://github.com/nvim-telescope/telescope-ui-select.nvim
[29]: https://github.com/nvim-telescope/telescope-fzf-native.nvim
[30]: https://github.com/nvim-telescope/telescope-dap.nvim
[31]: https://github.com/williamboman/mason.nvim
[32]: https://github.com/williamboman/mason-lspconfig.nvim
[33]: https://github.com/jay-babu/mason-nvim-dap.nvim
[34]: https://github.com/neovim/nvim-lspconfig
[35]: https://github.com/mfussenegger/nvim-jdtls
[36]: https://github.com/mfussenegger/nvim-lint
[37]: https://github.com/mhartington/formatter.nvim
[38]: https://github.com/mfussenegger/nvim-dap
[39]: https://github.com/mfussenegger/nvim-dap-python
[40]: https://github.com/rcarriga/nvim-dap-ui
[41]: https://github.com/theHamsta/nvim-dap-virtual-text
[42]: https://github.com/LiadOz/nvim-dap-repl-highlights
[43]: https://github.com/L3MON4D3/LuaSnip
[44]: https://github.com/rafamadriz/friendly-snippets
[45]: https://github.com/hrsh7th/nvim-cmp/
[46]: https://github.com/onsails/lspkind.nvim
[47]: https://github.com/saadparwaiz1/cmp_luasnip
[48]: https://github.com/hrsh7th/cmp-nvim-lsp
[49]: https://github.com/hrsh7th/cmp-buffer
[50]: https://github.com/hrsh7th/cmp-path
[51]: https://github.com/hrsh7th/cmp-cmdline
[52]: https://github.com/ray-x/cmp-treesitter
[53]: https://github.com/hrsh7th/cmp-nvim-lua
[54]: https://github.com/lukas-reineke/cmp-under-comparator
[55]: https://github.com/EdenEast/nightfox.nvim
[56]: https://github.com/rcarriga/nvim-notify
[57]: https://github.com/mrded/nvim-lsp-notify
[58]: https://github.com/freddiehaddad/feline.nvim
[59]: https://github.com/akinsho/bufferline.nvim
[60]: https://github.com/lewis6991/gitsigns.nvim
[61]: https://github.com/numToStr/Comment.nvim
[62]: https://github.com/ggandor/leap.nvim
[63]: https://github.com/tpope/vim-repeat
[64]: https://github.com/windwp/nvim-autopairs
[65]: https://github.com/akinsho/toggleterm.nvim
[66]: https://github.com/AckslD/nvim-neoclip.lua
[67]: https://github.com/chentoast/marks.nvim
[68]: https://github.com/goolord/alpha-nvim
[69]: https://github.com/ellisonleao/glow.nvim
[70]: https://github.com/folke/which-key.nvim
[71]: https://github.com/nvim-tree/nvim-tree.lua
[72]: https://github.com/echasnovski/mini.base16
[73]: https://github.com/antosha417/nvim-lsp-file-operations
[74]: https://github.com/nvim-tree/nvim-web-devicons
