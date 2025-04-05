{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    git
  ];
  virtualisation.fileSystems.ext4.autoResize
}
