{
  description = "A clean, multi-system OCaml flake for the SCC compiler";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "aarch64-darwin" "x86_64-linux" ];
      perSystem = pkgs:
        let
          # Add OCaml libraries.
          ocamlLibs = with pkgs.ocamlPackages; [
            core
            core_unix
            findlib # Necessary...
            ocaml-lsp
          ];

          # Add build tools and dev utilities (LSP, formatters, etc.).
          buildTools = with pkgs; [
            ocaml
            dune_3
            zsh
          ];
        in
        {
          # This defines the package derivation for the compiler.
          packages.default = pkgs.stdenv.mkDerivation {
            pname = "scc";
            version = "0.1.0";
            src = ./src; # Assumes source code is in ./src

            nativeBuildInputs = buildTools;
            buildInputs = ocamlLibs;

            meta = {
              description = "The Sai-Cyrus-Cassar compiler";
              platforms = pkgs.lib.platforms.all; # Works on any system defined above
            };

            # Standard dune build phase
            buildPhase = ''
              runHook preBuild
              dune build @all
              runHook postBuild
            '';

            # Standard dune test phase
            doCheck = true;
            checkPhase = ''
              runHook preCheck
              dune runtest --display=short --no-buffer
              runHook postCheck
            '';

            # Use `dune install` for a more robust installation
            installPhase = ''
              runHook preInstall
              dune install --prefix=$out --locallibdir=$out/lib
              runHook postInstall
            '';
          };

          # This defines the development shell using the most basic and compatible method.
          devShells.default = pkgs.mkShell {
            name = "scc-dev-shell";

            # By putting all tools and libraries directly into `buildInputs`,
            # we rely on Nix's most fundamental mechanism for building an environment.
            # This avoids any helper functions that may be missing or incompatible.
            buildInputs = buildTools ++ ocamlLibs;

            shellHook = ''
              echo "Entered SCC OCaml development environment."
              export PATH=${pkgs.zsh}/bin:$PATH
              export SHELL=${pkgs.zsh}/bin/zsh
              exec ${pkgs.zsh}/bin/zsh --login
            '';
          };
        };
      # Generate the outputs for each supported system using the function above.
      flakeOutputs = nixpkgs.lib.foldl'
        (final: system:
          let
            pkgs = nixpkgs.legacyPackages.${system};
            systemOutputs = perSystem pkgs;
          in
          nixpkgs.lib.recursiveUpdate final {
            packages.${system} = systemOutputs.packages;
            devShells.${system} = systemOutputs.devShells;
            checks.${system}.default = systemOutputs.packages.default;
          })
        { }
        supportedSystems;

    in
    flakeOutputs;
}
