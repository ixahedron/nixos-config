{ pkgs, ... }:

{
  nixpkgs.config = {
    allowUnfree = true;

    chromium = {
      # enableAdobeFlash = true;
      # enablePepperFlash = true;
      # enablePepperPDF = true;
    };
  };
}
