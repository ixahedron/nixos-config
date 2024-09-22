{ kbLayout ? "lv,de,ru", kbOptions ? "grp:caps_toggle", ... }:
{ pkgs, ... }:

let

  utils = with pkgs; [
    firefox
    chromium
    discord
    # tdesktop

    pavucontrol

    mplayer
    ffmpeg
    vlc

    rxvt-unicode
    urxvt_perls

    haskellPackages.xmobar
    dmenu

    feh
    # blender
    inkscape
    gimp

    # autocutsel
    clipit

    # zathura
    # fbreader
    # calibre

    xclip
    xorg.xev
    xorg.xhost

    glibc
    xorg.libXinerama
    xorg.libXcursor
    xorg.libXrandr
    xorg.libXi
    xorg.libX11
    libGL
    libpng
    libpng12

    wireshark-cli

    qt5.qtbase
    qt5.qtquickcontrols
    qt5.qtgraphicaleffects
    ( callPackage ./xserver/sddm-theme-chili.nix { } )

#    ( callPackage ./xserver/dungeondraft/default.nix { } )
#    ( writeShellScriptBin "dungeondraft-offload" "nvidia-offload dungeondraft" )
#    ( callPackage ./xserver/wonderdraft/default.nix { } )
#    ( writeShellScriptBin "wonderdraft-offload" "nvidia-offload wonderdraft" )
  ];

  fonts = with pkgs; [
    cantarell-fonts
    corefonts
    dejavu_fonts
    dina-font
    dosemu_fonts
    freefont_ttf
    gyre-fonts
    open-sans
    proggyfonts
    terminus_font
    ubuntu_font_family
    ucs-fonts
  ];

#  additionalKeybinds = pkgs.writeText "xkb-layout" ''
#    keycode 223 = at
#  '';

in
{
  imports = [ ./xserver/unfree.nix ];
  services = {
    xserver = {
      enable = true;
      displayManager.sessionCommands =
        # "${pkgs.xorg.xsetroot}/bin/xsetroot -solid black; ${pkgs.xorg.xmodmap}/bin/xmodmap ${additionalKeybinds}";
        "${pkgs.xorg.xsetroot}/bin/xsetroot -solid black";

      xkb = {
        layout = kbLayout;
        options = kbOptions;
        };
    };

    libinput = {
      enable = true;
    };

    logind.lidSwitch = "hibernate";

    upower = {
      enable = true;
      percentageLow = 20;
      percentageCritical = 15;
      percentageAction = 10;
      criticalPowerAction = "Hibernate";
    };


    displayManager = {
      defaultSession = "none+xmonad";
      autoLogin = {
        enable = false;
        user = "ix";
      };
      sddm = {
        enable = true;
        autoNumlock = true;
        theme = "chili";
      };

    };
  };

  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;

    packages = fonts;

    fontconfig = {
      defaultFonts = {
        serif = [ "DejaVu Serif" ];
        sansSerif = [ "DejaVu Sans" "Open Sans" "Liberation Sans" ];
        monospace = [ "DejaVu Sans Mono" ];
      };
    };
  };

  environment.systemPackages = utils;
}
