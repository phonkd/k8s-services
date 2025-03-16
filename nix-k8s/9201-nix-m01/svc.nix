# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    vim
    zsh
  ];
  # font
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ];
  })
  ];
  # def shell
  users.defaultUserShell = pkgs.zsh;
  # Groups:
  programs.ssh.startAgent = true; #ssh-agent
  networking.firewall.allowedTCPPorts = [80 443 6443];
}
