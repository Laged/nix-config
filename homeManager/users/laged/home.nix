{ config, pkgs, ... }:
{
  home.username = "laged";
  home.homeDirectory = "/home/laged";
  home.stateVersion = "24.05";
  home.packages = with pkgs; [
    curl
    jq
  ];

  programs.git = {
    enable = true;
    userName = "Laged";
    userEmail = "parkkila.matti@gmail.com";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
  };

  programs.vim = {
    enable = true;
    settings = {
      relativenumber = true;
      number = true;
    };
  };
  programs.gh = {
    enable = true;
  };
  programs.kitty = {
    enable = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor= [
	"DP-1,2560x1440@144.00Hz,2560x0,1"
	"DP-3,2560x1440@165.00Hz,0x0,1"
      ];
      "$mod" = "SUPER";
      input = {
        kb_layout = "fi";
      };
      windowrule = [
	"opacity 0.9 override 0.5 override,^(kitty)$"
	"opacity 0.9 override 0.8 override,^(firefox)$"
      ];
      #windowrule = "opacity 0.9 override 0.8 override,^(firefox)$";
    };
  };
}
