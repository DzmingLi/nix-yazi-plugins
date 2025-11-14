{
  lib,
  stdenv,
  fetchFromGitHub,
}:

stdenv.mkDerivation {
  pname = "yaziPlugins-mediainfo";
  version = "unstable-2025-01-10";

  src = fetchFromGitHub {
    owner = "boydaihungst";
    repo = "mediainfo.yazi";
    rev = "7543154138ffb2bb0c738419af6ff4595152a809";
    hash = "sha256-qWh/2WA1pBhze+g5aDSl4gHk2zJSgnl4WZr74FfNA74=";
  };

  buildPhase = ''
    mkdir $out
    cp $src/* $out
  '';

  meta = with lib; {
    description = "Yazi plugin for previewing media files with thumbnails and metadata";
    homepage = "https://github.com/boydaihungst/mediainfo.yazi";
    license = licenses.mit;
    maintainers = [ ];
    platforms = platforms.all;
  };
}
