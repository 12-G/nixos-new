{flake, ...}: let
  inherit (flake) inputs;
	inherit (flake) vars;
in {
  imports = with inputs; [
    inputs.nixos-wsl.nixosModules.default
  ];

	wsl = {
	  enable = true;
		wslConf.automount.root = "/mnt";
    defaultUser = vars.username;
		startMenuLaunchers = true;
	};

	nixpkgs.hostPlatform = {
	  system = "x86_64-linux";
	  };
}
