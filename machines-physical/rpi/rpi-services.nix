{ config, pkgs, ... }:
{
  # boot.kernelParams = [ "snd_bcm2835.enable_hdmi=1" "snd_bcm2835.enable_headphones=1" ];
  # boot.loader.raspberryPi.firmwareConfig = ''
  #   dtparam=audio=on
  # '';
  hardware.pulseaudio.enable = false; # Use Pipewire, the modern sound subsystem
  security.rtkit.enable = true; # Enable RealtimeKit for audio purposes
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # Uncomment the following line if you want to use JACK applications        # jack.enable = true;
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
  ];
  virtualisation.docker.enable = true;
}
