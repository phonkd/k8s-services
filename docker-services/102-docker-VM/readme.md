1. install nixos-generate
2. run nioxs-generate -f proxmox -c ./configuration.nixs


## when applying the config in an existing vm:
-  make sure to uncomment this line : `boot.loader.grub.device = "nodev";`
- Run `sudo nixos generate-config`
- Add `/etc/hardware-configuration.nix` to the imports section of a .nix file