## Overview

Dotfile management using nix, home-manager, and stow.

### Installation
#### Dependencies

- [install nix](https://nixos.org/download/)
- add the `home-manager` channel: `nix-channel --add https://github.com/nix-community/home-manager/archive/<RELEASE>.tar.gz home-manager`
  - find the release from the github; it will be in the form `release-23.11` 
- `nix-shell -p stow`

#### Initial setup

##### Git

- `nix-shell -p git`
- Get [ssh](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) sorted
- `git clone git@github.com:aaronArinder/doots.git` in your home directory

##### neovim

Neovim uses the `.config` directory. So, check that you're in the right directory (`doots`):

```
$ pwd
> doots
```

Doublecheck what `stow` will do:

```
stow --adopt -nv neovim
```

If it looks good (it should say `LINK: .config => doots/neovim/.config`), remove the `-n` and run:

```
stow --adopt -v neovim
```

⚠️ It probably matters that we do this first when setting up a machine; I don't know if stowing would overwrite `.config` here

#### Machine
###### For Linux (matterhorn, kirkjufell):

```
cd machines
sudo stow --target=/etc/nixos <machine>
```

##### For Darwin (current machine: eolus):

- Follow installaton for [nix-darwin](https://github.com/LnL7/nix-darwin)
- Make sure you get an `/etc/nix-darwin`
- Kill the initial flake and lockfile
- `sudo stow --target=/etc/nix-darwin ./nix-darwin` from within `machines/eolus`
- You should now be able to apply the config via `darwin-rebuild switch --impure`
  - The impurity comes from loading modules into the flake

### Add channels

- Add channel: `nix-channel --add <channel-url> <channel-name>`
  - Go to the [repo](https://github.com/NixOS/nixpkgs) and find the right release branch name for the target architecture, e.g. `nixpkgs-24.05-darwin` for darwin
    - For example: `nix-channel --add https://nixos.org/channels/nixpkgs-24.05-darwin nixos`
  - Add the main channel and call it `nixos`
  - Add the unstable channel and call it `unstable`
  - Add home-manager

### Maintenance

- Update channels: `nix-channel --update`
- (Optional for darwin) `nix-channel --update darwin`
- Darwin: build/activate: `darwin-rebuild switch` (potentially requiring the `--impure` flag)
- Darwin: some machines (eg, eolus) use flakes and these require editing the flake to include the right nixpkgs version
- Update `nixpkgs` version: `nix-channel --add <new-version-url> nixpkgs`
- Format: `nixpkgs-fmt ./path/to/file`
- Garbage collect the store: `nix-collect-garbage` (`-d` to delete old profiles/generations for extra cleanup; see manpage)

#### Configuration
`man home-configuration.nix`
