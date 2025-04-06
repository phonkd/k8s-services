{ config, pkgs, ... }:
{
  services.caddy = {
    package = pkgs.unstable.caddy.withPlugins {
      plugins = [ "github.com/caddy-dns/cloudflare@v0.0.0-20250228175314-1fb64108d4de" ];
      hash = "sha256-YYpsf8HMONR1teMiSymo2y+HrKoxuJMKIea5/NEykGc=";
    };
    enable = true;
    globalConfig = ''
      acme_dns cloudflare ${builtins.readFile "/run/secrets/cfapikey"}
    '';
  };
}
