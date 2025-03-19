# sudo nixos-rebuild switch --target-host root@192.168.1.156 -I nixos-config=./configuration.nix --build-host root@192.168.1.156
# make sure ssh and root login is enabled
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;
  networking.hostName = "template-nix"; # Define your hostname.
  networking.networkmanager.enable = true;
  networking.networkmanager.dhcp = "internal";
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
  services.openssh.enable = true;
  networking.firewall.enable = true;
  system.stateVersion = "24.11"; # Did you read the comment?
  programs.zsh.enable = true;
  services.qemuGuest.enable = true;
  environment.systemPackages = with pkgs; [
    vim
    zsh
  ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.ohMyZsh.enable = true;
}
