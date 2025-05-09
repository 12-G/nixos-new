# See /modules/nixos/* for actual settings
# This file is just *top-level* configuration.
{
  flake,
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (flake) self;
  inherit (flake) vars;
  inherit (vars) pc;
  isNotWSL = config.networking.hostName != "${pc.w}";
in {
  imports = [
    ./sys_config.nix
    ./wsl.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_zen;
  services.sddm.enable = lib.mkForce false;
  services.inputsMethod.enable = lib.mkForce false;

  # Enable home-manager for our user
  home-manager.users."${vars.username}".imports = [
    (import self.homeModules.default {inherit isNotWSL;})
    # {
    #   config._module.args = {inherit isWSL;};
    # }
  ];
  users.users.${vars.username} = {
    isNormalUser = true;
    hashedPassword = null;
    extraGroups = [
      "wheel"
      "networkmanager"
    ]; # Enable ‘sudo’ for the user.
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = vars.ssh_authorized_keys;
  };
}
