{ ... } :
{ pkgs, ... } :

let
  packages = with pkgs; [
    vscode.fhs
  ];

in


{

  # for ZeroHR development work
  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "ix" ];

  environment.systemPackages = packages;

}
