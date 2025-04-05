# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;
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
  networking.firewall.enable = true;
  system.stateVersion = "24.11"; # Did you read the comment?
  services.qemuGuest.enable = true;
}
