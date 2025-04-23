{pkgs, ...}: {
  programs = {
    fish = {
      enable = true;
      generateCompletions = true;
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
      '';
      shellAbbrs = {
        ga = "git add";
        gl = "git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
        gs = "git status";
        l = "eza --icons --color -a -l --group-directories-first";
      };
      plugins = [
        # {
        #   name = "fisher";
        #   src = pkgs.fetchFromGitHub {
        #     owner = "jorgebucaran";
        #     repo = "fisher";
        #     rev = "1f0dc2b4970da160605638cb0f157079660d6e04";
        #     sha256 = "sha256-pR5RKU+zIb7CS0Y6vjx2QIZ8Iu/3ojRfAcAdjCOxl1U=";
        #   };
        # }
        {
          name = "autopair.fish";
          src = pkgs.fishPlugins.autopair.src;
        }
        {
          name = "puffer";
          src = pkgs.fishPlugins.puffer.src;
        }
        {
          name = "fzf.fish";
          src = pkgs.fishPlugins.fzf-fish.src;
        }
      ];
    };

    # Type `z <pat>` to cd to some directory
    zoxide.enable = true;

    # Better shell prmot!
    starship = {
      enable = true;
      settings = {
        character = {
          success_symbol = "[➜](#ca9ee6)";
          error_symbol = "[➜](#f38ba8)";
        };
      };
      enableFishIntegration = true;
      enableTransience = true;
    };
  };
}
