{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [ ./nix-settings.nix ];
  system.stateVersion = "24.05";
  time.timeZone = "Europe/Helsinki";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    keyMap = "fi";
  };
  users = {
    users.laged = {
      isNormalUser = true;
      uid = 1000;
      group = "laged";
      initialPassword = "matti";
      extraGroups = [
        "wheel"
        "video"
        "input"
      ];
      shell = pkgs.zsh;
      packages = with pkgs; [
        kitty
        firefox
      ]; 
    };
    groups.laged = {
      gid = 1000;
    };
  };
  security.sudo = {
    enable = lib.mkDefault true;
    wheelNeedsPassword = lib.mkForce false;
  };
  boot.kernelParams = [ "boot.shell_on_fail" ];
  services.dbus.enable = true;
  programs = {
    zsh.enable = true;
    git.enable = true;
    vim.defaultEditor = true;
    hyprland.enable = true;
  };
  environment.shells = [ pkgs.zsh ];
  environment.systemPackages = [ pkgs.home-manager ];
  users.defaultUserShell = pkgs.zsh;
  hardware.enableRedistributableFirmware = true;
  hardware.opengl = {
    enable = true;
    driSupport = true;
  };
  # https://github.com/colemickens/nixcfg/blob/dea191cc9930ec06812d4c4d8ef0469688ddcb7e/mixins/gfx-nvidia.nix
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.nvidiaSettings = true;
  services.getty.autologinUser = "laged";
}
