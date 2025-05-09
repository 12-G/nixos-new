{
  self,
  inputs,
  lib,
  ...
}: let
  vars = import ./vars.nix {inherit self;};
  specialArgsFor = rec {
    common = {
      flake = {
        inherit
          self
          vars
          inputs
          ;
      };
    };
    nixos = common;
    # darwin =
    #   common
    #   // {
    #     rosettaPkgs = import inputs.nixpkgs {system = "x86_64-darwin";};
    #   };
  };

  nixosModules = {
    # Linux home-manager module
    home-manager = {
      imports = [
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = specialArgsFor.nixos;
          home-manager.sharedModules = [homeModules.common];
        }
      ];
    };

    # Common and useful setting across all platforms
    common = {lib, ...}: {
      nix = {
        settings = {
          # Use all CPU cores
          max-jobs = lib.mkDefault "auto";
          # Duh
          experimental-features = lib.mkDefault "nix-command flakes";
          system-features = ["recursive-nix"];
          #optimise storage
          auto-optimise-store = true;
          trusted-users = ["${vars.username}"];
          substituters = [
            "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
            "https://cache.nixos.org"
            "https://hyprland.cachix.org"
          ];

          trusted-public-keys = [
            "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
            "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
          ];
        };

        gc = {
          automatic = true;
          dates = "weekly";
          options = "--delete-older-than 3d";
        };
      };

      nixpkgs = {
        config = {
          allowUnfree = true;
        };
        overlays = [
          inputs.nur.overlays.default
        ];
      };
    };
  };

  homeModules = {
    common = {
      config,
      pkgs,
      ...
    }: {
      # Sensible default for `home.homeDirectory`
      home.homeDirectory = lib.mkDefault "/${
        if pkgs.stdenv.isDarwin
        then "Users"
        else "home"
      }/${config.home.username}";

      # For macOS, $PATH must contain these.
      # home.sessionPath = lib.mkIf pkgs.stdenv.isDarwin [
      #   "/etc/profiles/per-user/$USER/bin" # To access home-manager binaries
      #   "/nix/var/nix/profiles/system/sw/bin" # To access nix-darwin binaries
      #   "/usr/local/bin" # Some macOS GUI programs install here
      # ];
    };
  };
  # darwinModules = {
  #   # macOS home-manager module
  #   home-manager = {
  #     imports = [
  #       inputs.home-manager.darwinModules.home-manager
  #       {
  #         home-manager.useGlobalPkgs = true;
  #         home-manager.useUserPackages = true;
  #         home-manager.extraSpecialArgs = specialArgsFor.darwin;
  #         home-manager.sharedModules = [homeModules.common];
  #       }
  #     ];
  #   };
  # };
in {
  config = {
    flake = {
      lib = {
        inherit specialArgsFor;

        mkLinuxSystem = {home-manager ? true}: mod:
          inputs.nixpkgs.lib.nixosSystem {
            # Arguments to pass to all modules.
            specialArgs = specialArgsFor.nixos;
            modules =
              [
                self.sharedModules.default
                nixosModules.common
                mod
              ]
              ++ lib.optional home-manager nixosModules.home-manager;
          };

        # mkMacosSystem = {home-manager ? true, wsl ? false}: mod:
        #   inputs.nix-darwin.lib.darwinSystem {
        #     specialArgs = specialArgsFor.darwin;
        #     modules =
        #       [
        #         self.sharedModules.default
        #         nixosModules.common
        #         mod
        #       ]
        #       ++ lib.optional home-manager darwinModules.home-manager;
        #   };

        mkHomeConfiguration = pkgs: mod:
          inputs.home-manager.lib.homeManagerConfiguration {
            inherit pkgs; # cf. https://github.com/nix-community/home-manager/issues/3075
            extraSpecialArgs = specialArgsFor.common;
            modules = [
              homeModules.common
              mod
            ];
          };
      };
    };
  };
}
