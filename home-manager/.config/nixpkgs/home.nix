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

  home.packages = [
    pkgs.alacritty
    pkgs.htop
    pkgs.zsh
    pkgs.oh-my-zsh
    pkgs.nodejs-17_x
    pkgs.discord
    # nix formatter
    pkgs.nixpkgs-fmt
    # backlight brightness via i3
    pkgs.brightnessctl
  ];

  home.sessionPath = [ "$HOME/.cargo/bin" ];

  home.stateVersion = "21.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
