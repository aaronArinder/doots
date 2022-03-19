{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {

      background_opacity = 1.00;
      cursor = {
        style = "Block";
      };

      font = {
        size = 8;
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
}
