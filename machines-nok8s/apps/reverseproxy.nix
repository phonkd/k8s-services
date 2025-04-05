{ config, pkgs, ... }:
{
  services.caddy = {
    package = pkgs.unstable.caddy.withPlugins {
      plugins = [ "github.com/caddy-dns/cloudflare@latest" ];
      hash = "sha256-YYpsf8HMONR1teMiSymo2y+HrKoxuJMKIea5/NEykGc=";
    };
    enable = true;
    virtualHosts."vw.nix-services.phonkd.net".extraConfig = ''
      reverse_proxy :8222
    '';
  };
}
