{flake, ...}: let
  inherit (flake) vars;
in {
  home.shellAliases = {
    g = "git";
    lg = "lazygit";
  };

  # https://nixos.asia/en/git
  programs = {
    git = {
      enable = true;
      userName = vars.fullname;
      userEmail = vars.email;
      ignores = [
        "*~"
        "*.swp"
      ];
      aliases = {
        ci = "commit";
      };
      extraConfig = {
        init.defaultBranch = "main";
        # pull.rebase = "false";
      };
    };
    lazygit.enable = true;
  };
}
