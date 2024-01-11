{ ... }:
{ pkgs, ... } :

let
  packages = with pkgs; [
    elan
    vscode.fhs
  ];

in

{

  environment.systemPackages = packages;

}
