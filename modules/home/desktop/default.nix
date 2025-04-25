{
  flake,
  config,
  ...
}: let
  inherit (flake) inputs;
  inherit (flake) vars;
  nvimConfig = "${vars.nvchadPath}";
in {
  imports = [
    ./hyprland/hyprland.nix
    ./packages.nix
    ./hyprland/hyprlock.nix
  ];
  home.file.".config/hypr/hyprlock.png" = {
    enable = true;
    source = ./hyprland/hyprlock.png;
  };
  home.file.".config/hypr/konan.jpg" = {
    enable = true;
    source = ./hyprland/konan.jpg;
  };
  home.file.".config/rofi/fonts.rasi" = {
    enable = true;
    source = ./rofi/fonts.rasi;
  };
  home.file.".config/rofi/nord.rasi" = {
    enable = true;
    source = ./rofi/nord.rasi;
  };
  home.file.".config/rofi/config.rasi" = {
    enable = true;
    source = ./rofi/configuration.rasi;
  };
  home.file.".local/share/fcitx5/rime/default.custom.yaml" = {
    enable = true;
    source = ./fcitx5/default.custom.yaml;
  };

  home.file.".local/share/fcitx5/rime/rime_ice.custom.yaml" = {
    enable = true;
    source = ./fcitx5/rime_ice.custom.yaml;
  };
  home.file."Pictures/wallpapers" = {
    enable = true;
    source = "${inputs.wallpapers}";
    recursive = true;
  };

  home.file.".config/wlogout/logout.png" = {
    enable = true;
    source = ./wlogout/logout.png;
  };
  home.file.".config/wlogout/lock.png" = {
    enable = true;
    source = ./wlogout/lock.png;
  };
  home.file.".config/wlogout/reboot.png" = {
    enable = true;
    source = ./wlogout/reboot.png;
  };
  home.file.".config/wlogout/shutdown.png" = {
    enable = true;
    source = ./wlogout/shutdown.png;
  };
  home.file.".config/wlogout/hibernate.png" = {
    enable = true;
    source = ./wlogout/hibernate.png;
  };
  home.file.".config/wlogout/suspend.png" = {
    enable = true;
    source = ./wlogout/suspend.png;
  };
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink nvimConfig;
  #
  # home.file.".ssh/authorized_keys" = {
  #   enable = true;
  #   text = lib.concatStringsSep "\n" me.ssh_authorized_keys;
  # };
}
