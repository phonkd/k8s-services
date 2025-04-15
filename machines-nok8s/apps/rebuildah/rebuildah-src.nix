{ pkgs ? import <nixpkgs> {} }:
pkgs.stdenv.mkDerivation {
  name = "nix-experiment";
  src = pkgs.fetchurl {
    url = "https://github.com/phonkd/nix-experiment/releases/download/0.3.1/rebuild-wrapper";
    sha256 = "";
  };
  # sha256-f3fkL5k6QAvfFMbrwFaF3p2/oqQXN/R6FM15gWbO9Ow
  phases = ["installPhase" "patchPhase"];
  installPhase = ''
    #tar -xzf $src
    mkdir -p $out/bin
    cp $src $out/bin/nix-experiment
    chmod +x $out/bin/nix-experiment
  '';
}
