{
  description = "SCC Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
  nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed (system: 
    let 
      pkgs = nixpkgs.legacyPackages.${system};

      sccPkg = 
         pkgs.stdenv.mkDerivation {
          meta = {
            description = "The Sai-Cyrus-Cassar compiler";
          };
          name = "scc";
          src = ./src;
          buildInputs = [
            pkgs.ocaml
            pkgs.dune_3
          ];
          buildPhase = ''
            runHook preBuild
            dune build @all
            runHook postBuild
          '';
          doCheck = true;
          checkPhase = ''
            runHook preCheck
            echo "Running project tests"
            dune runtest
            runHook postCheck
          '';
          installPhase = ''
            runHook preInstall
            mkdir -p $out/bin
            cp ./src/_build/default/scc.exe $out/bin/scc
            runHook postInstall 
          '';
        };
    in
    {
        devShells.${system}.default = pkgs.mkShell {
          name = "ocaml-dev-shell-${system}";
          buildInputs = [
            pkgs.ocaml
            pkgs.dune_3
          ];

          shellHook = ''
            echo "Entered OCaml development environment for ${system}."
          '';
        };

        # Flake build
        packages.default = sccPkg;

        # Specific checks output
        checks.default = sccPkg;
    }
  );
}
