{ config, pkgs, ... }:
{
  services.vaultwarden.enable = true;
  services.caddy = {
    virtualHosts."vw.nix-services.phonkd.net".extraConfig = ''
      reverse_proxy :8222
    '';
  };
}
