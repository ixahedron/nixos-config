# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
              (import ./packages.nix {}                                 )
              (import ./users.nix { wheel = { ix = "ix"; };
                                    users = { guest = "guest";     }; } )
              (import ./countries/germany.nix {}                        )
              (import ./boot/grub2.nix        { device = "/dev/sda"; }  )
              (import ./xserver.nix           {}                        )
              (import ./xmonad.nix            {}                        )
              (import ./gpu.nix               { kind = "optimus"; }     )
              (import ./networking.nix        { ssh = true;
                                                name = "hedron"; }  )
    ];

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;
  # networking.networkmanager.unmanaged = ["enp2s0f0"];

  # Select internationalisation properties.
   i18n = {
     # consoleFont = "Lat2-Terminus16";
     consoleFont = "LatArCyrHeb-16";
     consoleKeyMap = "us";
     defaultLocale = "en_US.UTF-8";
   };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    wget
  ];

  hardware = {
    opengl.driSupport = true;
    pulseaudio.enable = true;
    opengl.driSupport32Bit = true;
    pulseaudio.support32Bit = true;
  };

 # services.acpid.lidEventCommands = "slimlock";

  # List services that you want to enable:

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable the X11 windowing system.

  # services.xserver.synaptics.enable = true;
  # services.xserver.synaptics.minSpeed = "1.3";


  system.autoUpgrade.enable = true;
  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "16.09";

}
