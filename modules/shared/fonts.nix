{
  pkgs,
  lib,
  config,
  ...
}: {
  fonts = {
    fontDir.enable = true;

    packages = with pkgs; [
      # Noto for no tofu
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      noto-fonts-extra

      # maple fonts
      maple-mono.NF
      maple-mono.NF-CN

      # nerdfonts
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
    ];

    fontconfig.defaultFonts = {
      serif = [
        "Noto Serif"
        "Noto Color Emoji"
      ];
      sansSerif = [
        "Noto Sans"
        "Noto Color Emoji"
      ];
      monospace = [
        "Maple Mono NF CN"
        "Noto Color Emoji"
      ];
      emoji = ["Noto Color Emoji"];
    };
  };
}
