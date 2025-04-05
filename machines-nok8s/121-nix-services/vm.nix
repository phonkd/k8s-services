{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    git
  ];
  fileSystems.ext4.autoResize = true;
}
