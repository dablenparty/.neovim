# .neovim

My custom Neovim config, written from scratch for `nvim 0.11`.

## Dependencies

- A [Nerd Font](https://www.nerdfonts.com/)
  - At the time of writing, I use [JetBrains Mono](https://www.programmingfonts.org/#jetbrainsmono)
- Basic utils: `git`, `unzip`
- Clipboard tool
  - Used to sync clipbord with neovim
  - Wayland needs wl-clipboard
- CMake or `make`
- [`fd`](https://github.com/sharkdp/fd)
- `gcc`
- NodeJS, NPM, and Yarn (use a version manager like `fnm`)
  - `npm i -g yarn`
  - Although very few of them actually specify this, NPM is needed to install ~~most~~ some language servers.
- [`ripgrep`](https://github.com/BurntSushi/ripgrep#installation)
- [`rustup`](https://rustup.rs/) with nightly toolchain
  - `rustup toolchain install nightly`
  - For building [`blink.cmp`](lua/plugins/blink.lua) from source
