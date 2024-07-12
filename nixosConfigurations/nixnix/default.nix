{ config, pkgs, lib, ... }:
{
  system.stateVersion = "24.05";
  time.timeZone = "Europe/Helsinki";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    keyMap = "fi";
  };

  users.users.laged = {
    isNormalUser = true;
    group = "laged";
    extraGroups = [ "wheel" "video" "input" ];
  };

  users.groups.laged = { };
  security.sudo = {
    enable = lib.mkDefault true;
    wheelNeedsPassword = lib.mkForce false;
  };
  boot.kernelParams = [
    "boot.shell_on_fail"
  ];

  programs.zsh.enable = true;
  environment.shells = [ pkgs.zsh ];
  users.defaultUserShell = pkgs.zsh;

  hardware.opengl = {
    enable = true;
    driSupport = true;
  };
  # https://github.com/colemickens/nixcfg/blob/dea191cc9930ec06812d4c4d8ef0469688ddcb7e/mixins/gfx-nvidia.nix
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.nvidiaSettings = true;

  environment.systemPackages = with pkgs; [
    vim
    git
  ];
}
