{ pkgs ? import <nixpkgs> {},}:
with pkgs;
stdenv.mkDerivation {
  pname = "onscripter-en-sdl";
  version = "unstable";

  src = "./";

  buildInputs = [ libpng libjpeg libogg libvorbis freetype smpeg
                  SDL SDL_image SDL_mixer SDL_ttf xorg.libXext xorg.libX11
                ];

  configureFlags = [ "--no-werror" ];

  # Without this libvorbisfile.so is not getting linked properly for some reason.
  NIX_CFLAGS_LINK = "-lvorbisfile";

  NIX_LDFLAGS = "-lXext -lX11";

  preBuild = ''
    sed -i 's/.dll//g' Makefile
  '';
}
