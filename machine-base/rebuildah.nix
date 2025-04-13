{ pkgs ? import <nixpkgs> {} }:
pkgs.stdenv.mkDerivation {
  name = "nix-experiment";
  src = pkgs.fetchurl {
    url = "https://github.com/phonkd/nix-experiment/releases/download/0.1/nix-experiment-0.1-linux-amd64.tar.gz";
    sha256 = "sha256-Aht4ywR1fo5PQ1clBA4K9dXdGlYLgvkYpGRxu8tnV8w=";
  };
  phases = ["installPhase" "patchPhase" "unpackPhase"];
  unpackPhase = ''
      mkdir source
      tar -xzf $src -C source
    '';
  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/nix-experiment
    chmod +x $out/bin/nix-experiment
  '';
}
