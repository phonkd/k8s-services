# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./svc.nix
      ./k8s.nix
    ];
  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nw01"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # Enable networking
  networking.networkmanager.dhcp = "internal";
  # Set your time zone.
  time.timeZone = "Europe/Zurich";
  i18n.defaultLocale = "en_US.UTF-8";
  services.xserver.xkb = {
    layout = "ch";
    variant = "";
  };
  console.keyMap = "sg";
  users.users.phonkd = {
    isNormalUser = true;
    description = "phonkd";
    extraGroups = [ "networkmanager" "wheel" ];
  };
  nixpkgs.config.allowUnfree = true;
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  networking.firewall.enable = true;
  system.stateVersion = "24.11"; # Did you read the comment?
  programs.zsh.enable = true;
  services.qemuGuest.enable = true;

  # IPS
  networking.interfaces.ens18.ipv4.addresses = [ {
      address = "192.168.90.201";
      prefixLength = 24;
  } ];
  networking.defaultGateway = "192.168.90.1";
  networking.nameservers = [ "192.168.90.1" ];
}
