{ config, pkgs, ... }:
{
  sops.secrets."ocis.yaml" = {
      format = "yaml";
      sopsFile = ../121-nix-services/secrets/ocis-secret.yaml;
      key = "";
      mode = "0660";
      group = "ocis";
      owner = "ocis";
  };
  ## above part is for loading config as secret
  services.ocis = {
    enable = true;
    #address = "127.0.0.1";
    url = "https://localhost:9200";
    configDir = "/run/secrets";
    environment = {
      OCIS_INSECURE = "true";
      CS3_ALLOW_INSECURE = "true";
      TLS_SKIP_VERIFY_CLIENT_CERT = "true";
      OCIS_INSECURE_BACKENDS = "true";
      IDP_ISS = "https://localhost:9200";
    };
  };
  services.caddy = {
    virtualHosts."ocis.nix-services.phonkd.net".extraConfig = ''
      reverse_proxy {
        to localhost:9200
        header_up Host {.reverse_proxy.upstream.host}
        transport http {
          tls
          tls_insecure_skip_verify
        }
      }
    '';
  };
}
