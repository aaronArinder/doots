{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, flake-utils, nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = (import nixpkgs) {
          inherit system;
        };

        baseBuildInputs = [
            pkgs.openssl 
            # allows packages to find out about other packages, used by openssl-dev (see docs)
            pkgs.pkg-config 
            pkgs.llvmPackages_latest.llvm
            pkgs.llvmPackages_latest.bintools
            pkgs.llvmPackages_latest.lld

        ];

        nativeBuildInputs = if system == "aarch64-darwin" 
          then [ 
            baseBuildInputs
            pkgs.darwin.apple_sdk.frameworks.CoreServices
            pkgs.darwin.apple_sdk.frameworks.CoreFoundation
            pkgs.darwin.apple_sdk.frameworks.Foundation
            pkgs.darwin.apple_sdk.frameworks.Security
            pkgs.darwin.apple_sdk.frameworks.SystemConfiguration
            pkgs.fixDarwinDylibNames
          ]
          else [
            baseBuildInputs
          ];

      in rec {
        # For `nix develop` (optional, can be skipped):
        devShell = pkgs.mkShell {
          shellHook = ''
            # setting secrets and so on
          '';

          nativeBuildInputs = nativeBuildInputs; 

          buildInputs = [
            pkgs.markdownlint-cli
          ];
        };
      }
    );
}
