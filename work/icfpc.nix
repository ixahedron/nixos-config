{ ... }:
{ pkgs, ... } :

let
  packages = with pkgs; [
    vscode.fhs
  ];

in

{

  environment.systemPackages = packages;

}
