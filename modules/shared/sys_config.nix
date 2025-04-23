{
  pkgs,
  flake,
  lib,
  ...
}: let
  inherit (flake) inputs;
  inherit (flake) vars;
  inherit (vars) pc;
in {
  networking.hostName = lib.mkDefault "${pc.t}";
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Set bluetooth
  hardware.bluetooth.enable = lib.mkDefault true;
  hardware.bluetooth.powerOnBoot = lib.mkDefault true;
  # Enable sound
  services.pipewire = {
    enable = lib.mkDefault true;
    pulse.enable = true;
  };

  services = {
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "prohibit-password";
        PasswordAuthentication = false;
      };
      openFirewall = true;
    };
    v2raya.enable = true;
    udisks2.enable = true;
  };

  programs = {
    screen.enable = true;
    ssh.startAgent = true;
    fish.enable = true;
  };

  environment.systemPackages = with pkgs; [
    git
    neovim
    curl
    wget
  ];

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  system.stateVersion = "24.11"; # Did you read the comment?
}
