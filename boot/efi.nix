{ ... }:

{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices.nixos = {
    device="/dev/disk/by-uuid/6047e35c-4d07-4365-af9f-a8226c83c081";
    preLVM=true;
  };

  boot.supportedFilesystems = [ "ntfs" ];

  fileSystems."/tmp/windisk" =
    { device = "/dev/nvme0n1p3";
      fsType = "ntfs";
      options = [ "rw" "uid=1001"];
    };

}
