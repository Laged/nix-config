{ pkgs, ... }:
let
  swwwPath = "${pkgs.swww}";
  wpPath = "${/home/laged/wallpapers}";
  wpFile = "wallpaper.jpg";
  name = "laged";
in
{
  home-manager.users.laged.home.packages = with pkgs; [
    swww
  ];
  systemd.user.services = {
    swww-daemon = {
      name = "swww-daemon";
      enable = false;
      description = "swww-daemon?";
      serviceConfig = {
        ExecStart = "${swwwPath}/bin/swww-daemon";
        ExecStartPost = "${swwwPath}/bin/sww img ${wpPath}/${wpFile}";
      };
      wantedBy = [ "graphical.target" ];
    };
  };
}

