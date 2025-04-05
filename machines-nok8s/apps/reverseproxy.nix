{ config, pkgs, ... }:
let
  unstable = import <nixos-unstable> {};
in
{
  services.caddy = {
    package = unstable.caddy.withPlugins {
        plugins = [ "github.com/caddy-dns/powerdns@v1.0.1" ];
        hash = "sha256-F/jqR4iEsklJFycTjSaW8B/V3iTGqqGOzwYBUXxRKrc=";
      };
    enable = true;
    virtualHosts."vw.nix-services.phonkd.net".extraConfig = ''
      reverse_proxy :8222
    '';
  };
}
