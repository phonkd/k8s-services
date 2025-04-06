{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    git
    sops
  ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # fileSystems."/dev/sda1".autoResize = true;
  # virtualisation.fileSystems."/dev/sda1".fsType = "ext4";
  sops.defaultSopsFile = ./secrets/secrets.yaml;
  sops.age.keyFile = /home/phonkd/.config/sops/age/keys.txt;
  sops.secrets.cfapikey = {};
  sops.secrets."kek/ocisjwt" = {};
  sops.secrets.maliggah = {
      format = "yaml";
      sopsFile = ./secrets/ocis-secret.yaml;
      key = "";
  };
}
