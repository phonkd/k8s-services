# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  myRepo = import https://github.com/phonkd/nix-experiment/default.nix {
  };
in

{
  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;
  nixpkgs.config.allowUnfree = true;
  networking.firewall.enable = true;
  system.stateVersion = "24.11"; # Did you read the comment?
  services.qemuGuest.enable = true;

  # Use `myRepo` in your configuration
    environment.systemPackages = with pkgs; [
      myRepo.somePackage
    ];

    # You can also use values or attributes exported by default.nix
    services.myService = myRepo.someService;
}
