{ config, pkgs, lib, ... }:
{
  services.immich.enable = true;
  services.immich.port = 2283;
  services.caddy = {
    virtualHosts."immich.nix-services.phonkd.net".extraConfig = ''
      reverse_proxy 127.0.0.1:2283
    '';
  };
}
