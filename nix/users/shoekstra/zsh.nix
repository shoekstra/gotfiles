{ config, pkgs, ... }:

let

  lib = import ../../lib;

in {

  programs.zsh = {
    enable = true;

    envExtra = (builtins.readFile (lib.dotFilePath "zsh/zshenv"));
    initExtraFirst = (builtins.readFile (lib.dotFilePath "zsh/zshrc"));

    autocd = true;

    history = {
      extended = true;
      expireDuplicatesFirst = true;
      ignoreDups = true;
      save = 50000;
      size = 50000;
    };

    sessionVariables = {
      # Use Neovim as the default editor
      EDITOR = "nvim";
      
      # Set locale
      LANG = "en_GB.UTF-8";
      LC_ALL = "en_GB.UTF-8";
      LANGUAGE = "en_GB.UTF-8";

      # Configure gitcd plugin
      GITCD_HOME = "$HOME/git";
      GITCD_USEHOST = "false";

      # Install new terraform versions without prompting
      CHTF_AUTO_INSTALL = "yes";
    };

    shellAliases = {
      # Old habits die hard
      vim = "nvim -O";
      vimdiff = "nvim -d";

      # Use a coloured ls
      ls = "ls -A --color=auto";
      l = "ls";
      ll = "ls -l";

      # Git aliases missing from plugin
      gcopdm = "() { gco $1 && git pull origin $1 && (git branch --merged | grep -v '\*' | xargs -n 1 git branch -d) }";
      gfo = "gf origin";
      gpo = "git pull origin";
      grom = "gr origin/master";
      gsuk = "gsw"; # This just makes more sense to me
      gwds = "gwd --staged";

      tree = "tree -a -I .git";
    };

    shellGlobalAliases = {
      G = "| grep";
      GI = "| grep -i";
      S = "| sort";
    };
  };

  home.file = {
    ".p10k.zsh".source = lib.dotFilePath "zsh/p10k.zsh";
    ".zaliases".source = lib.dotFilePath "zsh/zaliases";
    ".zfunctions".source = lib.dotFilePath "zsh/zfunctions";
  };
}
