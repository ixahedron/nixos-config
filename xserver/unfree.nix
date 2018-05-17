{ pkgs, ... }:

{
  nixpkgs.config = {
    allowUnfree = true;

    firefox = {
      enableGoogleTalkPlugin = true;
      enableAdobeFlash = false;
    };

    chromium = {
      # enableAdobeFlash = true;
      # enablePepperFlash = true;
      enablePepperPDF = true;
    };
  };
}
