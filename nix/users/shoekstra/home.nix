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
}
