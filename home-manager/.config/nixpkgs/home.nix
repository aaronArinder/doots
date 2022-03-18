{ config, pkgs, ... }:

{

  imports = [
    ./configs/alacritty.nix
    ./configs/git.nix
    ./configs/zsh.nix
  ];

  home.username = "aaron";
  home.homeDirectory = "/home/aaron";


  home.packages = [
    pkgs.alacritty
    pkgs.htop
    pkgs.zsh
    pkgs.oh-my-zsh
    pkgs.nodejs-17_x
    # nix formatter
    pkgs.nixpkgs-fmt
  ];

  home.stateVersion = "21.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
