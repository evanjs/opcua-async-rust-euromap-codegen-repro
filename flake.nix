{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    fenix.url = "github:nix-community/fenix";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils, fenix }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

	toolchain = with fenix.packages.${system}; combine [
          minimal.cargo
          minimal.rustc
          targets.${target}.nightly.rust-std
        ];

      in
      {
        devShell = with pkgs; mkShell {
          buildInputs = [ cargo rustc rustfmt pre-commit rustPackages.clippy ];
          RUST_SRC_PATH = rustPlatform.rustLibSrc;
	    shellHook = ''
	      export PATH="$PATH:$HOME/.cargo/bin";
	    '';
        };
      }
    );
}
