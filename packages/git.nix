{ pkgs, ... }:

let
  global  = import ./constants.nix;
in
{
  programs.git = {
    enable = true;
    userName = global.name.human_readable;
    userEmail = global.email;

    delta = {
      enable = true;
    };

    extraConfig = {
      core = {
        editor = global.editor;
      };

      init = {
        defaultBranch = "trunk";
      };

      pull = {
        rebase = true;
      };

      help = {
        autocorrect = 1;
      };
    };
  };

}
