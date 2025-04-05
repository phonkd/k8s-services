{
  imports =
    [ # Include the results of the hardware scan.
      ./network.nix
      ./rpi-services.nix
      ../../machine-base/ssh.nix
      ./rpi-hw.nix
      #/etc/nixos/hardware-configuration.nix
      ./raspotify-container.nix
      "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/raspberry-pi/4"
    ];
  system.stateVersion = "24.11";
  hardware.raspberry-pi."4".audio.enable = true;
}
