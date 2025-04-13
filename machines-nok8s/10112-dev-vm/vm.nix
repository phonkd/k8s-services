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
    neofetch
    jq
    yq
    tree
    ipcalc
    nixd
  ];
  sops.secrets.teleport_authkey = {
    owner = "root";
    key = "teleport_authkey";
  };
  services.teleport.enable = true;
  services.teleport.settings = {
    version = "v3";
    teleport = {
      nodename = "nixvm";
      # advertise_ip = "192.168.90.187";
      auth_token = "${builtins.readFile config.sops.secrets."teleport_authkey".path}";
      #auth_servers = [ "freakedyproxy.teleport.phonkd.net" ];
      proxy_server = "teleport.phonkd.net:443";
    };
    ssh_service = {
      enabled = true;
      labels = {
        #role = "client";
        type = "node";
      };
    };
    proxy_service.enabled = false;
    auth_service.enabled = false;
    ## sops key cant be used with remote build atm

  };
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;
}
