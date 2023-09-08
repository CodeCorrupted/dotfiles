# Configuración de Neovim

Estos son mis archivos para configurar Neovim lo más cercano posible
 a un IDE. Puede que necesite ciertas mejoras, pero tiene lo básico:

- Mejor interfaz de usuario.
- Soporte para autocompletado y snippets.
- Soporte de LSP para: Java, Lua, JS, TS, HTML, CSS, Bash, Python y Markdown.
- Adaptador de debug básico para: Java, JS, TS, Bash y Python.
- Format y linter al guardar.
- Code actions para algunos lenguajes.
- Instalador para LSP (Language Server Protocol) y DAP (Debug Adapter Protocol).
- Un explorador de archivos más atractivo.
- Previsualizador de archivos markdown.
- Etc.

Estos archivos de configuración fueron pensados para funcionar en Artix Linux.
 Si usas otro SO, puede que no te funcione bien.

## Tabla de contenidos

1. [Requisitos](#requisitos)
2. [Primera vez](#primera-vez)
3. [Algunas explicaciones sobre el debugger](#algunas-explicaciones-sobre-el-debugger)
4. [Acerca de los atajos de teclado](#acerca-de-los-atajos-de-teclado)
5. [Lista de plugins](#lista-de-plugins)

## Requisitos

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

Si no posees la versión 0.8 de Neovim o superior, muchos plugins ni siquiera iniciarán.
 Además, todo está configurado en Lua y algunas funciones que fueron implementadas
 en Neovim 0.8+.

La Nerd Font es necesaria para ser capaz de ver correctamente los iconos y la ui
 mejorada por los plugins instalados.

Tar, git, curl, gcc, wget, unzip, gzip y npm son paquetes necesarios para ser capaz
 de instalar algunos LSP's, DAP's y parsers para Neovim.

Glow es una herramienta para previsualizar archivos .md (markdown) en el editor.
 Finalmente, JDK-17 y Python son necesarios para los LSPs de esos lenguajes.

Una vez instaladas todas esas herramientas, solo tienes que copiar esta carpeta en
 tu `$HOME/.config/` directorio.

## Primera vez

La primera vez que abres Neovim después de la instalación, éste comenzará a
 instalar los plugins, LSPs y DAPs. Luego, debes ejecutar `:Mason` en el cmd
 de Neovim. Abrirá la ventana del instalador Mason. Estos son las opciones que
 debes instalar:

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

Esos son formatters y linters para los lenguajes soportados.

## Algunas explicaciones sobre el debugger

Realmente no uso tan seguido los debuggers, ya que aún estoy aprendiendo a
 programar. Solo usé un poco el debugger de bash, java y python. Para los
 primeros dos lenguajes, el debugger se lanza con solo presionar `<F4>` luego
 de colocar un breakpoint. Pero con Java, luego de que el lenguaje de servidor
 haya cargado y se haya colocado un breakpoint, debes correr `:JdtUpdateDebugConfig`
 (el atajo de teclado de esto es: `<leader>dj`) y luego presionar `<F4>`.

Si necesitas alguna caracteristica más específica del debugger, puedes ir a [nvim-dap][16]
 o ejecutar `:h dap.txt`.

En caso de que el adaptador de debugger de Java no inicie o lance algún error, puede
 que debas intentar instalar por ti mismo [java-debug][17] y [vscode-java-test][18].

Y si con Python tampoco te funciona el debugger, instala debugpy así:

```bash
mkdir .virtualenvs
cd .virtualenvs
python3 -m venv debugpy
debugpy/bin/python -m pip install debugpy
```

Luego, ve al archivo `~/.config/nvim/lua/dap-config/init.lua` y comenta la
 línea dónde el debugpy es llamado desde mason (con `gcc`) y descomenta la
 línea en dónde es llamado desde `~/.virtualenvs/` (otra vez, con `gcc`).

Los próximos cambios que realice a esta configuración, puede que contenga
 algunas mejoras para los debuggers.

## Acerca de los atajos de teclado

Para ver los atajos de teclado, usa el comando `:WhichKey`. Baja con `Ctrl+d`
 y sube con `Ctrl+u` en esta nueva ventana.

WhichKey puede mostrarte algunos atajos de teclado que te confundan. Aquí
 algunas explicaciones:

- `<leader>` es una tecla especial para Neovim. Configuré esta tecla cómo `<Espacio>`.
- Algunos atajos de teclado están configurados cómo `<M-otraTecla>`, pero se refiere
 a `Alt+otraTecla`, y no a `Shift+otraTecla`.
- En los atajos de teclado configurados cómo `<C-otraTecla>`, la "C" representa la
 tecla `<Ctrl>`.
- No solo muestra los atajos de teclado que yo he configurado, sino también los atajos
 del propio Neovim (yank, delete, marks, etc.).

## Lista de plugins

Puede que ya estés familiarizado con Neovim y solo quieras saber sobre los plugins
 que uso en esta configuración. Aquí la lista de esos plugins:

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
