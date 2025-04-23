{
  flake,
  lib,
  config,
  ...
}: let
  inherit (flake) inputs;
  cfg = config.services.catppuccin;
in {
  imports = [
    inputs.catppuccin.nixosModules.catppuccin
  ];

  options.services.catppuccin = {
    enable = lib.mkEnableOption "enable catppuccin theme";
  };
  config = lib.mkIf cfg.enable {
    catppuccin.flavor = "macchiato";
    catppuccin.enable = true;
    catppuccin.sddm.enable = false;
  };
}
