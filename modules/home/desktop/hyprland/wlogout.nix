{
  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "lock";
        action = "hyprlock";
        text = "Lock";
        keybind = "l";
      }
      {
        label = "reboot";
        action = "reboot";
        text = "Reboot";
        keybind = "r";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }
      {
        label = "logout";
        action = "hyprctl dispatch exit";
        text = "Log out";
        keybind = "e";
      }
      {
        label = "suspend";
        action = "systemctl suspend";
        text = "Suspend";
        keybind = "u";
      }
      {
        label = "hibernate";
        action = "systemctl hibernate";
        text = "Hibernate";
        keybind = "h";
      }
    ];

    style = ''
      /** ********** Fonts ********** **/
      * {
      	font-family: "Maple Mono NF CN";
      	font-size: 14px;
      	font-weight: bold;
      }

      /** ********** Main Window ********** **/
      window {
      	background-color: #1E1E2E;
      }

      /** ********** Buttons ********** **/
      button {
      	background-color: #242434;
      	color: #FFFFFF;
      	border: 2px solid #282838;
      	border-radius: 20px;
      	background-repeat: no-repeat;
      	background-position: center;
      	background-size: 35%;
      }

      button:focus, button:active, button:hover {
      	background-color: #89B4FA;
      	outline-style: none;
      }

      /** ********** Icons ********** **/
      #lock {
      	background-image: image(url("./lock.png"));
      }

      #logout {
      	background-image: image(url("./logout.png"));
      }

      #suspend {
      	background-image: image(url("./suspend.png"));
      }

      #hibernate {
        background-image: image(url("./hibernate.png"));
      }

      #shutdown {
      	background-image: image(url("./shutdown.png"));
      }

      #reboot {
      	background-image: image(url("./reboot.png"));
      }
    '';
  };
}
