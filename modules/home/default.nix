# A module that automatically imports everything else in the parent folder.
# You can use osConfig to access system config when using Home Manager as a nixos module or darwin module
# https://github.com/nix-community/home-manager/issues/393#issuecomment-1259996423
{
  flake,
  osConfig,
  lib,
  ...
}: let
  inherit (flake) vars;
  inherit (vars) pc;
  isNotWSL = osConfig.networking.hostName != "${pc.w}";
in {
  imports = with builtins;
    map (fn: ./${fn}) (filter (fn: fn != "default.nix") (attrNames (readDir ./.)))
    ++ lib.optionals isNotWSL [
      ./desktop/xdg.nix
      ./desktop/hyprland/waybar.nix
      ./desktop/hyprland/wlogout.nix
      ./desktop/hyprland/utils.nix
    ];

  home.stateVersion = "24.11";
  programs.hyprland-utils.enable = isNotWSL;
  settings.hyprlock.enable = isNotWSL;
  packages.desktop.enable = isNotWSL;
}
