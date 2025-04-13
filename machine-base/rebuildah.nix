{ pkgs ? import <nixpkgs> {} }:
pkgs.stdenv.mkDerivation {
  name = "nix-experiment";
  src = pkgs.fetchurl {
    url = "https://github.com/phonkd/nix-experiment/releases/download/0.1/nix-experiment-0.1-linux-amd64.tar.gz";
    #sha256 = "0ldh303r5063kd5y73hhkbd9v11c98aki8wjizmchzx2blwlipy7";
  };
  phases = ["installPhase" "patchPhase"];
  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/nix-experiment
    chmod +x $out/bin/nix-experiment
  '';
}
