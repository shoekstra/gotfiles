{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    reattach-to-user-namespace
    tmux
  ];

  home.file = {
    ".tmux.conf".source = pkgs.fetchFromGitHub {
       owner = "gpakosz";
       repo = ".tmux";
       rev = "7706ab724f3811479a358c6f9ea6aeb6decece5f";
       sha256 = "sha256-o126SathIT49Mj9EZDhlYF5i3EgRe2HFZkoGXTVQBbw=";
    } + "/.tmux.conf";

    ".tmux.conf.local".source = ../../../files/tmux/tmux.conf.local;
  };
}
