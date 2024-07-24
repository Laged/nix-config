{ config, pkgs, ... }:

let
  homeManager = config.homeManager;
in
{
  home.packages = [ pkgs.zoxide ];

  home.programs.zoxide = {
    enable = true;
  };

  home.file.".zshrc".text = ''
    export PATH="$HOME/.local/bin:$PATH"
    eval "$(zoxide init zsh)"
  '';

  home.file.".zshenv".text = ''
    [[ -f $HOME/.zshrc ]] && source $HOME/.zshrc
  '';
}
