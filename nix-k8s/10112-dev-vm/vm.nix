{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    neovim
    git
    btop
    zsh
    oh-my-zsh
    fzf
    bat
    nixos-generators
    neofetch
    jq
    yq
    tree
    ipcalc
    nixd
  ];
  services.teleport.enable = true;
  services.teleport.settings = {
    teleport = {
      nodename = "nixvm";
      # advertise_ip = "192.168.90.187";
      auth_token = "${config.sops.secrets."teleport_authkey".path}";
      auth_servers = "teleport.phonkd.net";
    };
    ssh_service = {
      enabled = true;
      labels = {
        role = "client";
      };
    };
    proxy_service.enabled = false;
    auth_service.enabled = false;
  };
}
