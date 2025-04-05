{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    git
  ];
  fileSystems."/dev/sda1".autoResize = true;
}
