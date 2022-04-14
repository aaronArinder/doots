# man home-configuration.nix

{ config, pkgs, ... }:

{
  imports = [
    ./configs/alacritty.nix
    ./configs/git.nix
    ./configs/zsh.nix
    ./configs/i3.nix
    ./configs/polybar.nix
  ];

  home.username = "aaron";
  home.homeDirectory = "/home/aaron";

  nixpkgs.config = {
    allowUnfree = true;
  };

  home.packages = with pkgs; [
    alacritty
    htop
    zsh
    oh-my-zsh
    nodejs-17_x
    discord
    # nix formatter
    nixpkgs-fmt
    # backlight brightness via i3
    brightnessctl
    k9s
  ];

  home.sessionPath = [ "$HOME/.cargo/bin" ];

  home.stateVersion = "21.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
