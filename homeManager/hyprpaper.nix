{ config, lib, ... }:
{
  home-manager.users.laged.services.hyprpaper = {
    enable = true;
    settings = {
      splash = true;
      "$wallpaper" = "/home/laged/wallpapers/cat.jpg";
      preload = [ "$wallpaper" ];
      wallpaper = [",$wallpaper" ];
    };
  };    
}
