# good resource for flakes: https://github.com/nmasur/dotfiles/blob/b282e76be4606d9f2fecc06d2dc8e58d5e3514be/flake.nix

{
  description = "nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-25.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Used for user packages and dotfiles
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows =
        "nixpkgs"; # Use system packages list where available
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nixpkgs-unstable, home-manager }:
  let
    configuration = { pkgs, ... }: {
      imports = [
        # Makes `home-manager` option available; keep this higher in the order, required for
        # home-manager section below to work; see the comment on the import statement there
        <home-manager/nix-darwin>
      ];

      users.users.aaron = {
        name = "aaron";
        home = "/Users/aaron";
      };

      home-manager.users.aaron = {
        home.packages = with pkgs; [
          neovim
          git
          alacritty
          #nerd-fonts
          nerd-fonts.fira-code
          htop
          zsh
          oh-my-zsh
          nixpkgs-fmt
          lua
          ripgrep

          # Language servers for neovim. Anything added to the `servers` table
          # in neovim/.config/nvim/init.lua needs a package here.
          typescript-language-server
          pyright
          lua-language-server
          terraform-ls
          rust-analyzer

          # conform.nvim formatters (formatters_by_ft in init.lua)
          stylua
          isort
          black
          rustfmt

          # nvim-lint linters (linters_by_ft in kickstart/plugins/lint.lua)
          markdownlint-cli

          # Rust toolchain. rust-analyzer finds the sysroot by shelling out to
          # rustc, and init.lua points its check command at clippy, so neither
          # is optional if diagnostics are meant to work.
          rustc
          cargo
          clippy
        ];


	# Get some rusty bins into the path
   	home.sessionPath = [ "$HOME/.cargo/bin" "$HOME/.local/bin" ];

	# nixpkgs' rustc doesn't ship the standard library sources in its
	# sysroot, so rust-analyzer can't resolve std without being pointed
	# at them.
	home.sessionVariables = {
	  RUST_SRC_PATH = "${pkgs.rustPlatform.rustLibSrc}";
	};

    	# The state version is required and should stay at the version you
    	# originally installed.
    	home.stateVersion = "24.11";

        imports = [
          /Users/aaron/doots/packages/alacritty.nix
          /Users/aaron/doots/packages/git.nix
          /Users/aaron/doots/packages/zsh.nix
        ];
      };

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Allow unfree packages to be used
      nixpkgs.config.allowUnfree = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."Aarons-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };
  };
}
