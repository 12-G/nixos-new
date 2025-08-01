{
  # programs.foot = {
  #   enable = true;
  #   settings = {
  #     main = {
  #       term = "xterm-256color";
  #       dpi-aware = "yes";
  #     };
  #     cursor = {
  #       color = "282a36 f8f8f2";
  #     };
  #     colors = {
  #       foreground = "f8f8f2";
  #       background = "282a36";
  #       regular0 = "000000";
  #       regular1 = "ff5555";
  #       regular2 = "50fa7b";
  #       regular3 = "f1fa8c";
  #       regular4 = "bd93f9";
  #       regular5 = "ff79c6";
  #       regular6 = "8be9fd";
  #       regular7 = "bfbfbf";
  #       bright0 = "4d4d4d";
  #       bright1 = "ff6e67";
  #       bright2 = "5af78e";
  #       bright3 = "f4f99d";
  #       bright4 = "cac9fa";
  #       bright5 = "ff92d0";
  #       bright6 = "9aedfe";
  #       bright7 = "e6e6e6";
  #     };
  #   };
  # };
  programs.kitty = {
    enable = true;
    font = {
      name = "Maple Mono NF CN";
      size = 10;
    };
    shellIntegration.enableFishIntegration = true;
    settings = {
      scrollback_lines = 5000;
    };
  };
}
