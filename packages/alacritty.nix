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
          family = "Fira Code";
          style = "Regular";
        };
        bold = {
          family = "Fira Code";
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
