{
  inputs,
  config,
  pkgs,
  ...
}:
let
  user = {
    name = "laged";
    home = "/home/laged";
    email = "parkkila.matti@gmail.com";
  };
in
  {
    imports = [ inputs.home-manager.nixosModules.home-manager ];

    home-manager.users.laged = {
      home.username = "${user.name}";
      home.homeDirectory = "${user.home}";
      home.stateVersion = "24.05";
      home.packages = with pkgs; [
        bat
        bat-extras.batdiff
        bat-extras.batwatch
        eza
        wofi
        zoxide
      ];
      programs = {
        gh.enable = true;
        wofi.enable = true;
        git = {
          enable = true;
          userName = "${user.name}";
          userEmail = "${user.email}"; 
        };
        eza.enable=true;
        zsh = {
          enable = true;
          enableCompletion = true;
          enableAutosuggestions = true;
          autocd = true;
          dotDir = "./config/zsh";
          shellAliases = {
            c = "clear";
            ga = "git add -A";
            gs = "batdiff";
            b = "bat";
            bs = "batdiff --staged";
            bw = "batwatch";
            cd = "z";
            ".." = "cd ..";
            ll = "eza --long";
            ltf = "eza --long --tree --level=5";
          };
          history = {
            size = 1000;
            path = "${user.home}/zsh/history";
          };
          plugins = [
            {
              name = "zsh-autosuggestions";
              src = pkgs.fetchFromGitHub {
                owner = "zsh-users";
                repo = "zsh-autosuggestions";
                rev = "v0.4.0";
                sha256 = "0z6i9wjjklb4lvr7zjhbphibsyx51psv50gm07mbb0kj9058j6kc";
              };
            }
          ];
        };
        starship = {
          enable = true;
          enableZshIntegration = true;
        };
        zoxide = {
          enable = true;
          enableZshIntegration = true;
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
