{ config, pkgs, ... }:
{
  services.vaultwarden.enable = true;
  environment.systemPackages = with pkgs; [
    vim
    git
  ];
}
