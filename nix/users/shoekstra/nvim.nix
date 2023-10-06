{ config, pkgs, ... }:

let

  lib = import ../../lib;

in {
  home.packages = with pkgs; [
    neovim
    (python3.withPackages(ps: with ps; [ pynvim ]))

    # Packages used by neovim config
    fd
    # hadolint -- has a broken dependency, will look into it another time
    nodePackages.markdownlint-cli
    nodePackages.prettier
    nodejs_20
    ripgrep
    shellcheck
    tree-sitter
  ];

  home.file = {
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/git/shoekstra/gotfiles/files/neovim"
    ;
  };
}
