# .neovim

My custom Neovim config, written from scratch for `nvim 0.12`.

## Dependencies

- A [Nerd Font](https://www.nerdfonts.com/)
  - At the time of writing, I use **JetBrains Mono**.
- Basic utils: `gcc`, `git`, `unzip`
- Clipboard tool
  - Used to sync clipbord with neovim
  - Wayland needs `wl-clipboard`
- CMake or `make`
- [`fd`](https://github.com/sharkdp/fd)
  - Better `find` utility
- Golang (`go`)
  - Necessary to install [`docker-language-server`](lua/plugins/lsp/mason.lua#L8-L19).
- NodeJS, NPM, and Yarn (use a version manager like [fnm](https://github.com/Schniz/fnm))
  - `npm i -g yarn`
  - Although very few of them actually specify this, NPM is needed to install ~~most~~ some language servers.
- [`ripgrep`](https://github.com/BurntSushi/ripgrep#installation)
- [`rustup`](https://rustup.rs/) with nightly toolchain
  - `rustup toolchain install nightly`
  - For building [`blink.cmp`](lua/plugins/blink.lua) from source.
- `tree-sitter-cli`
  - Install from your system package manager.
- [yazi](https://yazi-rs.github.io/) terminal file manager
