{
  inputs,
  self,
  ...
}: {
  perSystem = {
    pkgs,
    system,
    self',
    ...
  }: let
    source = pkgs.fetchFromGitHub {
      owner = "3timeslazy";
      repo = "nix-search-tv";
      rev = "2068e08314c2f01cc99d9bb8db53030dc9bb8ad3";
      hash = "sha256-9tOrEcSZ6chVKq82zCoFCy3as71p5k7poXXFO/mXhw0=";
    };
    ns = pkgs.writeShellScriptBin "ns" (builtins.readFile "${source}/nixpkgs.sh");
  in {
    formatter = pkgs.alejandra;
    checks = {
      pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
        src = self;
        hooks = {
          alejandra.enable = true;
        };
      };
    };

    devShells = {
      default = pkgs.mkShell {
        inherit (self.checks.${system}.pre-commit-check) shellHook;
        name = "nix dev";
        packages = with pkgs; [
          just
          nurl
          ns
          nix-search-tv
          nix-tree
          sops
          yamlfmt
          lua-language-server
        ];
      };
    };
  };
}
