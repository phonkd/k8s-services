{
imports =
    [ # Include the results of the hardware scan.
      #/etc/nixos/hardware-configuration.nix
      ./configuration.nix
      ./disk.nix #vm doesnt seem to boot when including this, for now I just use mount and fstab
      /etc/nixos/hardware-configuration.nix # run nixos-generate-config first
    ];
    networking = {
      interfaces.ens18 = {
        ipv4.addresses = [{
          address = "192.168.90.102";
          prefixLength = 24;
        }];
      };
      nameservers = [ "192.168.90.1" ];
      defaultGateway = {
        address = "192.168.90.1";
        interface = "ens18";
      };
    };
}
