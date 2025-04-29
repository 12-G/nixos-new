{
  pkgs,
  flake,
  ...
}: let
  inherit (flake) inputs;
in {
  home.packages = with pkgs; [
    # Unix tools
    sd
    tree

    # archive
    zip
    unzip
    p7zip
    # Nix dev
    cachix
    nil # Nix language server
    nix-info
    alejandra
    # On ubuntu, we need this less for `man home-configuration.nix`'s pager to
    # work.
    less
    tldr
  ];

  # Programs natively supported by home-manager.
  # They can be configured in `programs.*` instead of using home.packages.
  programs = {
    # fetch system info
    fastfetch.enable = true;
    # better 'ls'
    eza = {
      enable = true;
      enableFishIntegration = true;
    };
    # better 'grep'
    ripgrep = {
      enable = true;
      arguments = [
        "--hidden"
        "--glob=!.git/*"
      ];
    };
    # better find
    fd = {
      enable = true;
      hidden = true;
    };
    # Better `cat`
    bat.enable = true;
    # Type `<ctrl> + r` to fuzzy search your shell history
    fzf = {
      enable = true;
      enableFishIntegration = true;
      defaultOptions = [
        "--style full"
        "--layout reverse"
        "--preview 'bat --color=always --theme gruvbox-dark {}'"
        "--bind 'focus:transform-header:file --brief {}'"
      ];
    };
    jq.enable = true;
    # Install btop https://github.com/aristocratos/btop
    btop = {
      enable = true;
      settings = {
        vim_keys = true;
      };
    };
    # File manager
    yazi = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        show_hidden = true;
      };
    };
    neovim = {
      enable = true;
      package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
      viAlias = true;
      vimAlias = true;
    };
    # Tmate terminal sharing.
    # tmate = {
    #   enable = true;
    #   #host = ""; #In case you wish to use a server other than tmate.io
    # };
    # };
  };
}
