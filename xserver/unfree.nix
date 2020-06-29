{ pkgs, ... }:

{
  nixpkgs.config = {
    allowUnfree = true;

    firefox = {
      enableAdobeFlash = false;
    };

    chromium = {
      # enableAdobeFlash = true;
      # enablePepperFlash = true;
      # enablePepperPDF = true;
    };
  };
}
