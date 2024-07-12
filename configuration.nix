{ config, pkgs, ... }:
{
  imports = [
    <nixpkgs/nixos/modules/installer/netboot/netboot-minimal.nix>
  ];

  system.stateVersion = "24.11";
  time.timeZone = "Europe/Helsinki";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    keyMap = "fi";
  };

  users.users.laged = {
    isNormalUser = true;
    group = "laged";
    extraGroups = [ "wheel" ];
  };

  users.groups.laged = { };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  programs.zsh.enable = true;
  environment.shells = [ pkgs.zsh ];
  users.defaultUserShell = pkgs.zsh;

  environment.systemPackages = with pkgs; [
    vim
    git
];
}
