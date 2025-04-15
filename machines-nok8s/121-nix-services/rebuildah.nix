{ config, pkgs, ... }:
{
  imports = [
    ../apps/rebuildah/rebuildah.nix
  ];
  sops.secrets.ntfytoken = {
    sopsFile = ../apps/rebuildah/secrets/secrets.yaml;
  };
  services.cron.systemCronJobs = [
    "*/3 * * * * root nix-experiment -repopath /tmp/kek -useflakes true -nixconfig machines-nok8s/121-nix-services/flake.nix -repourl https://github.com/phonkd/inventory.git -ntfyurl https://notify.arnsi.ch/seltest -ntfytoken '${builtins.readFile config.sops.secrets."ntfytoken".path}'"
  ];
  # more is necessarcy (its in base)

}
