{ config, inputs, pkgs, ... }:
{
  imports = let
      # replace this with an actual commit id or tag
      commit = "d016ce0365b87d848a57c12ffcfdc71da7a2b55f";
    in [
      "${builtins.fetchTarball {
        url = "https://github.com/Mic92/sops-nix/archive/${commit}.tar.gz";
        # replace this with an actual hash
        # cant get this to work sha256 = "365b87d848a57c12ffcfdc71da7a2b55f";
      }}/modules/sops"
    ];
  sops.defaultSopsFormat = "yaml";
}
