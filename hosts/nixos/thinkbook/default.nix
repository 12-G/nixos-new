# See /modules/nixos/* for actual settings
# This file is just *top-level* configuration.
{
  flake,
  config,
  pkgs,
  ...
}: let
  inherit (flake) self;
  inherit (flake) vars;
  inherit (vars) pc;
  isNotWSL = config.networking.hostName != "${pc.w}";
in {
  imports = [
    ./desktop
    ./hardware-configuration.nix
    ./disko.nix
    ./secrets.nix
    ./boot.nix
    ./utils.nix
  ];

  # Enable home-manager for our user
  home-manager.users."${vars.username}".imports = [
    (import self.homeModules.default {inherit isNotWSL;})
    # {
    #   config._module.args = {inherit isWSL;};
    # }
  ];

  users.users.root.hashedPasswordFile = config.sops.secrets.root-password.path;
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
