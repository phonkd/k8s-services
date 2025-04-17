{ config, pkgs, ... }:
{
  sops.secrets.cfapikey = {};
  services.caddy = {
    package = pkgs.unstable.caddy.withPlugins {
      plugins = [ "github.com/caddy-dns/cloudflare@v0.0.0-20250228175314-1fb64108d4de" ];
      hash = "sha256-YYpsf8HMONR1teMiSymo2y+HrKoxuJMKIea5/NEykGc=";
    };
    enable = true;
    globalConfig = ''
      acme_dns cloudflare ${builtins.readFile config.sops.secrets."cfapikey".path}
    '';
  };
  services.caddy = {
    virtualHosts."*.nixk8s.phonkd.net".extraConfig = ''
      reverse_proxy {
        to 192.168.90.231:443
        transport http {
            tls
            tls_insecure_skip_verify
        }
      }
    '';
  };




  services.teleport.enable = true;
  sops.secrets.teleport_authkey = {
      owner = "root";
      key = "teleport_authkey";
  };
  services.teleport.settings = {
    version = "v3";
    teleport = {
      nodename = "sopsnixstinkt";
      # advertise_ip = "192.168.90.187";
      auth_token = builtins.readFile config.sops.secrets."teleport_authkey".path;
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
