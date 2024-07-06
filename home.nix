{ lib, configs, pkgs, ...}:
{
  home.username = "laged";
  home.homeDirectory = "/home/laged";

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

#  programs.alacritty = {
#    enable = true;
#    settings = {
#      env.TERM = "xterm-256color";
#      font = {
#        size = 12;
#        draw_bold_text_with_bright_colors = true;
#      };
#      scrolling.multiplier = 5;
#      selection.save_to_clipboard = true;
#    };
#  };

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}



