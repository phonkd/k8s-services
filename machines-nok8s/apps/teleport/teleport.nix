{ config, pkgs, ... }:
let
  vmhostname = config.networking.hostName;
in
{
  sops.secrets.teleport_authkey = {};
  services.teleport.enable = true;
  services.teleport.settings = {
    version = "v3";
    teleport = {
      nodename = "${vmhostname}";
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
    ## sops key cant  be used with remote build atm

  };
}
