{
  self,
  lib,
  ...
}: {
  config = let
    # Combine mapAttrs' and filterAttrs
    #
    # f can return null if the attribute should be filtered out.
    mapAttrsMaybe = f: attrs:
      lib.pipe attrs [
        (lib.mapAttrsToList f)
        (builtins.filter (x: x != null))
        builtins.listToAttrs
      ];
    forAllNixFiles = dir: f:
      if builtins.pathExists dir
      then
        lib.pipe dir [
          builtins.readDir
          (mapAttrsMaybe (
            fn: type:
              if type == "regular"
              then let
                name = lib.removeSuffix ".nix" fn;
              in
                lib.nameValuePair name (f "${dir}/${fn}")
              else if type == "directory" && builtins.pathExists "${dir}/${fn}/default.nix"
              then lib.nameValuePair fn (f "${dir}/${fn}")
              else null
          ))
        ]
      else {};
  in {
    flake = {
      darwinConfigurations = forAllNixFiles "${self}/hosts/darwin" (
        # auto pass the file or directory to the mkLinuxSystem function
        fn:
          self.lib.mkMacosSystem {
            # home-manager = true;
            # wsl = false;
          }
          fn
      );

      nixosConfigurations = forAllNixFiles "${self}/hosts/nixos" (
        # auto pass the file or directory to the mkLinuxSystem function
        fn:
          self.lib.mkLinuxSystem {
            # home-manager = true;
            # wsl = false;
          }
          fn
      );

      darwinModules = forAllNixFiles "${self}/modules/darwin" (fn: fn);

      nixosModules = forAllNixFiles "${self}/modules/nixos" (fn: fn);

      sharedModules = forAllNixFiles "${self}/modules/shared" (fn: fn);

      homeModules = forAllNixFiles "${self}/modules/home" (fn: fn);

      overlays = forAllNixFiles "${self}/overlays" (fn: import fn self.lib.specialArgsFor.common);
    };

    perSystem = {pkgs, ...}: {
      legacyPackages.homeConfigurations = forAllNixFiles "${self}/hosts/home" (
        fn: self.lib.mkHomeConfiguration pkgs fn
      );
    };
  };
}
