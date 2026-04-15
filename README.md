# dot-vim

Neovim configuration using the built-in `vim.pack` plugin manager.

## Requirements

- Neovim 0.12+
- Git
- A [Nerd Font](https://www.nerdfonts.com/) (e.g., Meslo LG M) for icons and status line glyphs

## Fresh Install

```sh
git clone git@github.com:jlintz/dot-vim.git ~/.config/nvim
```

Open Neovim and plugins will be installed automatically on first launch via `vim.pack.add()`.

LSP servers are managed by Mason. On first launch, open a file and run:

```vim
:Mason
```

to verify servers are installed (basedpyright, gopls, lua_ls, etc.).

## Updating Plugins

Update all plugins:

```vim
:lua vim.pack.update()
```

Update a specific plugin:

```vim
:lua vim.pack.update('nvim-cmp')
```

## Updating LSP Servers

```vim
:Mason
```

Use the Mason UI to update installed language servers.

## Key Leader

Leader key is set to `,`.
