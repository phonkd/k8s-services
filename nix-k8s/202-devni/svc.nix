# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    vim
    zsh
  ];
  # font
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ];
  })
  ];

  # def shell
  users.defaultUserShell = pkgs.zsh;

  virtualisation.docker.enable = true;
  # Groups:
  users.users.phonkd.extraGroups = [ "docker" "video" ];
  programs.ssh.startAgent = true; #ssh-agent
  networking.firewall.allowedTCPPorts = [80 443];
  ### gitlab runner
  boot.kernel.sysctl."net.ipv4.ip_forward" = true; # 1
  virtualisation.docker.enable = true;
  services.gitlab-runner = {
      enable = true;
      services= {
        # runner for building in docker via host's nix-daemon
        # nix store will be readable in runner, might be insecure
        nix = with lib;{
          # File should contain at least these two variables:
          # `CI_SERVER_URL`
          # `REGISTRATION_TOKEN`
          registrationConfigFile = toString ./path/to/ci-env; # 2
          dockerImage = "alpine";
          dockerVolumes = [
            "/nix/store:/nix/store:ro"
            "/nix/var/nix/db:/nix/var/nix/db:ro"
            "/nix/var/nix/daemon-socket:/nix/var/nix/daemon-socket:ro"
          ];
          dockerDisableCache = true;
          preBuildScript = pkgs.writeScript "setup-container" ''
            mkdir -p -m 0755 /nix/var/log/nix/drvs
            mkdir -p -m 0755 /nix/var/nix/gcroots
            mkdir -p -m 0755 /nix/var/nix/profiles
            mkdir -p -m 0755 /nix/var/nix/temproots
            mkdir -p -m 0755 /nix/var/nix/userpool
            mkdir -p -m 1777 /nix/var/nix/gcroots/per-user
            mkdir -p -m 1777 /nix/var/nix/profiles/per-user
            mkdir -p -m 0755 /nix/var/nix/profiles/per-user/root
            mkdir -p -m 0700 "$HOME/.nix-defexpr"
            . ${pkgs.nix}/etc/profile.d/nix-daemon.sh
            ${pkgs.nix}/bin/nix-channel --add https://nixos.org/channels/nixos-20.09 nixpkgs # 3
            ${pkgs.nix}/bin/nix-channel --update nixpkgs
            ${pkgs.nix}/bin/nix-env -i ${concatStringsSep " " (with pkgs; [ nix cacert git openssh ])}
          '';
          environmentVariables = {
            ENV = "/etc/profile";
            USER = "root";
            NIX_REMOTE = "daemon";
            PATH = "/nix/var/nix/profiles/default/bin:/nix/var/nix/profiles/default/sbin:/bin:/sbin:/usr/bin:/usr/sbin";
            NIX_SSL_CERT_FILE = "/nix/var/nix/profiles/default/etc/ssl/certs/ca-bundle.crt";
          };
          tagList = [ "nix" ];
        };
      };
    };
}
