# man 5 configuration.nix

{ config, pkgs, ... }:

let
  unstable = import <unstable> {};
  global  = import ../../constants.nix;
in
{

  imports = [
    # Makes `home-manager` option available; keep this higher in the order, required for
    # home-manager section below to work; see the comment on the import statement there
    <home-manager/nix-darwin>
  ];

  ##################
  # User-wide config
  ##################
  users.users.aaronarinder = {
    name = global.name.host;
    home = "/Users/aaronarinder";
  };

  home-manager.users.aaronarinder = {
    home.packages = with pkgs; [
      unstable.neovim
      # currently colliding with rustaceanvim; add back in when collision fixed
      #unstable.vimPlugins.vim-plug
      unstable.vimPlugins.rustaceanvim
      alacritty
      # The monolithic `nerdfonts` package was split into the nerd-fonts.*
      # namespace. Only FiraCode is needed -- see packages/alacritty.nix.
      nerd-fonts.fira-code
      fira-code
      htop
      zsh
      oh-my-zsh
      nixpkgs-fmt
      ripgrep
      fd
      exercism

      # Language servers + formatters for neovim. These used to be installed
      # imperatively by Mason; they live here now so all machines agree and
      # the versions are pinned by the channel. Anything added to the
      # `servers` table in neovim/.config/nvim/init.lua needs a package here.
      nixd
      unstable.typescript-language-server
      pyright
      lua-language-server
      terraform-ls

      # conform.nvim formatters (formatters_by_ft in init.lua)
      stylua
      isort
      black
    ];

    home.sessionPath = [ "$HOME/.cargo/bin" ];

    # The state version is required and should stay at the version you
    # originally installed.
    home.stateVersion = "23.11";

    # Import package configurations after _both_ home-manager and home.packages
    imports = [
      ../../packages/alacritty.nix
      ../../packages/git.nix
      ../../packages/zsh.nix
    ];
  };



  ####################
  # System-wide config
  ####################
  environment.systemPackages = [pkgs.neovim];

  environment.pathsToLink = [
    "~/.non-nix-bins/ngrok"
  ];

  # nix-darwin >= 25.05 manages nix-daemon unconditionally when nix.enable is
  # on, so services.nix-daemon.enable no longer exists.
  nix.package = pkgs.nix;

  # As of nix-darwin 25.05 activation runs as root, and the options that used
  # to apply to whoever ran darwin-rebuild now apply to this user instead.
  system.primaryUser = global.name.host;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Allow unfree packages to be used
  nixpkgs.config.allowUnfree = true;

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
