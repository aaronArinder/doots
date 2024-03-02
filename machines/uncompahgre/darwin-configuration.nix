# man 5 configuration.nix

{ config, pkgs, ... }:

let
  unstable = import <unstable> {};
  global  = import ../../constants.nix;
in
{

  imports = [
    # Makes `home-manager` option available
    <home-manager/nix-darwin>
    #../../packages/alacritty.nix
    #../../packages/git.nix
    #../../packages/zsh.nix
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
      alacritty
      nerdfonts
      fira-code
      htop
      zsh
      oh-my-zsh
      # nix formatter
      nixpkgs-fmt
      ripgrep
      fd
      exercism
      nixd
    ];

    home.sessionPath = [ "$HOME/.cargo/bin" ];

    # The state version is required and should stay at the version you
    # originally installed.
    home.stateVersion = "23.11";

    # Import package configurations after _both_ home-manager and home.packages
    imports = [
      ../../packages/alacritty.nix
      ../../packages/git.nix
      #../../packages/zsh.nix
    ];
  };



  ####################
  # System-wide config
  ####################
  environment.systemPackages = [pkgs.neovim];

  environment.pathsToLink = [
    "~/.non-nix-bins/ngrok"
  ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

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
