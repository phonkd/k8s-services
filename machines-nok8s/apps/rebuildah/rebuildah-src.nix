{ pkgs ? import <nixpkgs> {} }:
pkgs.stdenv.mkDerivation {
  name = "nix-experiment";
  src = pkgs.fetchurl {
    url = "https://github.com/phonkd/nix-experiment/releases/download/0.3.1/rebuild-wrapper";
    sha256 = "sha256-rZF9IGT0pSZ1fA7W6gY7LvD846VlB3aqHGz7Ac47vow=";
  };
  phases = ["installPhase" "patchPhase"];
  installPhase = ''
    #tar -xzf $src
    mkdir -p $out/bin
    cp $src $out/bin/nix-experiment
    chmod +x $out/bin/nix-experiment
  '';
}
