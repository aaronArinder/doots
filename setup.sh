export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}

home-manager switch

stow --target=$HOME neovim

# each machine would have a different stow command, but it will look
# like this:
# sudo stow --target=/etc/nixos machines/<machine>
