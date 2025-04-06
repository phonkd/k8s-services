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
  };
}
