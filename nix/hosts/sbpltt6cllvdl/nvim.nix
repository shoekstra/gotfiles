{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    neovim
    (python3.withPackages(ps: with ps; [ pynvim ]))
  ];

  home.file = {
    ".config/nvim".source = ../../../files/neovim;
    ".config/nvim".recursive = true;
  };
}
