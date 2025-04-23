{
  programs = {
    hyprlock = {
      enable = true;
      extraConfig = ''
        # BACKGROUND
        background {
            monitor =
            path = ~/.config/hypr/hyprlock.png
            blur_passes = 0
            contrast = 0.8916
            brightness = 0.8172
            vibrancy = 0.1696
            vibrancy_darkness = 0.0
        }

        # GENERAL
        general {
            no_fade_in = false
            grace = 0
            disable_loading_bar = false
        }

        # GREETINGS
        label {
            monitor =
            text = Welcome!
            color = rgba(216, 222, 233, .75)
            font_size = 80
            font_family = Maple Mono NF CN
            position = 170, 450
            halign = left
            valign = center
        }

        # Time
        label {
            monitor =
            text = cmd[update:1000] echo "<span>$(date +'%H:%M')</span>"
            color = rgba(216, 222, 233, .75)
            font_size = 60
            font_family = Maple Mono NF CN
            position = 270, 300
            halign = left
            valign = center
        }

        # Day-Month-Date
        label {
            monitor =
            text = cmd[update:1000] echo -e "$(date +"%A, %B %d")"
            color = rgba(216, 222, 233, .75)
            font_size = 38
            font_family = Maple Mono NF CN
            position = 167, 180
            halign = left
            valign = center
        }

        # Profie-Photo
        image {
            monitor =
            path = ~/.config/hypr/konan.jpg
            border_size = 2
            border_color = rgba(255, 255, 255, .75)
            size = 150
            rounding = -1
            rotate = 0
            reload_time = -1
            reload_cmd =
            position = 290, 25
            halign = left
            valign = center
        }

        # USER-BOX
        shape {
            monitor =
            size = 400, 70
            color = rgba(255, 255, 255, .1)
            rounding = -1
            border_size = 0
            border_color = rgba(255, 255, 255, 1)
            rotate = 0
            xray = false # if true, make a "hole" in the background (rectangle of specified size, no rotation)

            position = 180, -140
            halign = left
            valign = center
        }

        # USER
        label {
            monitor =
            text = Hi! $USER :)
            color = rgba(216, 222, 233, 0.80)
            outline_thickness = 0
            dots_size = 0.2 # Scale of input-field height, 0.2 - 0.8
            dots_spacing = 0.2 # Scale of dots' absolute size, 0.0 - 1.0
            dots_center = true
            font_size = 25
            font_family = Maple Mono NF CN
            position = 305, -140
            halign = left
            valign = center
        }

        # INPUT FIELD
        input-field {
            monitor =
            size = 400, 70
            outline_thickness = 0
            dots_size = 0.2 # Scale of input-field height, 0.2 - 0.8
            dots_spacing = 0.2 # Scale of dots' absolute size, 0.0 - 1.0
            dots_center = true
            outer_color = rgba(255, 255, 255, 0)
            inner_color = rgba(255, 255, 255, 0.1)
            font_color = rgb(200, 200, 200)
            fade_on_empty = false
            font_family = Maple Mono NF CN
            placeholder_text = <i><span foreground="##ffffff99">🔒  Enter Pass</span></i>
            hide_input = false
            position = 180, -220
            halign = left
            valign = center
        }
      '';
    };
  };
}
