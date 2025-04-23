{
  pkgs,
  lib,
  config,
  ...
}: let
  sddm-astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "astronaut";
    themeConfig = {
      Font = "Maple Mono NF CN";
      FontSize = 20;
    };
  };
  cfg = config.services.sddm;
in {
  options.services.sddm = {
    enable = lib.mkEnableOption "enable astronaut theme of sddm";
  };
  config = lib.mkIf cfg.enable {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      package = pkgs.kdePackages.sddm;
      extraPackages = [sddm-astronaut];
      theme = lib.mkForce "sddm-astronaut-theme";
    };

    environment.systemPackages = [sddm-astronaut];
  };
}
