# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib,... }:

{
  k8s.kubeMasterIP = "192.168.90.201";
  #k8s.kubeMasterHostname = "mykube.local";
  #k8s.kubeMasterAPIServerPort = 6443;
  #services.kubernetes.kubelet.cni.packages = lib.mkForce [
  #    pkgs.cni-plugins
      #pkgs.cni-plugin-flannel
  #];
  imports =
    [ # Include the results of the hardware scan.
      ../base-k8s-worker.nix
      ../../../machine-base/base.nix
      ../../../machine-base/base-hardware-configuration.nix
      ./network.nix
    ];

}
