# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./multi-glibc-locale-paths.nix
              (import ./packages.nix {}                                 )
              (import ./users.nix { wheel = { ix = "ix"; };
                                    users = { guest = "guest"; }; }     )
              (import ./countries/germany.nix {}                        )
              (import ./boot/efi.nix          {}                        )
              (import ./xserver.nix           {}                        )
              (import ./xmonad.nix            {}                        )
              (import ./gpu.nix               { kind = "nvidia-offload"; }     )
              (import ./networking.nix        { ssh = true;
                                                name = "hedron"; }      )
    ];

  # Select internationalisation properties.
   console = {
     # consoleFont = "Lat2-Terminus16";
     font = "LatArCyrHeb-16";
     keyMap = "us";
   };
   i18n = {
     defaultLocale = "en_US.UTF-8";
   };

  hardware = {
    pulseaudio.enable = true;
    pulseaudio.package = pkgs.pulseaudioFull;
    pulseaudio.support32Bit = true;

    bluetooth.enable = true;
  };

  services.logind.lidSwitch = "hibernate";

  # List services that you want to enable:

  programs.gnupg.agent.enable = true;

  # for Serokell development work
  # virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "ix" ];

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.blueman.enable = true;

  programs.light.enable = true;
  services.actkbd = {
    enable = true;
    bindings = [
      { keys = [ 224 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -U 10"; }
      { keys = [ 225 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -A 10"; }
    ];
  };

  system.autoUpgrade.enable = true;
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?
}
