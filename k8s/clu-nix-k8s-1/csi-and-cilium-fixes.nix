# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
   # Proxmox CSI + Cilium stuff
  services.kubernetes = {
    kubelet.extraOpts = "--fail-swap-on=false --node-labels=topology.kubernetes.io/region=idk --node-labels=topology.kubernetes.io/zone=wamluck";
    flannel.enable = false;
    kubelet.cni.configDir = "/var/lib/kubernetes/cni/net.d"; # unsure if this is needed
  };
  # packages for administration tasks
  environment.systemPackages = with pkgs; [
    kompose
    kubectl
    kubernetes
    openiscsi
  ];
  services.kubernetes.proxy.enable = false;
  services.kubernetes.kubelet.cni.packages = lib.mkForce [
    pkgs.cni-plugins
    #pkgs.cni-plugin-flannel
  ];
  networking.usePredictableInterfaceNames = false;
}
