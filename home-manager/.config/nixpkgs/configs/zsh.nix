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


    # these might need to be set in configuration.nix; don't seem
    # to be picking up
    localVariables = {
      EDITOR = "nvim";
      DISABLE_KUBE_PS1 = true;
      HELM_EXPERIMENTAL_OCI = 1;
    };

    oh-my-zsh = {
      enable = true;

      plugins = [
        "git"
      ];

      theme = "agnoster";
    };

    initExtra = ''
        #export PATH=/Users/aaronarinder/Downloads/google-cloud-sdk 3/bin:$PATH
        #PROMPT='%{%f%b%k%}%K{red}$(print_time_gained)%k$(build_prompt)'
        prompt_context() {}

        # The next line updates PATH for the Google Cloud SDK.
        if [ -f '/Users/aaronarinder/Downloads/google-cloud-sdk 3/path.bash.inc' ]; then . '/Users/aaronarinder/Downloads/google-cloud-sdk 3/path.bash.inc'; fi

        # The next line enables shell command completion for gcloud.
        if [ -f '/Users/aaronarinder/Downloads/google-cloud-sdk 3/completion.bash.inc' ]; then . '/Users/aaronarinder/Downloads/google-cloud-sdk 3/completion.bash.inc'; fi

        # allows for fns in prompt
        setopt PROMPT_SUBST
        print_time_gained(){ pt -p | tr -d '"'}
        PROMPT='%{%f%b%k%}%K{red}$(print_time_gained)%k$(build_prompt)'

        # https://www.zsh.org/mla/users/2007/msg00944.html
        TMOUT=3
        TRAPALRM() {
            zle reset-prompt
        }

    '';

  };
}

