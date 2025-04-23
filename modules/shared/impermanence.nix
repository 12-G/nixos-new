{
  config,
  lib,
  flake,
  ...
}: let
  inherit (flake) inputs;
  inherit (flake) vars;
  cfg = config.programs.impermanence;
in {
  imports = [inputs.impermanence.nixosModules.impermanence];
  options.programs.impermanence = {
    enable = lib.mkEnableOption "enable impermanence";
  };
  config = lib.mkIf cfg.enable {
    fileSystems."/persist".neededForBoot = true;
    environment.persistence."/persist/${config.networking.hostName}" = {
      hideMounts = true;
      directories = [
        # /var/db/sudo store the sudo warning information
        "/var"
        "/etc/v2raya"
        "/etc/NetworkManager/system-connections"
      ];
      files = [
        "/etc/machine-id"
        "/etc/ssh/ssh_host_ed25519_key.pub"
        "/etc/ssh/ssh_host_ed25519_key"
        "/etc/ssh/ssh_host_rsa_key.pub"
        "/etc/ssh/ssh_host_rsa_key"
      ];

      users.${vars.username} = {
        directories = [
          "Downloads"
          "Pictures"
          "Documents"
          "Videos"
          "flakes"
          "ethan"
          ".config"
          ".local"
          ".ssh"
        ];
      };
    };
  };
}
