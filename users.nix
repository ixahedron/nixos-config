{ wheel ? {}, users ? {}, ...}:
{ pkgs, ...} :

{

  users.users = {
    ix = {
      isNormalUser = true;
      # extraGroups = [ "wheel" "video" "audio" "disk" "networkmanager" "docker" ];
      extraGroups = [ "wheel" "video" "audio" "disk" "networkmanager" ];
    };

    guest = {
      isNormalUser = true;
      extraGroups = [ "video" ];
    };
  };

}
