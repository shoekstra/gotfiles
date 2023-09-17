{ pkgs, ... }:

{
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
      bind-key a send-prefix
      bind-key C-a last-window

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
    ];
  };
}
