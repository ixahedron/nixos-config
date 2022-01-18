{ wheel ? {}, users ? {}, ...}:
{ pkgs, ...} :

{

  users.users = {
    ix = {
      isNormalUser = true;
      extraGroups = [ "wheel" "video" "docker" ];
      # extraGroups = [ "wheel" "video" ];
    };

    guest = {
      isNormalUser = true;
      extraGroups = [ "video" ];
    };
  };

}
