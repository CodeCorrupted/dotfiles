# Neovim

This is my configuration of Neovim. Some commits before introducing this file, this
configuration offered basic support for C and C++. I removed those languages
because i didn't use them.

This configuration supports the following languages:

- Angular
- Bash
- CSS
- HTML
- Java
- JavaScript
- Json
- TypeScript
- Markdown
- Lua
- Python

This configuration was tested only on Linux, so if you're on another system, it
could not work propperly.

Also, it have the following features:

- Autocompletion.
- Debugger.
- Linters.
- Formatters.
- Snippets (by Luasnip).
- File explorer, finder, etc. (Telescope).
- Clipboard (for things you yank).
- Enhanced notifications (with notify plugin).
- Nightfox colorscheme (you can change through all of them with Control+c).
- Fancy greeter.
- Motion, Marks and Session enhanced by plugins.
- Treesitter enhancement.
- Bar and buffer's visual improvement.
- Terminal on editor (you can run it with Alt+t).
- And which-key to show all the available mappings!

To check every mapping available, just run `:WhichKey` in the cmd of Neovim.

## Requirements

This configuration assumes that you have the following things installed:

- Neovim >= 0.10
- tar
- curl
- libstdc++
- Any C compiler
- git
- unzip
- gzip
- tar o gtar
- npm
- nodejs
- [Ripgrep][1]
- [fd][2]
- Chafa
- ImageMagick
- pdftoppm
- ffmpegthumbnailer

## Installation

Once you have every dependencie installed on your system, you just have to copy
the contents of this folder in your `$HOME/.config/nvim` directory.

After that, you'll have to open Neovim to make it run the bootstrap for lazy
(the plugin manager). Quit after the installation of lazy and open it again to
let lazy install the listed plugins.

Once everything is installed, you need to run inside Neovim the command
`:TSInstall dap_repl` to add the treesitter support for the highlighting in the
debugger.

## About

If you want to see what plugins are installed, check the `lua/plugins/init.lua`
file. All the files inside `lua/plugins` directory have the files used to
configure the plugins with a too much code needed to set them up.

[1]: https://github.com/BurntSushi/ripgrep
[2]: https://github.com/sharkdp/fd
