{ touchpad ? "tapPad",  kbLayout ? "lv,de,ru", kbOptions ? "grp:caps_toggle,grp:lshift_toggle", ... }:
{ pkgs, ... }:

let

  mkSynaptics = x:
    if x == "tapPad" then {
      enable = true;
      minSpeed = "1.0";
      maxSpeed = "2.0";
      tapButtons = true;
      twoFingerScroll = true;
      horizontalScroll = true;
      palmDetect = false;
      buttonsMap = [1 3 2];
      additionalOptions = ''
        Option "SoftButtonAreas" "60% 0 72% 0 40% 59% 72% 0"
        Option "AccelerationProfile" "2"
        Option "ConstantDeceleration" "4"
      '';
    } else {
      enable = true;
      tapButtons = false;
      twoFingerScroll = true;
      horizontalScroll = true;
      palmDetect = true;
    };


  # blender = pkgs.lib.overrideDerivation pkgs.blender (oldAttrs: {
	#   cudaSupport = true;
  # });

  utils = with pkgs; [
    firefox
    chromium
    discord
    # tdesktop

    pavucontrol
    pulseaudio # for pactl in xmonad -- change to wpctl?

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

  additionalKeybinds = pkgs.writeText "xkb-layout" ''
    keycode 223 = at
  '';

in
{
  # Don't use wicd
  # imports = [ ./xserver/wicd.nix ./xserver/unfree.nix ];
  imports = [ ./xserver/unfree.nix ];
  services = {
    xserver = {
      enable = true;
      displayManager.sessionCommands =
        "${pkgs.xorg.xsetroot}/bin/xsetroot -solid black; ${pkgs.xorg.xmodmap}/bin/xmodmap ${additionalKeybinds}";

      xkb = {
        layout = kbLayout;
        options = kbOptions;
        };
    };

    libinput = {
      enable = true;
    };

    logind.lidSwitch = "hibernate";

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
