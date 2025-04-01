{ config, pkgs, ... }:

{
  # Needed for Proxmox CSI
  systemd.tmpfiles.rules = [
    "d /var/lib/kubelet/plugins_registry 0755 root root -"
  ];
}
