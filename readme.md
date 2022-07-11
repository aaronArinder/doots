## Overview

This repo uses a mixed strategy for handling dots and configuration across systems. Everything that can sensibly be put into nix configuration lives in either `/machines` (for per-system base configuration) or `/home-manager` (for user configuration).

For any configuration not managed with nix, `stow` is used to create symlinks.

## Nix

### General

There isn't great LSP/formatting support in neovim yet; so, use the following to format files:

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

```
sudo stow --target=/etc/nixos machines/<machine>
```

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

#### Configuration

`man home-configuration.nix`

## Troubleshooting
### `error: file 'nixpkgs' was not found in the Nix search path (add it using $NIX_PATH or -I)`
```
nix-channel --add https://nixos.org/channels/nixos-22.05 nixpkgs
nix-channel --update
```

## TODOs

### zsh

-   [ ] Figure out better alias strategy (move what's currently in zshrc)

### home-manager

-   [ ] Figure out how to modularize users across machines (need macOS/nix variants)
