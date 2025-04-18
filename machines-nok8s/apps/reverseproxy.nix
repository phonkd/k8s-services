{ config, pkgs, lib, ... }:
let
  cfapikeytemp = if builtins.pathExists config.sops.secrets."cfapikey".path then
                    builtins.readFile config.sops.secrets."cfapikey".path
                  else
                    "default_auth_token_placeholder";
in
{
  sops.secrets.cfapikey = {};
  services.caddy = {
    package = pkgs.unstable.caddy.withPlugins {
      plugins = [ "github.com/caddy-dns/cloudflare@v0.0.0-20250228175314-1fb64108d4de" ];
      hash = "sha256-YYpsf8HMONR1teMiSymo2y+HrKoxuJMKIea5/NEykGc=";
    };
    enable = true;
    globalConfig = ''
      acme_dns cloudflare ${cfapikeytemp}
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
    virtualHosts."pve.nix-services.phonkd.net".extraConfig = ''
      reverse_proxy {
        to 192.168.1.46:8006
        transport http {
            tls
            tls_insecure_skip_verify
        }
      }
    '';
  };
}
