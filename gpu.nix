{ kind }:
{config, pkgs, pkgs_i686, ...}:
if kind == "nvidia" then {
  boot.blacklistedKernelModules = [ "nouveau" ];
  boot.kernelParams = [ "nomodeset" "video=vesa:off" "vga=normal" ];
  boot.vesa = false;
  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;
  services.xserver.videoDrivers = [ "nvidia" "vesa" ];
} else (if kind == "optimus" then {
  # disable card with bbswitch by default
  hardware.nvidiaOptimus.disable = true;
  # install nvidia drivers in addition to intel one
  hardware.opengl.extraPackages = [ pkgs.linuxPackages.nvidia_x11.out ];
  hardware.opengl.extraPackages32 = [ pkgs_i686.linuxPackages.nvidia_x11.out ];
} else (if kind == "optimus-bumblebee" then {
  hardware.bumblebee.enable = true;
} else {}))
