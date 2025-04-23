{
  stdenv,
  lib,
  fetchFromGitHub,
  myKernel,
}: let
  myPatch = fetchFromGitHub {
    # owner = "ty2";
    # repo = "ideapad-laptop-tb2024g6plus";
    # rev = let
    #   commit = "6d934407981294d05a6a4e4ed0e59d3c6c964990";
    #   patchKernelVersion = "6.10";
    # in
    #   lib.warnIf (myKernel.version != patchKernelVersion)
    #   "ideapad-laptop-tb2024g6plus is for ${patchKernelVersion} but your kernel is ${myKernel.version}"
    #   commit;
    # hash = "sha256-PzgfAxVrp4rhP6d/pQlzwIyXdi5FcoLLrqoETldGdqU=";
    # compatible with the kernel 6.13
    owner = "ty2";
    repo = "ideapad-laptop-tb2024g6plus";
    rev = "37c24fa7013efe546bbb53f6602454f8ccfd0314";
    hash = "sha256-WKH8D7UUGyCGHK+xUtV7JhLm6gmqsnaLYDYOU1DnvZY=";
  };
in
  stdenv.mkDerivation {
    pname = "ideapad-laptop-tb2024g6plus";
    inherit
      (myKernel)
      src
      version
      postPatch
      nativeBuildInputs
      ;

    kernel_dev = myKernel.dev;
    kernelVersion = myKernel.modDirVersion;

    modulePath = "drivers/platform/x86";

    prePatch = ''
      echo patch ideapad-laptop using tb2024g6plus
      cp ${myPatch}/ideapad-laptop-tb2024g6plus.c $modulePath/ideapad-laptop.c
      cp ${myPatch}/ideapad-laptop-tb2024g6plus.h $modulePath
    '';

    buildPhase = ''
      runHook preBuild

      BUILT_KERNEL=$kernel_dev/lib/modules/$kernelVersion/build

      cp $BUILT_KERNEL/Module.symvers .
      cp $BUILT_KERNEL/.config        .
      cp $kernel_dev/vmlinux          .

      make "-j$NIX_BUILD_CORES" modules_prepare
      make "-j$NIX_BUILD_CORES" M=$modulePath modules

      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall

      make \
        INSTALL_MOD_PATH="$out" \
        XZ="xz -T$NIX_BUILD_CORES" \
        M="$modulePath" \
        modules_install

      outd=$out/lib/modules/$kernelVersion/updates
      module=ideapad-laptop.ko.xz
      mv $outd/$module ./
      rm -r $outd/*
      mv $module $outd

      runHook postInstall
    '';
  }
