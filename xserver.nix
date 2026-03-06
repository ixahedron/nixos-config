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
    rxvt-unicode-plugins.perls

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

    # elegant-sddm
    sddm-astronaut

#    ( callPackage ./xserver/dungeondraft/default.nix { } )
#    ( writeShellScriptBin "dungeondraft-offload" "nvidia-offload dungeondraft" )
#    ( callPackage ./xserver/wonderdraft/default.nix { } )
#    ( writeShellScriptBin "wonderdraft-offload" "nvidia-offload wonderdraft" )
  ];

  fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji

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
    ubuntu-classic
    ucs-fonts
    comic-neue
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

    logind.settings.Login = {
      HandlePowerKey = "hibernate";
      HandleLidSwitch = "hibernate";
    };

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
        theme = "Elegant";
        # extraPackages = [ pkgs.elegant-sddm ];
        extraPackages = [ pkgs.sddm-astronaut];
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
