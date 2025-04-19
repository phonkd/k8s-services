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
      prometheus.exporter.unix "demo" { }

      // Configure a prometheus.scrape component to collect unix metrics.
      prometheus.scrape "demo" {
        targets    = prometheus.exporter.unix.demo.targets
        forward_to = [prometheus.remote_write.demo.receiver]
      }

      prometheus.remote_write "demo" {
        endpoint {
          url = "https://prometheus.nixk8s.phonkd.net"
        }
      }
    '';
  };


}
