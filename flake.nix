{
  description = "A home-manager template providing useful tools & settings for Nix-based development";

  # nixConfig = {
  #   extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
  #   extra-substituters = "https://devenv.cachix.org";
  # };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} (
      {lib, ...}: {
        imports = [
          ./modules/flake
        ];
        systems = lib.systems.flakeExposed;
      }
    );

  inputs = {
    # Principle inputs (updated by `nix run .#update`)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    # Third-party software package for NixOS
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";

    sops-nix.url = "github:Mic92/sops-nix";

    # A tool that format your disk at the beginning of installation
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Persist your folder
    impermanence.url = "github:nix-community/impermanence";

    # My favorite editor
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    # Check your code status
    pre-commit-hooks.url = "github:cachix/git-hooks.nix";

    # My favorite DE
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wallpapers = {
      url = "github:12-G/wallpapers";
      flake = false;
    };

    # Theme
    catppuccin.url = "github:catppuccin/nix";

    # Software inputs
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
