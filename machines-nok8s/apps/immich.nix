{ config, pkgs, lib, ... }:
{
  services.immich.enable = true;
  services.caddy = {
    virtualHosts."immich.nix-services.phonkd.net".extraConfig = ''
      reverse_proxy :2283
    '';
  };
}
