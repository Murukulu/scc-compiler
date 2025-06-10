{
  description = "SCC Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
    let
      # --- Define outputs for aarch64-darwin ---
      darwinPkgs = nixpkgs.legacyPackages.aarch64-darwin;
      darwinSccPkg = darwinPkgs.stdenv.mkDerivation {
        pname = "scc";
        version = "0.1.0"; # Good practice to add a version

        meta = {
          description = "The Sai-Cyrus-Cassar compiler";
          platforms = [ "aarch64-darwin" ];
        };

        src = ./src; # Assumes flake.nix is in root, sources in ./src/

        nativeBuildInputs = [
          darwinPkgs.ocaml
          darwinPkgs.dune_3
        ];

        buildPhase = ''
          runHook preBuild
          echo "Building SCC for aarch64-darwin..."
          dune build @all
          runHook postBuild
        '';

        doCheck = true;
        checkPhase = ''
          runHook preCheck
          echo "Running SCC project tests on aarch64-darwin..."
          dune runtest --display=short --no-buffer
          runHook postCheck
        '';

        installPhase = ''
          runHook preInstall
          mkdir -p $out/bin
          # This assumes 'scc.exe' is in _build/default/ after `dune build`
          # Please double-check this path relative to your `src` directory root.
          cp _build/default/scc.exe $out/bin/scc
          runHook postInstall
        '';
      };

      # --- Define outputs for x86_64-linux (Example for CI) ---
      # You can copy the block above and change the system string if you need to support other systems
      # linuxPkgs = nixpkgs.legacyPackages.x86_64-linux;
      # linuxSccPkg = darwinSccPkg.override { pkgs = linuxPkgs; stdenv = linuxPkgs.stdenv; };

    in
    {
      # --- Expose outputs for aarch64-darwin ---
      packages.aarch64-darwin.default = darwinSccPkg;
      checks.aarch64-darwin.default = darwinSccPkg;
      devShells.aarch64-darwin.default = darwinPkgs.mkShell {
        name = "scc-dev-shell-aarch64-darwin";
        packages = [
          darwinPkgs.ocaml
          darwinPkgs.dune_3
        ];
        inputsFrom = [ darwinSccPkg ];
        shellHook = ''
          echo "Entered SCC OCaml development environment for aarch64-darwin."
        '';
      };

      # --- Expose outputs for x86_64-linux (Example for CI) ---
      # packages.x86_64-linux.default = linuxSccPkg;
      # checks.x86_64-linux.default = linuxSccPkg;
      # devShells.x86_64-linux.default = linuxPkgs.mkShell { ... };
    };
}
