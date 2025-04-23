{
  config,
  flake,
  ...
}: let
  inherit (flake) inputs;
  inherit (flake) self;
in {
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];
  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

    defaultSopsFile = self + /secrets/secrets.yaml;

    secrets = {
    };
  };
}
