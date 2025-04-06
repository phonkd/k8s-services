{ config, pkgs, ... }:
{
  services.vaultwarden = {
    enable = true;
    config = {
      DOMAIN = "https://vw.nix-services.phonkd.net/";
    };
  };
  services.caddy = {
    virtualHosts."vw.nix-services.phonkd.net".extraConfig = ''
      reverse_proxy :8000
    '';
    virtualHosts."*.nixk8s.phonkd.net".extraConfig = ''
      reverse_proxy https://192.168.90.231:443
    '';
  };
}
