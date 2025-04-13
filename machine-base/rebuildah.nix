{ pkgs ? import <nixpkgs> {} }:
pkgs.stdenv.mkDerivation {
  name = "nix-experiment";
  src = pkgs.fetchurl {
    url = "https://github.com/phonkd/nix-experiment/releases/download/0.1.1/rebuild-wrapper";
    sha256 = "sha256-hc6kUe7AV/p+c0VIyjum13ntWDaj+d4UuDlFde8NfY4=";
  };
  phases = ["installPhase" "patchPhase"];
  installPhase = ''
    tar -xzf $src
    mkdir -p $out/bin
    cp nix-experiment $out/bin/nix-experiment
    chmod +x $out/bin/nix-experiment
  '';
}
