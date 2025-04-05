{ config, pkgs, ... }:
{
  # boot.kernelParams = [ "snd_bcm2835.enable_hdmi=1" "snd_bcm2835.enable_headphones=1" ];
  # boot.loader.raspberryPi.firmwareConfig = ''
  #   dtparam=audio=on
  # '';
  sound.enable = true;
  boot.kernelParams = [ "snd_bcm2835.enable_hdmi=1" "snd_bcm2835.enable_headphones=1" ];
  boot.loader.raspberryPi.firmwareConfig = ''
    dtparam=audio=on
  '';
  services.pulseaudio.enable = true; # Use Pipewire, the modern sound subsystem
  security.rtkit.enable = true; # Enable RealtimeKit for audio purposes
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
    #
    # Bluetooth
    #
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  environment.systemPackages = with pkgs; [
    pavucontrol # PulseAudio Volume Control
    pamixer # Command-line mixer for PulseAudio
    bluez # Bluetooth support
    bluez-tools # Bluetooth tools
    git
    vim
    compose2nix
    btop
  ];
  virtualisation.docker.enable = true;
  users.users.phonkd = {
    extraGroups = [ "docker" ];
  };
  services.prometheus.exporters.node.enable = true;

}
