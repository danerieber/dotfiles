{ pkgs, ... }:

let
  OpenRGBEffectsPlugin = with pkgs; stdenv.mkDerivation rec {
    pname = "OpenRGBEffectsPlugin";
    version = "0.9";

    src = fetchFromGitLab {
      owner = "OpenRGBDevelopers";
      repo = "OpenRGBEffectsPlugin";
      rev = "release_${version}";
      sha256 = "sha256-DmLFLjm/HWE5P95m8CJ77LzJukR7x1fI6nI7fq7rbkY=";

      fetchSubmodules = true;
      leaveDotGit = true;
    };

    nativeBuildInputs = with qt5; [ qmake wrapQtAppsHook ];
    buildInputs = [ qt5.full openal ];
  };
in
{
  home.packages = [
    pkgs.openrgb
    OpenRGBEffectsPlugin
  ];

  home.file.".config/OpenRGB/plugins/libOpenRGBEffectsPlugin.so".source
    = "${OpenRGBEffectsPlugin}/lib/libOpenRGBEffectsPlugin.so";
}
