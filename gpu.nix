{ kind }:
{ config, pkgs, pkgs_i686, ... }:
if kind == "nvidia" then {
  boot.blacklistedKernelModules = [ "nouveau" ];
  boot.kernelParams = [ "nomodeset" "video=vesa:off" "vga=normal" ];
  boot.vesa = false;
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" "vesa" ];
} else (if kind == "optimus" then {
  # disable card with bbswitch by default
  hardware.nvidiaOptimus.disable = true;
  # install nvidia drivers in addition to intel one
  hardware.graphics.extraPackages = [ pkgs.linuxPackages.nvidia_x11.out ];
} else (if kind == "nvidia-offload" then
  let
    nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
      export __NV_PRIME_RENDER_OFFLOAD=1
      export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
      export __GLX_VENDOR_LIBRARY_NAME=nvidia
      export __VK_LAYER_NV_optimus=NVIDIA_only
      exec -a "$0" "$@"
    '';
  in {
  environment.systemPackages = [ nvidia-offload ];

  boot.initrd.kernelModules = [ "amdgpu" ];
  #services.xserver.videoDrivers = [ "nvidia" ];
  hardware = {
    nvidia = {
      prime.offload.enable = true;
      prime.nvidiaBusId = "PCI:1:0:0";
      prime.amdgpuBusId = "PCI:6:0:0";
      # modesetting.enable = true;
      nvidiaPersistenced = true;
      package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
        version = "535.154.05";
        sha256_64bit = "sha256-fpUGXKprgt6SYRDxSCemGXLrEsIA6GOinp+0eGbqqJg=";
        sha256_aarch64 = "sha256-G0/GiObf/BZMkzzET8HQjdIcvCSqB1uhsinro2HLK9k=";
        openSha256 = "sha256-wvRdHguGLxS0mR06P5Qi++pDJBCF8pJ8hr4T8O6TJIo=";
        settingsSha256 = "sha256-9wqoDEWY4I7weWW05F4igj1Gj9wjHsREFMztfEmqm10=";
        persistencedSha256 = "sha256-d0Q3Lk80JqkS1B54Mahu2yY/WocOqFFbZVBh+ToGhaE=";
      };
    };
    graphics = {
      enable = true;
#      driSupport = true;
#      driSupport32Bit = true;
      extraPackages = with pkgs; [
#        linuxPackages.nvidia_x11.out
        rocm-opencl-icd
        rocm-opencl-runtime
        amdvlk
      ];
    };
  };
} else (if kind == "optimus-bumblebee" then {
  hardware.bumblebee.enable = true;
} else {})))
