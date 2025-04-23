{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.services.inputsMethod;
in {
  options.services.inputsMethod = {
    enable = lib.mkEnableOption "enable input method";
  };
  config = lib.mkIf cfg.enable {
    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.waylandFrontend = true;
      fcitx5.addons = with pkgs; [
        (fcitx5-rime.override {
          rimeDataPkgs = with pkgs.nur.repos.linyinfeng.rimePackages;
            withRimeDeps [
              rime-ice
            ];
        })
        fcitx5-chinese-addons
      ];
    };

    # Extra variables not covered by Nixos fcitx module
    # Author: Lan tian
    environment.variables = lib.mkIf (!config.i18n.inputMethod.fcitx5.waylandFrontend) {
      INPUT_METHOD = "fcitx";
      # SDL_IM_MODULE = "fcitx";
      # GLFW_IM_MODULE = "ibus";
      QT_IM_MODULE = "wayland;fcitx;ibus";
      GTK_IM_MODULE = "fcitx";
    };
  };
}
