{
  imports =
    [ # Include the results of the hardware scan.
      ./network.nix
      ./rpi-services.nix
      ../../machine-base/ssh.nix
      ./rpi-hw.nix
    ];
}
