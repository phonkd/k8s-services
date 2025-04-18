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
    "*/3 * * * * root nix-experiment -repopath /tmp/kek2 -useflakes false -nixconfig machines-nok8s/122-nix-int/configuration.nix -repourl https://github.com/phonkd/inventory.git -ntfyurl https://notify.arnsi.ch/seltest -ntfytoken '${ntfytokentemp}'"
  ];

  # smore is necessary (it's in base)
}
