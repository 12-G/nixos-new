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
in {
  imports = [
    # ./disko.nix
    ./boot.nix
    ./sys_config.nix
  ];

  services.sddm.enable = lib.mkForce false;
  services.inputsMethod.enable = lib.mkForce false;

  # Enable home-manager for our user
  home-manager.users."${vars.username}".imports = [
    self.homeModules.default
    # {
    #   config._module.args = {inherit isWSL;};
    # }
  ];
  users.users.${vars.username} = {
    isNormalUser = true;
    hashedPasswordFile = config.sops.secrets.ethan-password.path;
    extraGroups = [
      "wheel"
      "networkmanager"
    ]; # Enable ‘sudo’ for the user.
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = vars.ssh_authorized_keys;
  };
}
