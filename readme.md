## Overview

Dotfile management using nix, home-manager, and stow.

### Installation
#### Dependencies

- install nix
- add the `home-manager` channel: `nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz home-manager`
- `stow` can be installed in an ephemeral shell (it's primarily useful in system setup, and we can't just plop it in a machine's config file because we're using `stow` during the boostrapping process): `nix-shell -p stow`

#### Machine
###### For Linux (matterhorn, kirkjufell):

```
cd machines
sudo stow --target=/etc/nixos <machine>
```

##### For Darwin (uncompahgre):

```
cd machines
sudo stow --target $HOME/.nixpkgs <machine>
```

### Maintenance

- Add channel: `nix-channel --add <channel-url> <channel-name>`
- Update channels: `nix-channel --update`
- Darwin: build/activate: `darwin-rebuild switch`
- Update `nixpkgs` version: `nix-channel --add <new-version-url> nixpkgs`
- Format: `nixpkgs-fmt ./path/to/file`
- Garbage collect the store: `nix-collect-garbage` (`-d` to delete old profiles/generations for extra cleanup; see manpage)

#### Configuration
`man home-configuration.nix`
