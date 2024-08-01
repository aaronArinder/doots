## Overview

Dotfile management using nix, home-manager, and stow.

### Installation
#### Dependencies

- [install nix](https://nixos.org/download/)
- add the `home-manager` channel: `nix-channel --add https://github.com/nix-community/home-manager/archive/<RELEASE>.tar.gz home-manager`
  - find the release from the github; it will be in the form `release-23.11` 
- `nix-shell -p stow`

#### Machine
###### For Linux (matterhorn, kirkjufell):

```
cd machines
sudo stow --target=/etc/nixos <machine>
```

##### For Darwin (uncompahgre):

```
mkdir $HOME/.nixpkgs
cd machines
sudo stow --target $HOME/.nixpkgs uncompahgre
```

Install [nix-darwin](https://github.com/LnL7/nix-darwin)

The installer should rebuild switch, but if not exit or source the shell and `darwin-rebuild switch`

### Add channels

- Add channel: `nix-channel --add <channel-url> <channel-name>`
  - Go to the [repo](https://github.com/NixOS/nixpkgs) and find the right release branch name for the target architecture, e.g. `nixpkgs-24.05-darwin` for darwin
  - Add the main channel and call it `nixos`
  - Add the unstable channel and call it `unstable`

### Maintenance

- Update channels: `nix-channel --update`
- (Optional for darwin) `nix-channel --update darwin`
- Darwin: build/activate: `darwin-rebuild switch`
- Update `nixpkgs` version: `nix-channel --add <new-version-url> nixpkgs`
- Format: `nixpkgs-fmt ./path/to/file`
- Garbage collect the store: `nix-collect-garbage` (`-d` to delete old profiles/generations for extra cleanup; see manpage)

#### Configuration
`man home-configuration.nix`
