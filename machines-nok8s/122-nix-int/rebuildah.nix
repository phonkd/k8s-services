{ config, pkgs, lib, ... }:

let
  ntfytokentemp = if builtins.pathExists config.sops.secrets."ntfytoken".path then
                    builtins.readFile config.sops.secrets."ntfytoken".path
                  else
                    "default_auth_token_placeholder";
in
{
  imports = [
    ../apps/rebuildah/rebuildah.nix
  ];

  services.cron.systemCronJobs = [
    "*/3 * * * * root NIX_PATH=/nix/var/nix/profiles/per-user/root/channels/nixos:nixos-config=/etc/nixos/configuration.nix:/nix/var/nix/profiles/per-user/root/channels nix-experiment -repopath /tmp/kek -nixconfig machines-nok8s/122-nix-int/configuration.nix -repourl https://github.com/phonkd/inventory.git -ntfyurl https://notify.arnsi.ch/seltest -ntfytoken '${ntfytokentemp}'"
  ];

  # smore is necessary (it's in base)asdfsasdf
}
