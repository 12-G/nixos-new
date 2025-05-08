{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        margin-top = 6;
        margin-left = 10;
        margin-right = 10;
        spacing = 5;

        modules-left = [
          "cpu"
          "memory"
          "temperature"
          "backlight"
          "battery"
        ];

        modules-center = [
          "hyprland/workspaces"
        ];

        modules-right = [
          "idle_inhibitor"
          "pulseaudio"
          "network"
          "tray"
          "clock"
          "custom/notification"
          "custom/power"
        ];

        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          show-special = true;
          special-visbile-only = true;
          format = "{icon}";
          format-icons = {
            # "1" = "󰋜";
            # "2" = "";
            # "3" = "";
            # "4" = "󰙯";
            # "5" = "󰎄";
            # "6" = "󰎆";
            # "7" = "󰎇";
            # "8" = "󰎉";
            # "9" = "󰎋";
            # "10" = "󰎍";
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
            "10" = "10";
            urgent = "󰗖";
            focused = "󰗖";
            default = "󰋔";
            special = "󰎍";
          };
        };

        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "󰅶";
            deactivated = "󰾪";
          };
          tooltip = true;
          tooltip-format-activated = "Idle Inhibitor Active";
          tooltip-format-deactivated = "Idle Inhibitor Inactive";
        };

        "tray" = {
          icon-size = 18;
          spacing = 10;
        };

        "clock" = {
          interval = 1;
          format = "{:%a %b %d %H:%M:%S %p}";
          tooltip-format = "<big>{:%B %Y}</big>\n<tt>{calendar}</tt>";
          calendar = {
            mode = "month";
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#268bd2'>{}</span>";
              days = "<span color='#93a1a1'>{}</span>";
              weeks = "<span color='#cb4b16'>{}</span>";
              weekdays = "<span color='#2aa198'>{}</span>";
              today = "<span color='#d33682'><b>{}</b></span>";
            };
          };
          actions = {
            on-click = "mode";
          };
        };

        "cpu" = {
          format = "󰘚 {usage}%";
          tooltip = true;
          interval = 2;
        };

        "memory" = {
          format = "󰍛 {percentage}%";
          tooltip = true;
          tooltip-format = "RAM: {used:0.1f}GiB/{total:0.1f}GiB";
          interval = 3;
        };

        "temperature" = {
          critical-threshold = 80;
          format = "{icon} {temperatureC}°C";
          format-icons = [
            "󰔏"
            "󰔐"
            "󱃂"
          ];
          tooltip = true;
        };

        "backlight" = {
          format = "{icon} {percent}%";
          format-icons = [
            "󰃞"
            "󰃟"
            "󰃠"
          ];
          on-scroll-up = "brightnessctl -s set +5%";
          on-scroll-down = "brightnessctl -s set 5%-";
        };

        "battery" = {
          states = {
            good = 80;
            warning = 30;
            critical = 15;
          };
          interval = 30;
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󰚥 {capacity}%";
          format-alt = "{time} {icon}";
          format-icons = [
            "󰂎"
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
        };

        "network" = {
          format-wifi = "󰤨 {essid}";
          format-ethernet = "󰈀 {ipaddr}/{cidr}";
          format-disconnected = "󰤮 Disconnected";
          tooltip-format = "{ifname}: {ipaddr}/{cidr}\n󰤨 {essid} ({signalStrength}%)\n󱘖 {bandwidthUpBits}\n󱘒 {bandwidthDownBits}";
          on-click = "hyprctl dispatch -- exec kitty --class=network nmtui";
        };

        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-muted = "󰝟 Muted";
          format-icons = {
            headphone = "󰋋";
            hands-free = "󰋎";
            headset = "󰋎";
            phone = "󰏲";
            portable = "󰄝";
            car = "󰄋";
            default = [
              "󰕿"
              "󰖀"
              "󰕾"
            ];
          };
          on-click = "pavucontrol";
          on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
          on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        };
        "custom/power" = {
          format = "󰐥";
          on-click = "wlogout";
          tooltip = false;
        };
        "custom/notification" = {
          tooltip = false;
          format = "{} {icon}";
          format-icons = {
            notification = "<span foreground='red'><sup></sup></span>";
            none = "";
            dnd-notification = "<span foreground='red'><sup></sup></span>";
            dnd-none = "";
            inhibited-notification = "<span foreground='red'><sup></sup></span>";
            inhibited-none = "";
            dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
            dnd-inhibited-none = "";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
        };
      };
    };

    style = ''
      /* Nord Theme for Waybar */


      @define-color foreground #F5FBFE;
      @define-color background #111413;
      @define-color background-alt rgba(17,20,19,0.25);

      /* Polar Night */
      @define-color color0 #2E3440;
      @define-color color1 #3B4252;
      @define-color color2 #434C5E;
      @define-color color3 #4C566A;

      /* Snow Storm */
      @define-color color4 #D8DEE9;
      @define-color color5 #E5E9F0;
      @define-color color6 #ECEFF4;

      /* Frost */
      @define-color color7 #8FBCBB;
      @define-color color8 #88C0D0;
      @define-color color9 #81A1C1;
      @define-color color10 #5E81AC;

      /* Aurora */
      @define-color color11 #BF616A;
      @define-color color12 #D08770;
      @define-color color13 #EBCB8B;
      @define-color color14 #A3BE8C;
      @define-color color15 #B48EAD;


      * {
          border: none;
          border-radius: 0;
          font-family: "JetBrainsMono Nerd Font";
          font-size: 14px;
          min-height: 0;
          transition-property: background-color;
          transition-duration: 0.2s;
      }

      window#waybar {
          background-color: rgba(0, 43, 54, 0.0);  /* Transparent background */
          color: @color4;
      }

      tooltip {
          background-color: @color0;
          border: 2px solid @color13;
          border-radius: 8px;
      }

      tooltip label {
          color: @color5;
      }

      /* Floating module style - common properties */
      #workspaces button,
      #mode,
      #clock,
      #cpu,
      #memory,
      #temperature,
      #battery,
      #network,
      #pulseaudio,
      #tray,
      #custom-power,
      #custom-notification,
      #idle_inhibitor,
      #language,
      #backlight,
      #window,
      #disk {
          margin: 5px 2px;
          padding: 0 12px;
          border-radius: 10px;
          background-color: @color1;
          color: @color5;
          box-shadow: 0 2px 3px rgba(0, 0, 0, 0.2);
      }

      /* Workspaces module */
      #workspaces button {
          padding: 0 6px;
          background-color: @color1;
          color: @color4;
          min-width: 20px;
      }

      #workspaces button:hover {
          background-color: @color2;
          box-shadow: 0 2px 3px rgba(0, 0, 0, 0.3);
      }

      #workspaces button.active {
          background-color: @color13;
          color: @color0;
          box-shadow: inset 0 0 0 2px @color6;
          text-shadow: 0 0 5px @color7;
      }

      #workspaces button.urgent {
          background-color: @color10;
          color: @color7;
      }

      #workspaces button.special {
          background-color: @color3;
          color: @color7;
      }

      /* Clock module, Scripts module and window title */
      #clock, #window {
          background-color: @color14;
          color: @color0;
          font-weight: bold;
      }

      /* System modules */
      #cpu {
          background-color: @color15;
          color: @color0;
      }

      #memory {
          background-color: @color8;
          color: @color0;
      }

      #temperature {
          background-color: @color9;
          color: @color0;
      }

      #temperature.critical {
          background-color: @color10;
          color: @color7;
          animation: blink 1s infinite alternate;
      }

      /* Battery module */
      #battery {
          background-color: @color12;
          color: @color0;
      }

      #battery.charging {
          background-color: @color15;
          color: @color0;
      }

      #battery.warning:not(.charging) {
          background-color: @color8;
          color: @color0;
      }

      #battery.critical:not(.charging) {
          background-color: @color10;
          color: @color7;
          animation: blink 1s infinite alternate;
      }

      /* Network module */
      #network {
          background-color: @color13;
          color: @color0;
      }

      #network.disconnected {
          background-color: @color10;
          color: @color7;
      }

      /* Media modules */
      #pulseaudio {
          background-color: @color11;
          color: @color0;
      }

      #pulseaudio.muted {
          background-color: @color2;
          color: @color5;
      }

      #backlight {
          background-color: @color8;
          color: @color0;
      }

      /* Language module */
      #language {
          background-color: @color9;
          color: @color0;
          min-width: 40px;
      }

      /* Custom modules */
      #custom-power {
          background-color: @color10;
          color: @color7;
          margin-right: 6px;
      }

      #custom-notification {
          background-color: @color2;
          color: @color5;
          margin-right: 6px;
      }

      /* System tray */
      #tray {
          background-color: @color1;
      }

      #tray > .passive {
          -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
          -gtk-icon-effect: highlight;
          background-color: @color10;
      }

      /* Disk usage */
      #disk {
          background-color: @color15;
          color: @color0;
      }

      /* Animation for critical indicators */
      @keyframes blink {
          to {
              background-color: @color7;
              color: @color10;
          }
      }

      /* Idle inhibitor module */
      #idle_inhibitor {
          background-color: @color2;
          color: @color5;
      }

      #idle_inhibitor.activated {
          background-color: @color8;
          color: @color0;
      }
    '';
    systemd.enable = true;
  };
}
