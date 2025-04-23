{
  pkgs,
  flake,
  lib,
  config,
  ...
}: let
  inherit (flake) inputs;
in {
  # Nix packages to install to $HOME
  #
  # Search for packages here: https://search.nixos.org/packages
  home.packages = with pkgs; [
    # wayland tools
    wl-clipboard
    rofi-wayland
    hyprpolkitagent
    hyprland-qt-support
    libsForQt5.qt5.qtwayland
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast

    # sound and light
    brightnessctl
    alsa-utils
    pavucontrol
    bluetui

    # utils
    ntfs3g
    kdePackages.okular

    # daily app
    wpsoffice-cn
    typora
    nemo
    telegram-desktop
    (element-desktop.override {
      commandLineArgs = [
        "--enable-features=UseOzonePlatform"
        "--ozone-platform=wayland"
        "--enable-wayland-ime"
      ];
    })
    vivaldi
    termius
    qq
    wechat-uos
  ];
}
