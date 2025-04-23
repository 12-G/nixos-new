{config, ...}: {
  services.swaync = {
    enable = true;
    settings = {
      positionX = "right";
      positionY = "top";
      layer = "overlay";
      control-center-layer = "top";
      layer-shell = true;
      control-center-margin-top = 10;
      control-center-margin-bottom = 10;
      control-center-margin-right = 10;
      control-center-margin-left = 10;
      notification-icon-size = 24;
      notification-body-image-height = 100;
      notification-body-image-width = 100;
      notification-window-width = 300;
      timeout = 10;
      timeout-low = 5;
      timeout-critical = 0;
      fit-to-screen = false;
      control-center-width = 450;
      control-center-height = 720;
      keyboard-shortcuts = true;
      image-visibility = "when-available";
      transition-time = 200;
      hide-on-clear = false;
      hide-on-action = true;
      script-fail-notify = true;
      widget-config = {
        title = {
          text = "Notification Center";
          clear-all-button = true;
          button-text = "󰆴 Clear All";
        };
        dnd = {
          text = "Do Not Disturb";
        };
        label = {
          max-lines = 1;
          text = "Notification Center";
        };
        mpris = {
          image-size = 96;
          image-radius = 7;
        };
        volume = {
          label = " 󰕾  ";
        };
        backlight = {
          label = " 󰃟  ";
        };
        buttons-grid = {
          actions = [
            {
              label = "󰐥";
              command = "wlogout";
            }
            {
              label = "󰌾";
              command = "hyprlock";
            }
            {
              label = "󰍃";
              command = "hyprctl dispatch exit";
            }
            {
              label = "󰝟";
              command = "amixer set Master toggle";
            }
            {
              label = "󰂯";
              command = "blueman-manager";
            }
          ];
        };
      };
      widgets = [
        "title"
        "buttons-grid"
        "mpris"
        "volume"
        "backlight"
        "dnd"
        "notifications"
      ];
    };
    style = ''
      /* Nord Theme for SwayNC */

      @define-color current-line rgb(68, 71, 90);
      @define-color foreground rgb(248, 248, 242);
      @define-color subtext0 #a5adce;
      @define-color blue #8aadf4;

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
          font-family: "Maple Mono NF CN";
          font-weight: bold;
      }

      .control-center .notification-row:focus,
      .control-center .notification-row:hover {
          opacity: 1;
          background: @color4;
          border-radius: 10px
      }

      .notification-row {
          outline: none;
          margin: 0px;
      }

      .notification {
      	border-radius: 10px;
      }

      .notification-content {
      	/*color: @text-color;*/
          color: @color4;
          background: transparent;
          padding: 3px 10px 3px 6px;
          border-radius: 10px;
          border: 1px solid #c6d0f5;
          margin: 0px;
      }

      .notification-default-action {
          margin: 0;
          padding: 0;
          border-radius: 10px;
      }

      .close-button {
          background: @color0;
          color: @color4;
          text-shadow: none;
          padding: 0;
          border-radius: 10px;
          margin-top: 5px;
          margin-right: 5px;
      }

      .close-button:hover {
          box-shadow: none;
          background: @color1;
          transition: all .15s ease-in-out;
          border: none
      }


      .notification-action {
          border: 1px solid @color2;
          border-top: none;
          border-radius: 10px;
          background: @color4;
          color: @foreground;
      }

      .notification-default-action:hover,
      .notification-action:hover {
          background: @color3
      }


      .notification-default-action {
          border-radius: 10px;
          margin: 5px;
      }

      .notification-default-action:not(:only-child) {
          border-bottom-left-radius: 7px;
          border-bottom-right-radius: 7px
      }

      .notification-action:first-child {
          border-bottom-left-radius: 10px;
          background: @color4
      }

      .notification-action:last-child {
          border-bottom-right-radius: 10px;
          background: @color9
      }

      .inline-reply {
          margin-top: 8px
      }

      .inline-reply-entry {
          background: @color2;
          color: @color4;
          caret-color: @color2;
          border: 1px solid @color2;
          border-radius: 10px
      }

      .inline-reply-button {
      	font-size: 0.5rem;
          margin-left: 4px;
          background: @color2;
          border: 1px solid @color2;
          border-radius: 10px;
          color: @color4
      }

      .inline-reply-button:disabled {
          background: initial;
          color: @color4;
          border: 1px solid transparent
      }

      .inline-reply-button:hover {
          background: @color2
      }

      .body-image {
          margin-top: 6px;
          color: @color2;
          border-radius: 10px
      }

      .summary {
          font-size: 1rem;
          font-weight: bold;
          background: transparent;
          color: @color2;
          text-shadow: none
      }

      .time {
          font-size: 1rem;
          font-weight: bold;
          background: transparent;
          color: @foreground;
          text-shadow: none;
          margin-right: 18px
      }

      .body {
          font-size: 1rem;
          font-weight: bold;
          background: transparent;
          color: @color4;
          text-shadow: none
      }

      .control-center {
          background: @color2;
          border: 1px solid @color1;
      	  color: @color4;
          border-radius: 10px;
      }

      .control-center-list {
          background: transparent
      }

      .control-center-list-placeholder {
          opacity: 0.5
      }

      .floating-notifications {
          background: transparent;
          color: @color4
      }

      .blank-window {
          background: alpha(@color4, 0.1)
      }

      .widget-title {
          color: @color4;
          background: @color10;
          padding: 3px 6px;
          margin: 5px;
          font-size: 1rem;
          border-radius: 10px;
      }

      .widget-title>button {
          font-size: 0.75rem;
          color: @color2;
          border-radius: 10px;
      	background: transparent;
      	border: 0.5px solid @color1;
      }

      /* clear button */
      .widget-title>button:hover {
          background: @color2;
          color: @color4;
      }

      .widget-dnd {
          background: @color2;
          padding: 3px 6px;
          margin: 5px;
          border-radius: 10px;
          font-size: 1rem;
          color: @color4;
      }

      .widget-dnd>switch {
          border-radius: 10px;
          border: 1px solid @color1;
          background: @color10;
      }

      .widget-dnd>switch:checked {
          background: @color0;
          border: 1px solid @color2;
      }

      .widget-dnd>switch slider {
          background: @color2;
          border-radius: 10px
      }

      .widget-dnd>switch:checked slider {
          background: @color1;
          border-radius: 10px
      }

      .widget-label {
          margin: 5px;
      }

      .widget-label>label {
          font-size: 1rem;
          color: @color2;
      }

      .widget-mpris {
          color: @color4;
          background: @color2;
          padding: 3px 6px;
          margin: 5px;
          border-radius: 10px;
      }

      .widget-mpris > box > button {
          border-radius: 10px;
      }

      .widget-mpris-player {
          padding: 3px 6px;
          margin: 5px;
      }

      .widget-mpris-title {
          font-weight: 100;
          font-size: 1rem
      }

      .widget-mpris-subtitle {
          font-size: 0.75rem
      }

      .widget-buttons-grid {
          font-size: large;
      	  color: @color4;
          padding: 2px;
          margin: 5px;
          border-radius: 10px;
          background: @color2;
      }

      .widget-buttons-grid>flowbox>flowboxchild>button {
          margin: 1px;
          background: @color2;
          border-radius: 10px;
          color: @color4
      }

      /* individual buttons */
      .widget-buttons-grid>flowbox>flowboxchild>button:hover {
          background: @color10;
          color: @color1
      }

      .widget-menubar>box>.menu-button-bar>button {
          border: none;
          background: transparent
      }

      .topbar-buttons>button {
          border: none;
          background: transparent
      }

      .widget-volume {
          background: @color2;
          padding: 2px;
          margin: 10px 10px 5px 10px;
          border-radius: 10px;
          font-size: x-large;
          color: @color4
      }

      .widget-volume>box>button {
          background: @color5;
          border: none
      }

      .per-app-volume {
          background-color: @color2;
          padding: 4px 8px 8px;
          margin: 0 8px 8px;
          border-radius: 10px;
      	color: @color5
      }

      .widget-backlight {
          background: @color2;
          padding: 5px;
          margin: 10px 10px 5px 10px;
          border-radius: 10px;
          font-size: x-large;
          color: @color4
      }

      /* Make the different level message show different color */
      .low {
        background: @subtext0;
        padding: 0px;
        border-radius: 10px;
      }

      .normal {
        background: @blue;
        padding: 0px;
        border-radius: 10px;
      }

      .critical {
        background: red;
        padding: 0px;
        border-radius: 10px;
      }

    '';
  };
}
