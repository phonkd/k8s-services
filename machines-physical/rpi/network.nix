# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  networking.defaultGateway = "192.168.1.1";
  networking.nameservers = [ "192.168.1.1" ];
  networking.hostName = "pi4"; # Define your hostname.
  #networking.networkmanager.dhcp = "dhcpcd";
  # Groups:
  programs.ssh.startAgent = true; #ssh-agent
  networking.firewall.enable = false;
  networking.interfaces.end0.ipv4.addresses = [ {
      address = "192.168.1.123";
      prefixLength = 24;
  } ];
  # networking.interfaces.wlan0.ipv4.addresses = [ {
  #     address = "192.168.1.122";
  #     prefixLength = 24;
  # } ];
  networking.networkmanager.enable = true;
    # Prevent host becoming unreachable on wifi after some time.
  networking.networkmanager.wifi.powersave = false;
}
