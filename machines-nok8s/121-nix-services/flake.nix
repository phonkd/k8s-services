{
  description = "NixOS system with custom Caddy and powerdns plugin";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11"; # or your stable
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, unstable, flake-utils, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        unstablePkgs = import unstable {
          inherit system;
          config.allowUnfree = true;
        };
      in {
        nixosConfigurations.nixos-services = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./configuration.nix
            # Pass unstable as a module argument
            ({ config, pkgs, ... }: {
              _module.args.unstable = unstablePkgs;
            })
          ];
        };
      });
}
