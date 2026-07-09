{
  options =
    _:
    { lib, pkgs, ... }:
    {
      libreoffice = {
        pkg = lib.mkOption {
          type = lib.types.package;
          description = "The package to use for LibreOffice";
          default = pkgs.libreoffice;
        };
      };

      poppler-utils = {
        pkg = lib.mkOption {
          type = lib.types.package;
          description = "The package to use for poppler-utils (provides pdftoppm)";
          default = pkgs.poppler-utils;
        };
      };
    };
  config =
    { cfg, ... }:
    { lib, pkgs, ... }:
    {
      programs.yazi = {
        settings.plugin.prepend_preloaders = [
          { mime = "application/vnd.openxmlformats-officedocument.*"; run = "office"; }
          { mime = "application/vnd.oasis.opendocument.*"; run = "office"; }
          { mime = "application/vnd.ms-excel"; run = "office"; }
          { mime = "application/vnd.ms-powerpoint"; run = "office"; }
          { mime = "application/msword"; run = "office"; }
        ];
        settings.plugin.prepend_previewers = [
          { mime = "application/vnd.openxmlformats-officedocument.*"; run = "office"; }
          { mime = "application/vnd.oasis.opendocument.*"; run = "office"; }
          { mime = "application/vnd.ms-excel"; run = "office"; }
          { mime = "application/vnd.ms-powerpoint"; run = "office"; }
          { mime = "application/msword"; run = "office"; }
        ];

        yaziPlugins = {
          runtimeDeps = [
            cfg.libreoffice.pkg
            cfg.poppler-utils.pkg
          ];
        };
      };
    };
}
