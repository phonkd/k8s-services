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

  virtualisation.docker.enable = true;
  # Groups:
  users.users.phonkd.extraGroups = [ "docker" "video" ];
  programs.ssh.startAgent = true; #ssh-agent

  services.caddy = {
    enable = true;
    virtualHosts."*.k8s.phonkd.net".extraConfig = ''
        reverse_proxy http://192.168.90.160
        reverse_proxy http://192.168.90.160 {
            header_upstream Host {host}
            header_upstream X-Real-IP {remote}
            header_upstream X-Forwarded-For {remote}
            header_upstream X-Forwarded-Proto {scheme}
            transport http {
                tls
            }
        }
    '';
    virtualHosts."*.phonkd.net".extraConfig = ''
        reverse_proxy http://192.168.90.181
    '';
  };
  networking.firewall.allowedTCPPorts = [80 443];
}
