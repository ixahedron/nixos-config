{ name, fw ? false, ssh ? false, sshPorts ? [22], ... }:
{ ... }:
{
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;
  # networking.networkmanager.unmanaged = ["enp2s0f0"];

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp2s0.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;

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
