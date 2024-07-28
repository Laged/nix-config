{ pkgs, ... }:

{
  stylix = {
    enable = true;
    image = ./wallpapers/cat.jpg;
    polarity = "dark";
    fonts = {
      monospace = {
        package = pkgs.nerdfonts.override { fonts = ["FiraCode"]; };
        name = "FiraCode Nerd Font";
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}

