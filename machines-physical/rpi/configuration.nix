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
  #hardware.raspberry-pi."4".audio.enable = true;
  # avahi required for service discovery
  services.avahi.enable = true;

  services.pipewire = {
    # opens UDP ports 6001-6002
    raopOpenFirewall = true;

    extraConfig.pipewire = {
      "10-airplay" = {
        "context.modules" = [
          {
            name = "libpipewire-module-raop-discover";

            # increase the buffer size if you get dropouts/glitches
            # args = {
            #   "raop.latency.ms" = 500;
            # };
          }
        ];
      };
    };
  };



  nix.buildMachines = [ {
	 hostName = "192.168.1.26";
	 system = "aarch64-linux";
       protocol = "ssh-ng";
	 # if the builder supports building for multiple architectures,
	 # replace the previous line by, e.g.
	 # systems = ["x86_64-linux" "aarch64-linux"];
	 maxJobs = 1;
	 speedFactor = 2;
	 supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
	 mandatoryFeatures = [ ];
	}] ;
	nix.distributedBuilds = true;
	# optional, useful when the builder has a faster internet connection than yours
	nix.extraOptions = ''
	  builders-use-substitutes = true
	'';
}
