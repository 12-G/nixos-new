{flake, ...}: let
  inherit (flake) inputs;
in {
  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
  ];
  gtk = {
    enable = true;
  };
  catppuccin = {
    flavor = "frappe";
    enable = true;
    hyprlock.enable = false;
    wlogout.enable = false;
    swaync.enable = false;
    nvim.enable = false;
    gtk = {
      enable = true;
      accent = "lavender";
      flavor = "mocha";
      icon.enable = true;
      icon.flavor = "mocha";
      size = "standard";
      tweaks = ["normal"];
    };
    cursors = {
      accent = "lavender";
      enable = true;
      flavor = "frappe";
    };
  };
}
