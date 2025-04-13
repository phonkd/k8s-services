{ pkgs ? import <nixpkgs> {} }:
pkgs.stdenv.mkDerivation {
  name = "nix-experiment";
  src = pkgs.fetchurl {
    url = "https://github.com/phonkd/nix-experiment/releases/download/0.2/rebuild-wrapper";
    sha256 = "sha256-5J58dEVAUHD28PMjXdCyb9rXvrS9ixYGK2D7fejI27M=";
  };
  phases = ["installPhase" "patchPhase"];
  installPhase = ''
    #tar -xzf $src
    mkdir -p $out/bin
    cp $src $out/bin/nix-experiment
    chmod +x $out/bin/nix-experiment
  '';
}
