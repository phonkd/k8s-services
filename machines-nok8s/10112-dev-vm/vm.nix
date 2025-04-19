{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    neovim
    git
    btop
    zsh
    oh-my-zsh
    fzf
    bat
    neofetch
    jq
    yq
    tree
    ipcalc
    nixd
  ];
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;
  services.alloy.enable = true;
  environment.etc."alloy/config.alloy" = {
    text = ''
      local.file "hostname" {
        filename = "/etc/hostname"
      }

      prometheus.scrape "node_exporter" {
        targets = ["localhost:9100"]

        forward_to = [prometheus.remote_write.main.receiver]
      }

      prometheus.remote_write "main" {
        endpoint {
          url = "https://prometheus.example.com/api/v1/write"
          basic_auth {
            username = "your_username"
            password = env("REMOTE_WRITE_PASSWORD")
          }
        }
      }

      prometheus.relabel "add_hostname_label" {
        targets = prometheus.scrape.node_exporter.targets

        replacement   = local.file.hostname.content
        target_label  = "instance"
        action        = "replace"
      }
    '';
  };


}
