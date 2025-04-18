# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).s

{ ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./network.nix
      ./rebuildah.nix
      ./vm.nix
      ../apps/sops.nix
      ../../machine-base/base.nix
      ../../machine-base/ssh.nix
      ../../machine-base/base-hardware-configuration.nix
      ../apps/teleport.nix
      ../apps/sops.nix
    ];
  sops.secrets.teleport_authkey = {};
}
