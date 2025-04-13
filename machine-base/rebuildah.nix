{ config, inputs, pkgs, ... }:
{
  imports =
    [
      "${builtins.fetchTarball {
        url = "https://github.com/phonkd/nix-experiment/releases/download/0.1/nix-experiment-0.1-linux-amd64.tar.gz";
      }}/rebuild-wrapper
    ];
}
