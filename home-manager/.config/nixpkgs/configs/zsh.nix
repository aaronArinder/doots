{ pkgs, ... }:

{

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;

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

    localVariables = {
      EDITOR = "nvim";
      DISABLE_KUBE_PS1 = true;
      HELM_EXPERIMENTAL_OCI = 1;
    };
  };
}
