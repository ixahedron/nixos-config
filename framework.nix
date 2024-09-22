{ ... }:
{ config, lib, pkgs, ... }:
{

  # AMD has better battery life with PPD over TLP:
  # https://community.frame.work/t/responded-amd-7040-sleep-states/38101/13
  services.power-profiles-daemon.enable = lib.mkDefault true;

  services.fwupd.enable = true;

  # Needed for desktop environments to detect/manage display brightness
  # hardware.sensor.iio.enable = lib.mkDefault true;

  # services.actkbd = {
  #  enable = true;
  #  bindings = [
  #   { keys = [ 224 232 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/brightnessctl -c backlight s 10%-"; }
  #   { keys = [ 225 233 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/brightnessctl -c backlight s 10%+"; }
  #  ];
  #};

  environment.systemPackages = with pkgs; [
    brightnessctl
  ];

}
