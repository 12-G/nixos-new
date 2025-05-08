{
  flake,
  lib,
  isNotWSL,
  ...
}: let
  inherit (flake) vars;
  inherit (vars) platform;
in {
  imports = [
    ./impermanence.nix
    ./fonts.nix
    ./input.nix
    ./sddm.nix
    ./theme.nix
    ./sys_config.nix
  ];

  services.catppuccin.enable = lib.mkDefault true;
  services.sddm.enable = lib.mkDefault true;
  services.inputsMethod.enable = lib.mkDefault true;
  programs.impermanence.enable = isNotWSL;
}
