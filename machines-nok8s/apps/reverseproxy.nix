{ config, pkgs, ... }:
{
  services.caddy = {
    enable = true;
    virtualHosts."vw.nix-services.phonkd.net".extraConfig = ''
      reverse_proxy :8222
    '';
  };
}
