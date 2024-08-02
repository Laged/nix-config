# https://xyno.space/post/nix-darwin-introduction
# https://github.com/Misterio77/nix-starter-configs/tree/main/standard
# https://sourcegraph.com/github.com/shaunsingh/nix-darwin-dotfiles@8ce14d457f912f59645e167707c4d950ae1c3a6e/-/blob/flake.nix
{

  nixConfig = {
    extra-substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      "https://nixpkgs-wayland.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
    ];
  };

  inputs = {
    age-plugin-fido2-hmac.url = "github:jhvst/nix-config?dir=packages/age-plugin-fido2-hmac";
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    homestakeros-base.url = "github:ponkila/homestakeros?dir=nixosModules/base";
    nixpkgs.url = "github:NixOS/nixpkgs/24.05";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";
    sounds.inputs.nixpkgs.follows = "nixpkgs";
    sounds.url = "github:jhvst/nix-config?dir=packages/sounds";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
    swww.url = "github:LGFae/swww";
    swww.inputs.nixpkgs.follows = "nixpkgs";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    wayland.inputs.nixpkgs.follows = "nixpkgs";
    wayland.url = "github:nix-community/nixpkgs-wayland";
  };

  outputs =
    { self, ... }@inputs:

    inputs.flake-parts.lib.mkFlake { inherit inputs; } rec {

      systems = inputs.nixpkgs.lib.systems.flakeExposed;
      imports = [
        inputs.flake-parts.flakeModules.easyOverlay
        inputs.treefmt-nix.flakeModule
      ];

      perSystem =
        { pkgs
        , config
        , system
        , ...
        }:
        {

          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [ self.overlays.default ];
            config = { };
          };

          overlayAttrs = { };

          treefmt.config = {
            projectRootFile = "flake.nix";
            flakeFormatter = true;
            flakeCheck = true;
            programs = {
              nixpkgs-fmt.enable = true;
              deadnix.enable = true;
              statix.enable = true;
            };
            settings.global.excludes = [ "*/flake.nix" ];
          };

          devShells = {
            default = pkgs.mkShell {
              nativeBuildInputs = with pkgs; [
                cpio
                git
                jq
                nix
                ripgrep
                rsync
                sops
                ssh-to-age
                zstd
              ];
            };
          };

          packages = {
            "nixnix" = flake.nixosConfigurations.nixnix.config.system.build.kexecTree;
          };
        };

      flake =
        let
          inherit (self) outputs;

          nixnix = {
            system = "x86_64-linux";
            specialArgs = {
              inherit inputs outputs;
            };
            modules = [
              inputs.stylix.nixosModules.stylix
              ./homeManager/home.nix
              ./nixosConfigurations/configuration.nix
              inputs.home-manager.nixosModules.home-manager
              inputs.homestakeros-base.nixosModules.kexecTree
              inputs.sops-nix.nixosModules.sops
              {
                home-manager.useGlobalPkgs = true;
                home-manager.backupFileExtension = "hm-backup";
                nixpkgs.overlays = [ inputs.wayland.overlay ];
              }
            ];
          };

        in
        {

          nixosConfigurations =
            with inputs.nixpkgs.lib;
            { "nixnix" = nixosSystem nixnix; } // (with inputs.nixpkgs-stable-patched.lib; { });
        };
    };
}
