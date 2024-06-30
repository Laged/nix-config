{ config, pkgs, ... }:
{
  imports = [
    <nixpkgs/nixos/modules/installer/netboot/netboot-minimal.nix>
  ];

  time.timeZone = "Europe/Helsinki";
  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    keyMap = "fi";
  };

  programs.sway.enable = true;

  sound.enable = true;
  nixpkgs.config.pulseaudio = true;
  hardware.pulseaudio.enable = true;

  environment.shells = [ pkgs.zsh ];

  users.defaultUserShell = pkgs.zsh;

  environment.systemPackages = with pkgs; [
    zsh
  ];
}
