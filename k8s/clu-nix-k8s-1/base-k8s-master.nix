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

  config = {
    # resolve master hostname
    networking.extraHosts = "${cfg.kubeMasterIP} ${cfg.kubeMasterHostname}";



    services.kubernetes = {
      roles = ["master" "node"];
      masterAddress = cfg.kubeMasterHostname;
      apiserverAddress = "https://${cfg.kubeMasterHostname}:${toString cfg.kubeMasterAPIServerPort}";
      easyCerts = true;
      apiserver = {
        securePort = cfg.kubeMasterAPIServerPort;
        advertiseAddress = cfg.kubeMasterIP;
        allowPrivileged = true;
      };
      # use coredns
      addons.dns.enable = true;
    };
  };
}
