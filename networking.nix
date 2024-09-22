{ name, fw ? false, ssh ? false, sshPorts ? [22], ... }:
{ ... }:
{
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;
  # networking.networkmanager.unmanaged = ["enp2s0f0"];

  # Following the hardware-configuration comment, we set per-interface useDHCP to true.
  networking.interfaces.enp195s0f3u1.useDHCP = true;
  networking.interfaces.wlp1s0.useDHCP = true;

  networking.hostName = name;
  networking.firewall.enable = fw;
  services.openssh.enable = ssh;
  services.openssh.ports = sshPorts;

  services.httpd = {
    enable = true;
    enablePHP = true;
    adminAddr = "inprikule@gmail.com";
  };

}
