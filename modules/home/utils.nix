{
  services = {
    # wallpaper
    wpaperd = {
      enable = true;
      settings = {
        default = {
          path = "/home/ethan/Pictures/wallpapers";
          mode = "center";
          duration = "5m";
        };

        default.transition.fade = {
        };
      };
    };

    udiskie = {
      enable = true;
      automount = true;
      notify = true;
    };

    cliphist = {
      enable = true;
      allowImages = true;
    };

    hypridle = {
      enable = true;
      settings = {
        general = {
          ignore_dbus_inhibit = true;
          ignore_systemd_inhibit = true;
          inhibit_sleep = 0;
          lock_cmd = "pidof hyprlock || hyprlock"; # avoid starting multiple hyprlock instances.
          before_sleep_cmd = "loginctl lock-session"; # lock before suspend.
          after_sleep_cmd = "hyprctl dispatch dpms on"; # to avoid having to press a key twice to turn on the display.
        };
        listener = [
          {
            timeout = 270;
            on-timeout = "brightnessctl -s set 80";
            on-resume = "brightnessctl -s set 200";
          }
          {
            timeout = 290;
            on-timeout = "brightnessctl -s set 40";
            on-resume = "brightnessctl -s set 200";
          }
          {
            timeout = 300;
            on-timeout = "loginctl lock-session";
          }
          {
            timeout = 310;
            on-timeout = "hyprctl dispatch dpms off & systemctl suspend";
            on-resume = "hyprctl dispatch dpms on";
          }
        ];
      };
    };
  };
}
