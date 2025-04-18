{ config, pkgs, lib, ... }:

let
  ntfytokentemp = if builtins.pathExists config.sops.secrets."ntfytoken".path then
                    builtins.readFile config.sops.secrets."ntfytoken".path
                  else
                    "default_auth_token_placeholder";
in
{
  services.cron.systemCronJobs = [
    "*/3 * * * * root nix-experiment -repopath /tmp/kek -useflakes false -nixconfig machines-nok8s/10112-dev-vm/configuration.nix -repourl https://github.com/phonkd/inventory.git -ntfyurl https://notify.arnsi.ch/seltest -ntfytoken '${ntfytokentemp}'"
  ];
}
