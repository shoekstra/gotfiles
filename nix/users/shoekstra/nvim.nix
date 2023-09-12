{ config, pkgs, ... }:

let

  lib = import ../../lib;

in {
  home.packages = with pkgs; [
    neovim
    (python3.withPackages(ps: with ps; [ pynvim ]))

    # Packages used by neovim config
    hadolint
    nodePackages.markdownlint-cli
    shellcheck
    tree-sitter
  ];

  home.file = {
    ".config/nvim".source = lib.dotFilePath "neovim";
    ".config/nvim".recursive = true;
  };
}
