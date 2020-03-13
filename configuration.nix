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
              (import ./boot/grub2.nix        { device = "/dev/sda"; }  )
              (import ./xserver.nix           {}                        )
              (import ./xmonad.nix            {}                        )
              (import ./gpu.nix               { kind = "nvidia-offload"; }     )
              (import ./networking.nix        { ssh = true;
                                                name = "hedron"; }      )
    ];

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;
  # networking.networkmanager.unmanaged = ["enp2s0f0"];

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
    pulseaudio.support32Bit = true;
    opengl.driSupport = true;
    opengl.driSupport32Bit = true;
  };

 # services.acpid.lidEventCommands = "slimlock";

  # List services that you want to enable:

  # Enable CUPS to print documents.
  services.printing.enable = true;

  programs.light.enable = true;
  services.actkbd = {
    enable = true;
    bindings = [
      { keys = [ 224 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -U 10"; }
      { keys = [ 225 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -A 10"; }
    ];
  };

  system.autoUpgrade.enable = true;
  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "16.09";

}
