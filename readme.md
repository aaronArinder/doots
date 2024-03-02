## Overview

This repo uses a mixed strategy for handling dots and configuration across systems. Everything that can sensibly be put into nix configuration lives in either `/machines` (for per-system base configuration) or `/home-manager` (for user configuration).

For any configuration not managed with nix, `stow` is used to create symlinks.

## Nix

### General

### Updating

#### Home Manager

`home-manager switch`

#### Darwin

Make sure you have the `darwin` channel via `nix-channel --list`:

`nix-channel --update`
`darwin-rebuild switch`

#### Nix Packages (nixpkgs)

TODO; something like this:
`sudo nix-channel --add <new-version-url> nixpkgs`

#### Formatting

There isn't great LSP/formatting support in neovim yet for nix; so, use the following to format files:

```
nixpkgs-fmt ./path/to/file
```

### `/etc/nixos/configuration`

### Adding unstable channel

Some packages need to come from the unstable channel (e.g., as of writing, neovim v0.6). You must do this for `home-manager` to work correctly. Make the unstable channel available system-wide:

```
sudo nix-channel --add https://nixos.org/channels/nixpkgs-unstable unstable
```

Check your channels:

```
sudo nix-channel --list
```

Update your channels:

```
sudo nix-channel --update
```

The above enables the following to work in `/etc/nixos/configuration.nix`:

```
{ config, pkgs, ... };

let
  unstable = import <unstable> {};
in

{
...
  environment.systemPackages = with pkgs; [
    ...
    unstable.neovim
    ...
  ];
...
};
```

## Stow

The `setup.sh` is WIP. For machine-wide configurations:

### System-wide configuration (hardware, sys-wide packages and config options)

From within `doots`:

#### For Linux (matterhorn, kirkjufell):

```
cd machines
sudo stow --target=/etc/nixos <machine>
```

#### For Darwin (uncompahgre):

```
cd machines
sudo stow --target $HOME/.nixpkgs <machine>
```

### User configuration (packages like neovim, alacritty)
And for home-manager (see the `home-manager` section first), first remove the auto-generated `home.nix` and then `stow` the doots version:

```
rm ~/.config/nixpkgs/home.nix
cd doots
stow --target $HOME home-manager
```

### Home manager

#### Installation

- Install [home-manager](https://nix-community.github.io/home-manager/index.html#sec-install-standalone)
- Stow: `nix-env -iA nixpkgs.stow`
- [vim-plug](https://github.com/junegunn/vim-plug) is required, and I haven't found a good way of installing it without putting the config into home-manager (which I want to avoid so I can use it without home-manager and outside of nixOS):

```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

#### Configuration

`man home-configuration.nix`

## Troubleshooting
### `error: file 'nixpkgs' was not found in the Nix search path (add it using $NIX_PATH or -I)`
```
nix-channel --add https://nixos.org/channels/nixos-22.05 nixpkgs
nix-channel --update
```

