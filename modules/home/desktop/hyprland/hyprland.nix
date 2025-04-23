{
  flake,
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (flake) inputs;
  cfg = config.programs.hyprland-utils;
in {
  imports = [./hyprlock.nix];
  options.programs.hyprland-utils = {
    enable = lib.mkEnableOption "enable Hyprland config";
  };
  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      package = null;
      portalPackage = null;
      systemd = {
        enable = false;
        # variables = ["--all"];
      };
      xwayland.enable = true;

      extraConfig = ''
        # XDG Specifications
        env = XDG_CURRENT_DESKTOP,Hyprland
        env = XDG_SESSION_TYPE,wayland
        env = XDG_SESSION_DESKTOP,Hyprland

        windowrule = animation popin, class:network
        windowrule = float, class:network
        windowrule = center, class:network
        windowrule = size 600 500, class:network
      '';

      settings = {
        exec-once = [
          "systemctl --user start hyprpolkitagent"
          "fcitx5 -d --replace"
          "udiskie &"
          "wl-paste --type text --watch cliphist store #Stores only text data"
          "wl-paste --type image --watch cliphist store #Stores only image data"
          "hypridle"
          "${pkgs.wpaperd}/bin/wpaperd -d"
        ];

        monitor = [
          ",highres,auto,2"
        ];

        general = {
          layout = "master";
          gaps_in = 5;
          gaps_out = 10;
          border_size = 4;

          "col.active_border" = "0xFFB4A1DB";
          "col.inactive_border" = "0xFF343A40";
        };

        xwayland = {
          force_zero_scaling = true;
        };

        input = {
          kb_layout = "us";
          follow_mouse = 1;

          repeat_rate = 30;
          repeat_delay = 240;

          float_switch_override_focus = 2;

          numlock_by_default = true;

          touchpad = {
            disable_while_typing = false;
            natural_scroll = true;
            tap-and-drag = true;
          };
        };

        gestures = {
          workspace_swipe = true;
          workspace_swipe_fingers = 4;
        };

        misc = {
          disable_hyprland_logo = true;
          focus_on_activate = true;
        };

        decoration = {
          dim_inactive = false;

          blur = {
            enabled = true;
            size = 8;
            passes = 3;
            new_optimizations = "on";
            noise = 0.01;
            contrast = 0.9;
            brightness = 0.8;
            popups = true;
          };
        };

        animations = {
          enabled = "yes";
          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
          animation = [
            "windows, 1, 5, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };

        bind = let
          binding = mod: cmd: key: arg: "${mod}, ${key}, ${cmd}, ${arg}";
          mvfocus = binding "SUPER" "movefocus";
          ws = binding "SUPER" "workspace";
          resizeactive = binding "SUPER CTRL" "resizeactive";
          mvw = binding "CTRL SHIFT" "movewindow";
          mvtows = binding "ALT" "movetoworkspace";
          arr = [
            1
            2
            3
            4
            5
            6
            7
          ];
        in
          [
            # Hyprland relative
            "SUPER, Q, killactive"
            "SUPER, M, exit"
            "SUPER SHIFT, F, fullscreen"
            "SUPER, N, togglefloating"

            # Launch programs
            "SUPER, Return, exec, kitty"
            "SUPER, F, exec, vivaldi"
            "SUPER, W, exec, rofi -show drun -config $XDG_CONFIG_HOME/rofi/config.rasi"
            "SUPER, E, exec, nemo"
            "SUPER, X, exec, wlogout"

            # Clipboard
            "SUPER, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"

            # Scratchpad
            "SUPER, O, exec, [movetoworkspace special:terminal; float; center; size 600 500] kitty"
            "SUPER, U, cyclenext"
            "ALT, Y, exec, [movetoworkspace special:folder; float; center; size 600 500] kitty yazi"
            "ALT, B, exec, [movetoworkspace special:bluetooth; float; center; size 600 500] kitty bluetui"

            # Toggle_special
            "SUPER SHIFT, I, togglespecialworkspace, special"
            "SUPER, I, movetoworkspace, special"

            # Screen Capture
            "SUPER, P, exec, grimblast --notify copysave area"
            "SUPER SHIFT, P, exec, grimblast --notify copysave active"

            # lock screen
            "SUPER SHIFT, L, exec, hyprlock & systemctl suspend"

            # Move focus with SUPER + {h,j,k,l}
            (mvfocus "k" "u")
            (mvfocus "j" "d")
            (mvfocus "l" "r")
            (mvfocus "h" "l")

            # Move windows CTRL + SHIFT + {h,j,k,l}
            (mvw "k" "u")
            (mvw "j" "d")
            (mvw "l" "r")
            (mvw "h" "l")

            # Resize windows with SUPERCTRL + {h,j,k,l}
            (resizeactive "k" "0 -70")
            (resizeactive "j" "0 70")
            (resizeactive "l" "70 0")
            (resizeactive "h" "-70 0")
          ]
          # Switch workspaces with SUPER + [1-7]
          ++ (map (i: ws (toString i) (toString i)) arr)
          ++ (map (i: mvtows (toString i) (toString i)) arr);

        bindm = [
          "SUPER, mouse:273, resizewindow"
          "SUPER, mouse:272, movewindow"
        ];

        bindl = [
          ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86MonBrightnessDown, exec, brightnessctl s 10%-"
          ", XF86MonBrightnessUp, exec, brightnessctl s +10%"
          ", switch: Lid Switch, exec, hyprlock"
        ];
      };
    };
  };
}
