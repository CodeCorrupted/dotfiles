# Neovim Configuration - Modern Development Environment

[![Lua](https://img.shields.io/badge/Made%20with%20Lua-blueviolet.svg?style=flat&logo=lua)](https://lua.org)
[![Neovim](https://img.shields.io/badge/Neovim%20Version-0.10%2B-green.svg?style=flat&logo=neovim)](https://neovim.io)

Modern Neovim configuration optimized for web development
(JavaScript/Typescript/Angular) with full Java support. Built for Linux systems
with extensibility for other platforms.

## Features

### Language Support

- **Web Development**: Angular, Typescript, JavaScript, HTML, CSS, JSON
- **Backend & Scripting**: Java, Python, Lua, Bash
- **Documentation**: Markdown

### Core Capabilities

- Intelligent Autocompletion (LSP-powered)
- Integrated Debugger (nvim-dap)
- Snippet Engine (Luasnip)
- Advanced Syntax Highlighting (Treesitter)
- System Clipboard Integration
- Enhanced Notifications (nvim-notify)

### UI & Workflow Enhancements

- Nightfox Theme Suite (with `Ctrl+c` theme cycler)
- File Navigation (Telescope with fd/ripgrep)
- Status Line (Lualine)
- Which-key Interactive Keybindings
- Image Preview (with Chafa/ImageMagick)
- Terminal Integration (`Alt+t` toggle)

## System Requirements

### Essential Tools

- Neovim (0.10+)
- Git
- Node.js (18+) & npm
- Python 3.10+
- C Compiler (GCC/Clang)

### Recommended Utilities

| Tool         | Purpose                  |
| ------------ | ------------------------ |
| [Ripgrep][1] | Fast file content search |
| [fd][2]      | Efficient file discovery |
| [Chafa][3]   | Terminal image previews  |

## Installation

```bash
# Copy this folder to config directory
cp -r ./ ~/.config/

# Start Neovim to bootstrap plugin manager
nvim

# After initial setup, install Treesitter REPL support
:TSInstall dap_repl

# Quit and restart Neovim for full initialization
:qa
nvim
```

## Key Bindings

Access full keybinding reference with `:WhichKey`. Essential mappings:

| Key         | Action                  |
| ----------- | ----------------------- |
| `<Space>`   | Leader mapping          |
| `<leader>t` | Telescope bindings      |
| `<leader>d` | Debugger bindings       |
| `<leader>s` | Session bindings        |
| `<leader>b` | Buffer actions          |
| `Alt+t`     | Toggle Terminal         |
| `Alt+[0-9]` | Go to buffer number 0-9 |
| `Ctrl+c`    | Cycle color schemes     |

## Plugins Highlights

Configuration organized in `lua/plugins`:

- **Core**: Lazy.nvim (plugin manager)
- **LSP**: nvim-lspconfig, mason.nvim, etc.
- **UI**: Telescope, Lualine, Barbar, etc.
- **Debugging**: nvim-dap, nvim-dap-ui

The organization is pretty intuitive and a lot of plugins have the default
configuration.

## Troubleshooting

Common issues and solutions:

- **Missing Treesitter Highlights**:

```vim
:TSUpdate
:TSInstall dap_repl
```

- **Image Preview Not Working**:

```bash
# Install utilities
sudo pacman -S imagemagick chafa ffmpegthumbnailer
```

If your distro isn't Arch based, the name of the packages should be the same,
just change the installation command and you should be fine.

[1]: https://github.com/BurntSushi/ripgrep
[2]: https://github.com/sharkdp/fd
[3]: https://github.com/hpjansson/chafa/
