{
  pkgs,
  config,
  ...
}: {
  # solve the problem that close the laptop lid and it powers off.
  boot.extraModulePackages = [
    (pkgs.callPackage ./ideapad-laptop-tb2024g6plus.nix {
      myKernel = config.boot.kernelPackages.kernel;
    })
  ];

  # solve the problem that cannot use touchpad.
  # environment.etc."libinput/local-overrides.quirks".source = let
  #   src = pkgs.fetchFromGitHub {
  #     owner = "ty2";
  #     repo = "goodix-gt7868q-linux-driver";
  #     rev = "62f0d1898599c151a8245bc2fb7a7dcf931863b4";
  #     hash = "sha256-WukC3iK05eRmr/EalH75E4Y9dxOU2LIl2jtBB4lw1fg=";
  #   };
  # in "${src}/local-overrides.quirks";
}
