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
  networking.hostName = lib.mkForce "${pc.w}";
  programs.dconf.enable = true;

  # Set bluetooth
  hardware.bluetooth.enable = lib.mkForce false;
  hardware.bluetooth.powerOnBoot = lib.mkForce false;
  # Enable sound
  services.pipewire = {
    enable = lib.mkForce false;
    pulse.enable = true;
  };
}
