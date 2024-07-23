{ config, pkgs, ... }:
{
  home.username = "laged";
  home.homeDirectory = "/home/laged";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
  home-manager.users.laged = {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        input = {
          kb_layout = "us";
        };
      };
    };
  };
}
