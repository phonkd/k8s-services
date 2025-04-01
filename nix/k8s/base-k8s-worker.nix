{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.k8s;
in
{
  options.k8s = {
    kubeMasterIP = mkOption {
      type = types.str;
      default = "127.0.0.1";
      description = "IP address of the Kubernetes master node.";
    };

    kubeMasterHostname = mkOption {
      type = types.str;
      default = "apinix.kube";
      description = "Hostname of the Kubernetes master node.";
    };

    kubeMasterAPIServerPort = mkOption {
      type = types.port;
      default = 6443;
      description = "Port number for the Kubernetes API server.";
    };
  };

  #api = "https://${cfg.kubeMasterHostname}:${toString cfg.kubeMasterAPIServerPort}";
  config = {
    services.kubernetes = {
      roles = ["node"];
      masterAddress = cfg.kubeMasterHostname;
      easyCerts = true;

      # point kubelet and other services to kube-apiserver
      kubelet.kubeconfig.server = "https://${cfg.kubeMasterHostname}:${toString cfg.kubeMasterAPIServerPort}";
      apiserverAddress = "https://${cfg.kubeMasterHostname}:${toString cfg.kubeMasterAPIServerPort}";

      # use coredns
      addons.dns.enable = true;

      # needed if you use swap
      kubelet.extraOpts = "--fail-swap-on=false --node-labels=topology.kubernetes.io/region=idk --node-labels=topology.kubernetes.io/zone=wamluck";
    };

  # resolve master hostname
    networking.extraHosts = "${cfg.kubeMasterIP} ${cfg.kubeMasterHostname}";
  # packages for administration tasks
    environment.systemPackages = with pkgs; [
      kompose
      kubectl
      kubernetes
      openiscsi
    ];
  };
}
