{ lib
, pkgs
, fetchurl
, stdenv
, full ? false
}:

stdenv.mkDerivation rec {
  pname = "sf-symbols";
  version = "5";

  src = fetchurl {
    url = "https://devimages-cdn.apple.com/design/resources/download/SF-Symbols-${version}.dmg";
    sha256 = "e9db5caf0458d6a107aae64f6f09c4a360a672e34df59905a3cae7ffc4be72d3";
  };

  sourceRoot = ".";
  buildInputs = [ pkgs.undmg pkgs.p7zip ];
  installPhase = ''
    7z x 'SF Symbols.pkg'
    7z x 'Payload~'
    mkdir -p $out/share/fonts
    cp ./Library/Fonts/${ if full then "*" else "SF-Pro.ttf" } $out/share/fonts
  '';

  meta = with lib; {
    description = "Fonts from SF Symbols";
    homepage = "https://developer.apple.com/sf-symbols/";
    platforms = platforms.all;
  };
}
