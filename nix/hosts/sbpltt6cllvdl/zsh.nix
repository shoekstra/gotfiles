{ config, pkgs, ... }:

{

  # Use existing dotfiles until moving to a nix native way of managing zsh.
  home.file = {
    ".fzf.zsh".source = ../../../files/zsh/fzf.zsh;
    ".p10k.zsh".source = ../../../files/zsh/p10k.zsh;
    ".zaliases".source = ../../../files/zsh/zaliases;
    ".zfunctions".source = ../../../files/zsh/zfunctions;
    ".zimrc".source = ../../../files/zsh/zimrc;
    ".zsh-dircolors.config".source = ../../../files/zsh/zsh-dircolors.config;
    ".zshenv".source = ../../../files/zsh/zshenv;
    ".zshrc".source = ../../../files/zsh/zshrc;
  };
}
