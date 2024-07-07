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

  programs.vim = {
    enable = true;
    settings = {
      relativenumber = true;
      number = true;
    };
  };

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}



