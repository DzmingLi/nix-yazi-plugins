{
  options =
    _:
    { lib, pkgs, ... }:
    {
      mediainfo = {
        pkg = lib.mkOption {
          type = lib.types.package;
          description = "The package to use for mediainfo";
          default = pkgs.mediainfo;
        };
      };

      imagemagick = {
        pkg = lib.mkOption {
          type = lib.types.package;
          description = "The package to use for ImageMagick";
          default = pkgs.imagemagick;
        };
      };

      ffmpeg = {
        enable = lib.mkEnableOption "Enable ffmpeg for thumbnail generation";
        pkg = lib.mkOption {
          type = lib.types.package;
          description = "The package to use for ffmpeg";
          default = pkgs.ffmpeg;
        };
      };
    };
  config =
    { cfg, ... }:
    { lib, pkgs, ... }:
    {
      programs.yazi = {
        settings.plugin = {
          prepend_previewers = [
            { mime = "{audio,video,image}/*"; run = "mediainfo"; }
            { mime = "application/{subrip,postscript}"; run = "mediainfo"; }
          ];
          prepend_preloaders = [
            { mime = "{audio,video,image}/*"; run = "mediainfo"; }
          ];
        };

        yaziPlugins = {
          runtimeDeps = [
            cfg.mediainfo.pkg
            cfg.imagemagick.pkg
          ] ++ lib.optional (cfg.ffmpeg.enable) cfg.ffmpeg.pkg;
        };
      };
    };
}
