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

      help = {
        autocorrect = 1;
      };
    };
  };

}
