# useful: man home-configuration.nix

{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Aaron Arinder";
    userEmail = "aaronarinder@protonmail.com";

    delta = {
      enable = true;
    };

    extraConfig = {
      core = {
        editor = "nvim";
      };

      init = {
        defaultBranch = "trunk";
      };

      pull = {
        rebase = false;
      };

      help = {
        autocorrect = 1;
      };
    };
  };

}
