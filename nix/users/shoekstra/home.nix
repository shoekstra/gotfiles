{ config, pkgs, ... }:

let
  imports = [
    ./nvim.nix
    ./tmux.nix
    ./zsh.nix
  ];

in {

  inherit imports;

  # You cannot install or search for an unfree package unless explicitly enabling
  # it with the following:
  nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "shoekstra";
  home.homeDirectory = "/Users/shoekstra";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "22.11"; # Please read the comment before changing.

  home.sessionVariables = {
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Packages with modules to configure them.
  programs = {
    bat = {
      enable = true;

      config.theme = "OneHalfDark";
    };

    git = {
      enable = true;

      userName = "Stephen Hoekstra";
      userEmail = "shoekstra@schubergphilis.com";

      aliases = {
        personal = "config user.email stephenhoekstra@gmail.com";
        unstage = "reset HEAD --";
      };

      extraConfig = {
        core.whitespace = "trailing-space,space-before-tab";
        credential.helper = "osxkeychain";
      };

      signing.key = "DBB82B1442BFA582";
    };
  };

  programs.gh-dash.enable = true;
  programs.gh.enable = true;
  programs.gpg.enable = true;
  programs.htop.enable = true;
  programs.k9s.enable = true;
  programs.lazygit.enable = true;

  # Packages without modules to configure them.
  home.packages = with pkgs; [
    fpp
    jq
    mc
    rename
    tree
    yq-go
  ];
}
