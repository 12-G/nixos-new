# A module that automatically imports everything else in the parent folder.
# You can use osConfig to access system config when using Home Manager as a nixos module or darwin module
# https://github.com/nix-community/home-manager/issues/393#issuecomment-1259996423
{
  flake,
  osConfig,
  ...
}: let
  inherit (flake) vars;
  inherit (vars) pc;
  inherit (flake) self;
  isNotWSL = osConfig.networking.hostName != "${pc.w}";
in {
  imports = self.lib.scanFile;
  home.stateVersion = "24.11";
  programs.hyprland-utils.enable = isNotWSL;
  settings.hyprlock.enable = isNotWSL;
  packages.desktop.enable = isNotWSL;
}
