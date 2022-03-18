{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
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

  programs.alacritty = {
    enable = true;
    settings = {
      #env: "xterm-256-color"
      window = {
        decoration = "none";
        # ternary on darwin for yabai/spacebar
        #  padding = {
        #    x: 10
        #    y: 10
        #  };
      };

      background_opacity = 1.00;
      cursor = {
        style = "Block";
      };

      font = {
        size = 10;
        use_thin_strokes = true;
      };

      # Dracula
      colors = {
        primary = {
          background = "#282a36";
          foreground = "#f8f8f2";
          bright_foreground = "#ffffff";
        };

        cursor = {
          text = "CellBackground";
          cursor = "CellForeground";
        };

        vi_mode_cursor = {
          text = "CellBackground";
          cursor = "CellForeground";
        };

        search = {
          matches = {
            foreground = "#44475a";
            background = "#50fa7b";
          };
          focused_match = {
            foreground = "#44475a";
            background = "#ffb86c";
          };
          bar = {
            background = "#282a36";
            foreground = "#f8f8f2";
          };
        };

        hints = {
          start = {
            foreground = "#282a36";
            background = "#f1fa8c";
          };
          end = {
            foreground = "#f1fa8c";
            background = "#282a36";
          };
        };
        line_indicator = {
          foreground = "None";
          background = "None";
        };
        selection = {
          text = "CellForeground";
          background = "#44475a";
        };
        normal = {
          black = "#21222c";
          red = "#ff5555";
          green = "#50fa7b";
          yellow = "#f1fa8c";
          blue = "#bd93f9";
          magenta = "#ff79c6";
          cyan = "#8be9fd";
          white = "#f8f8f2";
        };
        bright = {
          black = "#6272a4";
          red = "#ff6e6e";
          green = "#69ff94";
          yellow = "#ffffa5";
          blue = "#d6acff";
          magenta = "#ff92df";
          cyan = "#a4ffff";
          white = "#ffffff";
        };
      };

      selection = {
        # This string contains all characters that are used as separators for
        # "semantic words" in Alacritty.
        semantic_escape_chars = ",│`|:\"' ()[]{}<>\t";
        # When true, selected text will be copied to the primary clipboard
        save_to_clipboard = true;
      };

      # Startup directory, unset or None for home directory
      working_directory = "None";
    };
  };

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

  home.stateVersion = "21.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
