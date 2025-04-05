{ config, pkgs, ... }:
{
  services.caddy = {
    package = pkgs.caddy.withPlugins {
        plugins = [ "github.com/caddy-dns/cloudflare" ];
        #hash = "sha256-F/jqR4iEsklJFycTjSaW8B/V3iTGqqGOzwYBUXxRKrc=";
      };
    enable = true;
    virtualHosts."vw.nix-services.phonkd.net".extraConfig = ''
      reverse_proxy :8222
    '';
  };
}
