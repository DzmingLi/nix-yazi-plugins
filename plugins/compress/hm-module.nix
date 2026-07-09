{
  options =
    { mkKeyOption, ... }:
    { lib, pkgs, ... }:
    {
      keys.compress = mkKeyOption {
        on = [ "C" ];
        run = "plugin compress";
        desc = "Compress selected files";
      };
      keys.compress-password = mkKeyOption {
        on = [ "C" "p" ];
        run = "plugin compress -p";
        desc = "Compress with password";
      };
    };
  config =
    { cfg, setKeys, ... }:
    { lib, pkgs, ... }:
    lib.mkMerge [
      (setKeys cfg.keys)
      {
        programs.yazi.yaziPlugins.runtimeDeps = with pkgs; [
          zip
          p7zip
        ];
      }
    ];
}
