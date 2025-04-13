{ pkgs ? import <nixpkgs> {} }:
pkgs.stdenv.mkDerivation {
  name = "nix-experiment";
  src = pkgs.fetchurl {
    url = "https://github.com/user-attachments/files/19726034/rebuild-wrapper.tar.gz";
    sha256 = "sha256-Aht4ywR1fo5PQ1clBA4K9dXdGlYLgvkYpGRxu8tnV8w=";
  };
  phases = ["installPhase" "patchPhase"];
  installPhase = ''
    tar -xzf $src
    mkdir -p $out/bin
    cp nix-experiment $out/bin/nix-experiment
    chmod +x $out/bin/nix-experiment
  '';
}
