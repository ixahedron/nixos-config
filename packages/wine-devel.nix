{
  nixpkgs.config.packageOverrides = super: let self = super.pkgs; in
  {
    wine-devel = super.wineWowPackages.full.overrideDerivation (oldAttrs: {
      name = "wine-5.3";
      src = super.fetchurl {
        url = "https://dl.winehq.org/wine/source/5.x/wine-5.3.tar.xz";
        sha256 = "9b1bc7228bad80a014b6dc55ef17ef532c5a88fd8e477658dda02953cc907fde";
      };
      patches = [];
    });

  };
}
