# man home-configuration.nix

{ config, pkgs, ... }:

let
  unstable = import <unstable> {};
in
{

  imports = [
    ./configs/alacritty.nix
    ./configs/git.nix
    ./configs/zsh.nix
    # need to toggle between darwin/linux
    ./configs/i3.nix
    ./configs/polybar.nix
  ];

  home.username = "aaronarinder";
  home.homeDirectory = "/Users/aaronarinder";

  nixpkgs.config = {
    allowUnfree = true;
  };

  home.packages = with pkgs; [
    unstable.neovim
    alacritty
    nerdfonts
    fira-code
    #arandr
    htop
    zsh
    oh-my-zsh
    #nodejs-17_x
    # need to toggle between darwin/linux
    discord
    # nix formatter
    nixpkgs-fmt
    # backlight brightness via i3
    #brightnessctl
    #k9s
    #zoom-us
    #spotify
    ripgrep
    fd
  ];

  home.sessionPath = [ "$HOME/.cargo/bin" ];

  home.stateVersion = "21.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
