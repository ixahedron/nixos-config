{ ... }:

{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.graceful = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices.nixos = {
    device="/dev/disk/by-uuid/e4af8a8b-dec9-45f0-862d-7bc1ecce07f9";
    preLVM=true;
  };

}
