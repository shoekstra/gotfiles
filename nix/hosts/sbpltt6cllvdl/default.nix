{ pkgs, ... }:

{
  # Make sure the nix daemon always runs
  services.nix-daemon.enable = true;

  # If you use zsh you'll need to enable this so nix-darwin creates a zshrc sourcing needed environment changes
  programs.zsh.enable = true;

  homebrew.enable = true;
  homebrew.casks = [
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users."shoekstra" = import ./home.nix;

  # This needs to be to set for things to work (see https://github.com/LnL7/nix-darwin/issues/423)
  users.users."shoekstra" = {
    home = "/Users/shoekstra";
  };
}
