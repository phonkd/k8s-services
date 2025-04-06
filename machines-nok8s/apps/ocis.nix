{ config, pkgs, ... }:
{
  services.ocis = {
    enable = true;
    address = "ocis.nix-services.phonkd.net";
    environment = {
      OCIS_JWT_SECRET = "${builtins.readFile config.sops.secrets."kek/ocisjwt".path}";
    };
  };
  services.caddy = {
    virtualHosts."ocis.nix-services.phonkd.net".extraConfig = ''
      reverse_proxy :9200
    '';
  };
}
