{ inputs
, pkgs
, lib
, ...
}:
let
  user = {
    name = "laged";
    home = "/home/laged";
    email = "parkkila.matti@gmail.com";
  };
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./stylix.nix
    ./swww.nix
  ];

  home-manager.users.laged = {
    home.username = "${user.name}";
    home.homeDirectory = "${user.home}";
    home.stateVersion = "24.05";
    home.packages = with pkgs; [
      hello
      bat
      bat-extras.batdiff
      bat-extras.batwatch
      eza
      file
      hyprpaper
      nil
      systemd
      wofi
      yazi
      zoxide
    ];
    programs = {
      direnv = {
        enable = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
      };
      gh.enable = true;
      wofi.enable = true;
      git = {
        enable = true;
        userName = "${user.name}";
        userEmail = "${user.email}";
      };
      eza.enable = true;
      helix = {
        enable = true;
          settings = {
          theme = lib.mkForce "sonokai";
          editor = {
            line-number = "relative";
            auto-completion = true;
            auto-save = true;
            auto-format = true;
            shell = ["zsh"];
            cursorline = true;
            bufferline = "multiple";
            gutters = [ "diff" "diagnostics" "line-numbers" "spacer"];
            lsp = {
              enable = true;
              auto-signature-help = true;
              display-messages = true;
              display-inlay-hints = true;
            };
            indent-guides = {
              render = true;
              character = "┊";
              skip-levels = 1;
            };
          };
        };
        languages.language = [{
          name = "rust";
          auto-format = true;
        }];
      };
      kitty = {
        enable = true;
        shellIntegration.enableZshIntegration = true;
      };
      zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        autocd = true;
        dotDir = ".config/zsh";
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
        initExtra = ''
          function yy() {
          local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
          yazi "$@" --cwd-file="$tmp"
          if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
              builtin cd -- "$cwd"
          fi
          rm -f -- "$tmp"
          }
        '';
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
      yazi = {
        enable = true;
        enableZshIntegration = true;
        settings = {
          manager = {
            show_hidden = true;
          };
          preview = {
            max_width = 1000;
            max_height = 1000;
          };
        };
      };
      waybar = {
        enable = true;
        settings = [
          {
            layer = "top";
            position = "top";
            output = [
              "DP-1"
              "DP-3"
            ];
            modules-left = [ "hyprland/workspaces" ];
            modules-center = [ "hyprland/window" ];
            modules-right = [ "clock" ];
            "hyprland/workspaces" = {
              "format" = "{icon}";
              "on-scroll-up" = "hyprctl dispatch workspace e+1";
              "on-scroll-down" = "hyprctl dispatch workspace e-1";
              "active-only" = false;
              "all-outputs" = false;
              "disable-scroll" = false;
              "persistent_workspaces" = {
                "1" = [ ];
                "2" = [ ];
                "3" = [ ];
                "4" = [ ];
                "5" = [ ];
                "6" = [ ];
                "7" = [ ];
                "8" = [ ];
                "9" = [ ];
                "10" = [ ];
              };
              "sort-by-number" = true;
            };
          }
        ];
        style = ''
          ${builtins.readFile "${pkgs.waybar}/etc/xdg/waybar/style.css"}
          window#waybar, #clock {
          background: transparent;
          font-family: "FiraCode Nerd Font";
          border-bottom: none;
          }
        '';
      };
    };
    home.file.wallpapers = {
      source = ./wallpapers;
      target = "/home/laged/wallpapers";
      recursive = true;
    };
    home.file.hyprstart = {
      source = ./.config/hypr/hyprstart.sh;
      target = "/home/laged/.config/hypr/hyprstart.sh";
    };
    wayland.windowManager.hyprland = {
      enable = true;
      extraConfig = builtins.readFile ./.config/hypr/hyprland.conf;
    };
  };
}
