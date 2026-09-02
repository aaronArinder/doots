{ pkgs, ... }:

let
  colors  = import ./colors.nix;
in
{

  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        opacity = 1.00;
      };
      cursor = {
        style = "Block";
      };
      font = {
        normal = {
          family = "FiraCode Nerd Font Mono";
          style = "Regular";
        };
        bold = {
          family = "FiraCode Nerd Font Mono";
          style = "Bold";
        };
        italic = {
          family = "Menlo";
          style = "Italic";
        };
        size = 12;
      };
      colors = colors.dracula;
    };
  };
}
