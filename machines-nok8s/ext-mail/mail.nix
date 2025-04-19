{ config, pkgs, lib, ... }: {
  sops.secrets."mail-secret" = {};

  imports = [
    (builtins.fetchTarball {
      # Pick a release version you are interested in and set its hash, e.g.
      url = "https://gitlab.com/simple-nixos-mailserver/nixos-mailserver/-/archive/v2.3.0/nixos-mailserver-v2.3.0.tar.gz";
      # To get the sha256 of the nixos-mailserver tarball, we can use the nix-prefetch-url command:
      # release="nixos-23.05"; nix-prefetch-url "https://gitlab.com/simple-nixos-mailserver/nixos-mailserver/-/archive/${release}/nixos-mailserver-${release}.tar.gz" --unpack
      sha256 = "0lpz08qviccvpfws2nm83n7m2r8add2wvfg9bljx9yxx8107r919";
    })
  ];
  users.users.virtualMail.isSystemUser = lib.mkForce true;
  users.users.virtualMail.isNormalUser = lib.mkForce false;
  mailserver = {
    enable = true;
    fqdn = "mail.phonkd.net";
    domains = [ "phonkd.net" ];
    loginAccounts = {
      "phonkd@phonkd.net" = {
        hashedPasswordFile = config.sops.secrets."mail-secret".path;
        aliases = ["test@phonkd.net"];
      };
    };
    certificateScheme = 3;
  };
  security.acme.acceptTerms = true;
  security.acme.defaults.email = "bhonk123@gmail.com";
}
