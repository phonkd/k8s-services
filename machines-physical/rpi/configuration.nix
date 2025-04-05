{
  imports =
    [ # Include the results of the hardware scan.
      ./network.nix
      ./rpi-services.nix
      ../../machine-base/ssh.nix
      ./rpi-hw.nix
      #/etc/nixos/hardware-configuration.nix
      ./raspotify-container.nix
    ];
  system.stateVersion = "24.11";
}
