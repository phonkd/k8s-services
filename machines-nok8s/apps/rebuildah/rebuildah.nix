# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’)

{ config, pkgs, ... }:
let
  nix-experiment = import ./rebuildah-src.nix { inherit pkgs; };
in
{
  environment.systemPackages = with pkgs; [
    nix-experiment
  ];
  sops.secrets.ntfytoken = {
    sopsFile = ./secrets/secrets.yaml;
  };
}
