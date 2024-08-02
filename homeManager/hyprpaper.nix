{ pkgs, lib, ... }:
with lib;
let
  wallpaperDir = ./wallpapers;
  wallpaperList = filesystem.listFilesRecursive wallpaperdir;
  wallpaperBash = ""
    randomBg = pkgs.writeShellScriptBin "randomBg" ''
      wallpaperDir="/home/laged/wallpapers/"
      wallpaperExt="jpg"
      monitor=(`hyprctl monitors | grep Monitor | awk '{print $2}'`)
      hyprctl hyprpaper unload all
      hyprctl hyprpaper preload $wallpaper
      for m in ''${monitor[@]}; do
      cmd="$m,$wallpaper"
      echo $cmd
      hyprctl hyprpaper wallpaper "$m,$wallpaper"
      done
  '';
in
{
  home-manager.users.laged.home.packages = with pkgs; [
    randomBg
  ];
  home-manager.users.laged.services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;
    };
  };

  systemd.user = {
    services.randomizeBg = {
      description = "Randomize hyperpapr bg";
      after = [ "graphical-session-pre.target" ];
      partOf = [ "graphical-session.target" ];
      #type = "oneshot";
      serviceConfig = {
        ExecStart = "${randomBg}/bin/randomBg";
      };
      wantedBy = [ "graphical-session.target" ];
    };
    timers.randomizeBg = {
      description = "Interval for randomizing hyperpapr bg";
      #timer = {
      #onUnitActiveSec = "1h";
      #};
      wantedBy = [ "timers.target" ];
    };
  };
}
