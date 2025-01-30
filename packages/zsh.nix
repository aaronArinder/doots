{ pkgs, ... }:

let
  global  = import ../constants.nix;
in
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;


    history = {
      ignoreDups = true;
    };


    oh-my-zsh = {
      enable = true;
      theme = "agnoster";

      plugins = [
        "git"
      ];

    };
  };
}

