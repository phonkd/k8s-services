{ config, pkgs, lib, ... }:
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


  config = {
    services.kubernetes = {
      api = "https://${kubeMasterHostname}:${toString kubeMasterAPIServerPort}";
      roles = ["node"];
      masterAddress = kubeMasterHostname;
      easyCerts = true;

      # point kubelet and other services to kube-apiserver
      kubelet.kubeconfig.server = "https://${kubeMasterHostname}:${toString kubeMasterAPIServerPort}";
      apiserverAddress = "https://${cfg.kubeMasterHostname}:${toString cfg.kubeMasterAPIServerPort}";

      # use coredns
      addons.dns.enable = true;

      # needed if you use swap
      kubelet.extraOpts = "--fail-swap-on=false";
    };

  # resolve master hostname
    networking.extraHosts = "${kubeMasterIP} ${kubeMasterHostname}";
  # packages for administration tasks
    environment.systemPackages = with pkgs; [
      kompose
      kubectl
      kubernetes
    ];
  };
}
