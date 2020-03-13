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
} else (if kind == "nvidia-offload" then {
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware = {
    nvidia = {
      prime.offload.enable = true;
      prime.nvidiaBusId = "PCI:1:0:0";
      prime.intelBusId = "PCI:0:2:0";
      modesetting = true;
    };
    opengl = {
      enable = true;
      driSupport32Bit = true;
      extraPackages = [ pkgs.linuxPackages.nvidia_x11.out ];
    };
  };
} else (if kind == "optimus-bumblebee" then {
  hardware.bumblebee.enable = true;
} else {})))
