{
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager.users.laged = {
    home.username = "laged";
    home.homeDirectory = "/home/laged";
    home.stateVersion = "24.05";
    home.packages = with pkgs; [
      wofi
      zoxide
    ];
    programs = {
      gh.enable = true;
      wofi.enable = true;
      zoxide.enable = true;
      git = {
        enable = true;
        userName = "Laged";
        userEmail = "parkkila.matti@gmail.com";
      };
      zsh = {
        enable = true;
        enableCompletion = true;
      };
      vim = {
        enable = true;
        settings = {
          relativenumber = true;
          number = true;
        };
      };
    };
    wayland.windowManager.hyprland = {
      enable = true;
      extraConfig = builtins.readFile ./.config/hyprland.conf;
    };
  };
}
