{ lib, stdenv, pkgs, ... }:

stdenv.mkDerivation rec {
  pname = "astronvim";
  version = "v3.37.5";

  src = pkgs.fetchFromGitHub {
    owner = "AstroNvim";
    repo = "AstroNvim";
    rev = "refs/tags/v3.37.5";
    sha256 = "sha256-tWgdpK2K6GDqbraik4ZrlYpT7gqWoPyBLmMCAiLp8IU=";
  };

  installPhase = ''
    mkdir $out
    cp -r * "$out/"
  '';

  meta = with lib; {
    description = "AstroNvim";
    homepage = "https://github.com/AstroNvim/AstroNvim";
    platforms = platforms.all;
    maintainers = [ maintainers.toutaboc ];
    license = licenses.gpl3;
  };
}
