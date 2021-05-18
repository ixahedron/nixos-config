{ pkgs, stdenv, lib, ... }:
let
  inherit (stdenv) lib;
  name = "dungeondraft";
  version = "1.0.1.1";
  path = lib.makeBinPath [ pkgs.gnome3.zenity pkgs.gdb ];

in
stdenv.mkDerivation rec {
  inherit name version;

  src = ./Dungeondraft-1.0.1.1-Linux64.zip;

  nativeBuildInputs = with pkgs; [
    autoPatchelfHook
    unzip
  ];

  buildInputs = with pkgs; [
    gnome3.zenity

    zlib
    libGLU
    alsaLib
    libpulseaudio

    makeWrapper

    stdenv.cc.cc.lib

    xorg.libXi
    xorg.libX11
    xorg.libXrandr
    xorg.libXcursor
    xorg.libXinerama
  ];

  unpackCmd = "unzip $curSrc -d ./dungeondraft";

  sourceRoot = "dungeondraft";

  installPhase = ''
    name=${name}

    mkdir -p $out/bin
    mkdir -p $out/share/applications

    chmod +x Dungeondraft.x86_64

    substituteInPlace ./Dungeondraft.desktop \
      --replace '/opt/Dungeondraft/Dungeondraft.x86_64' "$out/bin/$name" \
      --replace '/opt/Dungeondraft' $out \
      --replace '/opt/Dungeondraft/Dungeondraft.png' "$out/Dungeondraft.png"

    mv ./Dungeondraft.desktop $out/share/applications/
    mv ./Dungeondraft.x86_64 "$out/$name"
    mv ./Dungeondraft.pck $out/$name.pck

    makeWrapper $out/$name $out/bin/$name \
        --prefix PATH : ${path}

    mv ./* $out
  '';
}
