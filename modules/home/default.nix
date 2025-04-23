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
in {
  imports = with builtins;
    map (fn: ./${fn}) (filter (fn: fn != "default.nix") (attrNames (readDir ./.)));
  home.stateVersion = "24.11";
  programs.hyprland-utils.enable = osConfig.networking.hostName != "${pc.w}";
}
