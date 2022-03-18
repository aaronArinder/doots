# Setup
## Git/GitHub

Generate an ssh key and copy/paste its pub to GitHub. If the default shell doesn't easily copy/paste, just open alacritty (should be available if you're on a nixOS system using one of the nixOS configs).

```
ssh-keygen -t NAME_HERE -b 4096 -C "aaronarinder@protonmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_NAME_HERE
```

-[] config for not having to always set default branch named (git config --global init.defaultBranch trunk)

## Nix

There isn't great LSP/formatting support in neovim yet; so, use the following to format:

```
nixpkgs-fmt ./path/to/file
```

### `/etc/nixos/configuration`
### Unstable channel
Some packages need to come from the unstable channel (e.g., as of writing, neovim v0.6). Make the unstable channel available system-wide:

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

### Home manager
#### Installation
Install [home-manager](https://nix-community.github.io/home-manager/index.html#sec-install-standalone)

If `NIX_ENV` isn't available, get it into the current session using:

```
export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
. ~/.nix-profile/etc/profile.d/hm-session-vars.sh
```

#### Configuration
`man home-configuration.nix`

#### Generating sha256

For home-manager packages (e.g., from GitHub), generate the sha256 by grabbing the tar and:

```
sha256sum blah.tar.gz
```
or
```
shasum -a 256 blah.tar.gz

```

## Shell
### zsh
-[] Figure out better alias strategy (move what's currently in zshrc)


