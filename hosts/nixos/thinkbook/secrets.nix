{
  flake,
  config,
  ...
}: let
  inherit (flake) inputs;
  inherit (flake) self;
in {
  imports = [inputs.sops-nix.nixosModules.sops];

  sops.secrets.ethan-password.neededForUsers = true;
  sops.secrets.root-password.neededForUsers = true;
  sops = {
    defaultSopsFile = self + /secrets/secrets.yaml;
    age.sshKeyPaths = ["/persist/${config.networking.hostName}/etc/ssh/ssh_host_ed25519_key"];
    age.generateKey = true;
    age.keyFile = "/persist/${config.networking.hostName}/var/lib/sops-nix/key.txt";
  };

  sops.secrets.ethan-password = {};
}
