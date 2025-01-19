# Dotfiles

This repository contains a subset (for now) of my dotfiles used in my development environment.

## ⚠️ Disclaimer

I use macOS. These dotfiles are made on and for computers running macOS. If you want to use these dotfiles on Linux, Windows or any other OS: Awesome! I will not help you fix errors you encounter while setting up your system using my configuration.

## Contents

I use the following programmes to develop, using all the hot new tools on the block like:

1. [Alacritty](https://github.com/alacritty/alacritty): terminal emulator
2. [Fish shell](https://github.com/fish-shell/fish-shell): terminal shell of choice
3. [Neovim](https://github.com/neovim/neovim): code editor
4. [Zellij](https://github.com/zellij-org/zellij): terminal multiplexer
5. [Lazygit](https://github.com/jesseduffield/lazygit): terminal ui for git
6. [Homebrew][brew]: package manager

I prefer my utility tools to be written in Rust, as they usually provide more modern features than the tools they replace. Take a look at the Brewfile to see what's in store.

## Usage

> **Info:**
> Scripts that guide you through a step-by-step process will be added to this repository soon-ish.

> **Warning:**
> Make a backup of your own configuration files before messing about with these ones.

1. Clone this repository to a folder other than `~/`, like `~/projects/dfiles`.
2. Copy .Brewfile to your home folder
   a) If you haven't yet, install [Homebrew][brew]
3. Run `brew tap homebrew/bundle`
4. Run `brew bundle --global --no-lock`
5. Copy configuration files and folders from the repository into your home and/or config folder.
6. Enjoy!

## To do

- [ ] Add setup scripts
- [ ] Add selective configuration for different programming languages

## Special thanks

- [folke](https://github.com/folke) for their nvim configuration; mine is basically variation to his.

[brew]: https://brew.sh
