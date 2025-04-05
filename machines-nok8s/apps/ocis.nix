{ config, pkgs, ... }:
{
  services.ocis = {
    enable = true;
    address = "ocis.nix-services.phonkd.net";
  };
  services.caddy = {
    virtualHosts."ocis.nix-services.phonkd.net".extraConfig = ''
      reverse_proxy :9200
    '';
  };
}
