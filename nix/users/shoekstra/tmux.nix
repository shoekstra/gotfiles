{ pkgs, ... }:

let
  tmux-onehalf-theme = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux-onehalf-theme";
    rtpFilePath = "main.tmux";
    version = "master";
    src = pkgs.fetchFromGitHub {
      owner = "andersondanilo";
      repo = "tmux-onehalf-theme";
      rev = "1a099d775c948bc1b72c16c05aca5fb2f1bd3c03";
      sha256 = "sha256-ExUJc14niGSNzqX3e1GjxZMv0y4gLmzfoQG0hzRFI5s=";
    };
  };

in {
  home.packages = with pkgs; [
    reattach-to-user-namespace
  ];

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    historyLimit = 50000;
    keyMode = "vi";
    mouse = true;
    prefix = "C-a";
    sensibleOnTop = false;
    terminal = "xterm-256color";

    extraConfig = ''
      # Switch to last window, screen style
      bind a send-prefix
      bind C-a last-window

      # Split current window and use cwd
      unbind %
      unbind '"'
      bind _ split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"

      # Window navigation
      unbind n
      unbind p
      bind -r C-h previous-window
      bind -r C-l next-window
      bind Tab last-window

      # Synchronise panes
      bind S set-window-option synchronize-panes

      # Reload config file
      bind r source ~/.config/tmux/tmux.conf \; display "tmux config sourced!"

      # Apply true color
      set-option -ga terminal-overrides ",xterm-256color:Tc"
    '';

    plugins = with pkgs; [
      # Waiting for https://github.com/NixOS/nixpkgs/pull/191517 to be merged
      (tmuxPlugins.sensible.overrideAttrs ( _: {
        version = "unstable-2022-08-14";
        src = fetchFromGitHub {
          owner = "tmux-plugins";
          repo = "tmux-sensible";
          rev = "25cb91f42d020f675bb0a2ce3fbd3a5d96119efa";
          sha256 = "sha256-sw9g1Yzmv2fdZFLJSGhx1tatQ+TtjDYNZI5uny0+5Hg=";
        };
      }))
      tmuxPlugins.better-mouse-mode
      tmuxPlugins.cpu
      {
        plugin = tmux-onehalf-theme; # This wants to be loaded last
      }
    ];
  };
}
